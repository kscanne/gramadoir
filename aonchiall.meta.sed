# This sed script is used for converting the hopefully-user-readable
# aonchiall.in into the somewhat complicated aonchiall.pl
# It only needs to be changed if the grammar of the .in file changes
# or new tags are added, etc.
/^#/d
s/^ *<B>\([^<]*\)<\/B> *<\([^^>]*\)> *<\([A-Z]\)> *$/s\/<B><Z>[^Z]*<\\\/Z>(\1)<\\\/B> (<B><Z>(<\2[^>]*>)+<\\\/Z>[^<]+<\\\/B>)\/<\3>$1<\\\/\3> $2\/g;\ns\/<B><Z>[^Z]*<\\\/Z>(\1)<\\\/B> <(\2)\/<\3>$1<\\\/\3> <$2\/g;/
s/^ *<B>\([^<]*\)<\/B> *<\[^\([A-Z]*\)\]*> *<\([A-Z]\)> *$/s\/<B><Z>[^Z]*<\\\/Z>(\1)<\\\/B> (<B><Z>(<[^\2][^>]*>)+<\\\/Z>[^<]+<\\\/B>)\/<\3>$1<\\\/\3> $2\/g;\ns\/<B><Z>[^Z]*<\\\/Z>(\1)<\\\/B> <([^B\2])\/<\3>$1<\\\/\3> <$2\/g;/
