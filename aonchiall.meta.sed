# This sed script is used for converting the hopefully-user-readable
# aonchiall.in into the somewhat complicated aonchiall.pl
# It only needs to be changed if the grammar of the .in file changes
# or new tags are added, etc.
s/^\(.*\)<B>\(.*\)<\/B>\(.*\):<\([A-Z]\)\([^>]*\)>$/s\/(\1)<B><Z>(<[^>]*>)+(\2)<\\\/B>(\3)\/$1<\4\5>$3<\\\/\4>$4\/g;/g
