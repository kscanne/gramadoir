# Makefile for gramadoir
# Copyright (C) 2003 Kevin P. Scannell
# Released under the GNU Public License
# See the file COPYING for more information.

# AIBHSIGH=glark -q -N
AIBHSIGH=egrep --color -h

prefix = /usr/local
SHELL = /bin/sh
PERL = /usr/bin/perl
CC = gcc
CFLAGS = -g
RELEASE = 0.1pre1
APPNAME_ASCII = gramadoir
APPNAME = $(APPNAME_ASCII)-$(RELEASE)
# non-root users can change next three to "cp" and next to "mkdir" in a pinch
INSTALL = /usr/bin/install
INSTALL_PROGRAM = $(INSTALL)
INSTALL_DATA = $(INSTALL) -m 644
INSTALL_DIR = $(INSTALL) -d
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
libexecdir = $(exec_prefix)/libexec
datarootdir = $(prefix)/share
datadir = $(datarootdir)/$(APPNAME_ASCII)
webhome = $(HOME)/public_html/gramadoir

all : aonchiall.pl eisceacht.pl rialacha.pl cuardach gr

gr : gr.in
	rm -f gr
	awk '{sub(/__AIBHSIGH_/, "$(AIBHSIGH)"); sub(/__RELEASE_/, "$(RELEASE)"); sub(/__libexecdir_/, "$(libexecdir)"); print}' gr.in > gr
	chmod 555 gr

cuardach : cuardach.o
	rm -f cuardach
	$(CC) -o cuardach $(CFLAGS) cuardach.o
	chmod 555 cuardach
	
cuardach.o : cuardach.c
	$(CC) -c $(CFLAGS) -DBSONRAI=\"$(datadir)/focail.bs\" cuardach.c

rialacha.pl : rialacha.in rialacha.meta.sed gin.meta.sed
	rm -f rialacha.pl
	(echo "#!$(PERL)"; echo '# Users should modify rialacha.in, not this file'; echo 'while(<>){';  cat rialacha.in | sed -f gin.meta.sed | sed -f rialacha.meta.sed; echo 'print;'; echo '}'; echo 'exit;') > rialacha.pl
	chmod 555 rialacha.pl

aonchiall.pl : aonchiall.in aonchiall.meta.sed gin.meta.sed
	rm -f aonchiall.pl
	(echo "#!$(PERL)"; echo '# Users should modify aonchiall.in, not this file'; echo 'while(<>){'; cat aonchiall.in | sed -f gin.meta.sed | sed -f aonchiall.meta.sed; echo 'print;'; echo '}'; echo 'exit;') > aonchiall.pl
	chmod 555 aonchiall.pl

eisceacht.pl : eisceacht.in eisceacht.meta.sed gin.meta.sed
	rm -f eisceacht.pl
	(echo "#!$(PERL)"; echo '# Users should modify eisceacht.in, not this file'; echo 'while(<>){'; cat eisceacht.in | sed -f gin.meta.sed | sed -f eisceacht.meta.sed; echo 'print;'; echo '}'; echo 'exit;') > eisceacht.pl
	chmod 555 eisceacht.pl

check : all
	@./gr triail > triail.tmp
	@if diff triail.tmp triail.err; then echo 'Ceart go leor.'; else echo 'Fadhb.'; fi
	@rm -f triail.tmp


install : all
	$(INSTALL_DIR) $(datadir)
	$(INSTALL_DATA) focail.bs $(datadir)
	$(INSTALL_DIR) $(libexecdir)
	$(INSTALL_PROGRAM) cuardach $(libexecdir)
	$(INSTALL_PROGRAM) hilite.awk $(libexecdir)
	$(INSTALL_PROGRAM) aonchiall.pl $(libexecdir)
	$(INSTALL_PROGRAM) eisceacht.pl $(libexecdir)
	$(INSTALL_PROGRAM) rialacha.pl $(libexecdir)
	$(INSTALL_DIR) $(bindir)
	$(INSTALL_PROGRAM) gr $(bindir)

