# This sed script is used for converting the hopefully-user-readable
# aonchiall.in into the somewhat complicated aonchiall.pl
# It only needs to be changed if the grammar of the .in file changes
# or new tags are added, etc.
# Copyright (C) 2003 Kevin P. Scannell <scannell@slu.edu>
#
# This is free software; see the file COPYING for copying conditions.  There is
# NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
s/^\(.*\)<B>\(.*\)<\/B>\(.*\):<\([A-DF-Z]\)\([^>]*\)> *$/s\/(\1)<B><Z>(<[^>]*>)+(\2)<\\\/B>(\3)\/$1<\4\5>$3<\\\/\4>$4\/g;/
