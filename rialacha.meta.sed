# This sed script is used for converting the hopefully-user-readable
# rialacha.in into the somewhat complicated rialacha.pl
# It only needs to be changed if the grammar of the .in file changes
# or new tags are added, etc.
s/\([^:]*\):\([^ ]*\)/s\/(\1)\/<E msg="\2">$1<\\\/E>\/g;/