uninstall :
	rm -f $(datadir)/focail.bs
	rm -f $(libexecdir)/cuardach
	rm -f $(libexecdir)/hilite.awk
	rm -f $(libexecdir)/aonchiall.pl
	rm -f $(libexecdir)/eisceacht.pl
	rm -f $(libexecdir)/rialacha.pl
	rm -f $(bindir)/gr

installweb :
	$(INSTALL_DATA) cuidiu.html $(webhome)
	$(INSTALL_DATA) index.html $(webhome)
	$(INSTALL_DATA) iompar.html $(webhome)
	$(INSTALL_DATA) sios.html $(webhome)
	$(INSTALL_DATA) sonrai.html $(webhome)
	$(INSTALL_DATA) sampla.html $(webhome)
	$(INSTALL_DATA) gramadoir.dtd $(webhome)/../dtds

triail.html : all triail
	./gr --html triail > triail.html

distclean :
	rm -f triail.html cuardach cuardach.o rialacha.pl aonchiall.pl eisceacht.pl gr cabhair.o cabhair triail.err.old

clean :
	rm -f triail.html cuardach cuardach.o rialacha.pl aonchiall.pl eisceacht.pl gr cabhair.o cabhair triail.err.old

maintainer-clean :
	make distclean
	rm -f focail.bs triail.err

dist : triail.err
	ln -s gr ../$(APPNAME)
	tar cvhf $(APPNAME).tar -C .. $(APPNAME)/aonchiall.in
	tar rvhf $(APPNAME).tar -C .. $(APPNAME)/aonchiall.meta.sed
	tar rvhf $(APPNAME).tar -C .. $(APPNAME)/cabhair.c
	tar rvhf $(APPNAME).tar -C .. $(APPNAME)/COPYING
	tar rvhf $(APPNAME).tar -C .. $(APPNAME)/cuardach.c
	tar cvhf $(APPNAME).tar -C .. $(APPNAME)/eisceacht.in
	tar rvhf $(APPNAME).tar -C .. $(APPNAME)/eisceacht.meta.sed
	tar rvhf $(APPNAME).tar -C .. $(APPNAME)/focail.bs
	tar rvhf $(APPNAME).tar -C .. $(APPNAME)/gin.meta.sed
	tar rvhf $(APPNAME).tar -C .. $(APPNAME)/gr.in
	tar rvhf $(APPNAME).tar -C .. $(APPNAME)/gramadoir.dtd
	tar rvhf $(APPNAME).tar -C .. $(APPNAME)/hilite.awk
	tar rvhf $(APPNAME).tar -C .. $(APPNAME)/Makefile
	tar rvhf $(APPNAME).tar -C .. $(APPNAME)/README
	tar rvhf $(APPNAME).tar -C .. $(APPNAME)/rialacha.in
	tar rvhf $(APPNAME).tar -C .. $(APPNAME)/rialacha.meta.sed
	tar rvhf $(APPNAME).tar -C .. $(APPNAME)/triail
	tar rvhf $(APPNAME).tar -C .. $(APPNAME)/triail.err
	gzip $(APPNAME).tar
	chmod 444 $(APPNAME).tar.gz
	rm -f ../$(APPNAME)

triail.err : all triail
	mv -f triail.err triail.err.old
	./gr triail > triail.err
	- diff triail.err.old triail.err

focail.bs : FORCE
	make cabhair
	Gin 12
	(cat ${HOME}/.ispell_gaeilge ${HOME}/.biobla | sed 's/.*/& 44/'; cat FOCAIL) | LC_COLLATE=POSIX sort -u > FOCAIL.all
	cat FOCAIL.all | ./cabhair > focail.bs
	chmod 644 focail.bs
	@echo 'Verify count in cuardach.c:' 
	@echo `cat FOCAIL.all | sed 's/ [0-9]*//' | uniq | wc -l`
	rm -f FOCAIL FOCAIL.all

cabhair : cabhair.o
	$(CC) -o cabhair $(CFLAGS) cabhair.o
	
cabhair.o : cabhair.c
	$(CC) -c $(CFLAGS) cabhair.c

FORCE :
