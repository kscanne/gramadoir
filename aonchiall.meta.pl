# This script is used for converting the hopefully-user-readable
# aonchiall-xx.in into the somewhat complicated aonchiall-xx.pl
# It only needs to be changed if the grammar of the .in file changes
# or new tags are added, etc.
# Copyright (C) 2004, 2005 Kevin P. Scannell <kscanne@gmail.com>
#
# This is free software; see the file COPYING for copying conditions.  There is
# NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
while (<STDIN>) {
	if (/:!/) {
		s/^(.*)<B><Z>(.*)<\/Z>(.*)<\/B>(.*):!(<.+)> *$/s\/($1)<B><Z>($2)<\\\/Z>($3)<\\\/B>($4)\/"\$1".strip_badpos(\$2,\$3,'$5.>')."\$4"\/eg;/;
		s/^(.*)<B>(.*)<\/B>(.*):!(<.+)> *$/s\/($1)<B><Z>((?:<[^>]+>)+)<\\\/Z>($2)<\\\/B>($3)\/"\$1".strip_badpos(\$2,\$3,'$4.>')."\$4"\/eg;/;
	}
	else {
		s/^(.*)<B><Z>(.*)<\/Z>(.*)<\/B>(.*):<([A-DF-Z])([^>]*)> *$/s\/($1)<B><Z>$2<\\\/Z>($3)<\\\/B>($4)\/\$1<$5$6>\$2<\\\/$5>\$3\/g;/;
		s/^(.*)<B>(.*)<\/B>(.*):<([A-DF-Z])([^>]*)> *$/s\/($1)<B><Z>(?:<[^>]+>)+<\\\/Z>($2)<\\\/B>($3)\/\$1<$4$5>\$2<\\\/$4>\$3\/g;/;
	}
	print;
}
