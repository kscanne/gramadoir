# This sed script is used for converting the hopefully-user-readable
# rialacha-xx.in into the somewhat complicated rialacha-xx.pl
# It only needs to be changed if the grammar of the .in file changes
# or new tags are added, etc.
# Copyright (C) 2003, 2004 Kevin P. Scannell <scannell@slu.edu>
#
# This is free software; see the file COPYING for copying conditions.  There is
# NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
s/\|<B><Z>[^+]+\+<\\\/Z>[^\/]+\/B>//g;
s/\(\?:<\[\\\/A-DF-Z\]\[^>\]\*>\)\+/<[A-DF-Z][^>]*>/g;
if (/:OK *$/) {
#	s/^/s\/<E[^>]*>(/;
#	s/:OK *$/)<\\\/E>\/\$1\/g;/;
	unless (/<E>/) {
		s/^/<E>/;
		s/:OK/<\\\/E>:OK/;
	}
	s/<E>/<E[^>]*>/;
	s/^/s\/(/;
	s/:OK *$/)\/strip_errors(\$1);\/eg;/;
}
else {
	s/^(.+[^?]):(.*)/s\/(?<![<>])($1)(?![<>])\/<E msg="$2">\$1<\\\/E>\/g;/;
}
