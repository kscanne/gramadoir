# This script is used for converting the hopefully-user-readable
# comhshuite-xx.in into the somewhat complicated comhshuite-xx.pl
# It only needs to be changed if the grammar of the .in file changes
# or new tags are added, etc.
# Copyright (C) 2004 Kevin P. Scannell <scannell@slu.edu>
#
# This is free software; see the file COPYING for copying conditions.  There is
# NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
while (<STDIN>) {
	s/^([^+]*\+)([^<]*)(<[^+]*\+)([^<]*)([^:+]*):<([A-Z])([^>]*)>/s\/$1($2)$3($4)$5\/<$6$7>\$1 \$2<\\\/$6>\/g;/;
	s/^([^+]*\+)([^<]*)(<[^+]*\+)([^<]*)(<[^+]*\+)([^<]*)([^:+]*):<([A-Z])([^>]*)>/s\/$1($2)$3($4)$5($6)$7\/<$8$9>\$1 \$2 \$3<\\\/$8>\/g;/;
	print;
}
