#!/usr/bin/perl
# This perl script is used for converting the hopefully-user-readable
# *.in files into the somewhat complicated *.pl scripts
# Copyright (C) 2004 Kevin P. Scannell <scannell@slu.edu>
#
# This is free software; see the file COPYING for copying conditions.  There is
# NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
if ( m/^[^:#]/ ) {
	chomp;
	s/\(/(?:/g;
	s/<\[\^([A-DF-Z]*)\]>([^<]+)<\/[^>]*>/(?:<[^\\\/$1][^>]*>$2<\\\/[^$1]>|<B><Z>(?:<[^$1][^>]*>)+<\\\/Z>$2<\\\/B>)/g;
	s/<\[([A-DF-Z]*)\]>([^<]+)<\/[^>]*>/(?:<[$1][^>]*>$2<\\\/[$1]>|<B><Z>(?:<[$1][^>]*>)+<\\\/Z>$2<\\\/B>)/g;
	s/<([CDFIQRSTUXY])>([^<]+)<\/[A-Z]>/<$1>$2<\\\/$1>/g;
	s/<([ANOPV])([^>]*)>([^<]+)<\/[A-Z][^>]*>/(?:<${1}[^>]*${2}[^>]*>$3<\\\/$1>|<B><Z>(?:<${1}[^>]*${2}[^>]*>)+<\\\/Z>$3<\\\/B>)/g;
	s/ /  /g;
	s/^/ /;
	s/$/ /;
	s/ ([^(< ][^ ]*) / (?:<[\\\/A-DF-Z][^>]*>)+$1<\\\/[A-DF-Z]> /g;
	s/\+([^(<]*\|[^(<]*)</+(?:$1)</g;
	s/ $//;
	s/^ //;
	s/  / /g;
	print;
}
elsif ( m/^:/ ) {
	print;
}
