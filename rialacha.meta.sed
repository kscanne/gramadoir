# This sed script is used for converting the hopefully-user-readable
# rialacha.in into the somewhat complicated rialacha.pl
# It only needs to be changed if the grammar of the .in file changes
# or new tags are added, etc.
# Copyright (C) 2003 Kevin P. Scannell <scannell@slu.edu>
#
# This is free software; see the file COPYING for copying conditions.  There is
# NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
s/^\([^ :]*\):\([^ ]*\)/s\/([^<>])(\1[^<>])\/$1<E msg="\2">$2<\\\/E>\/; s\/([^>])<\\\/E>\/<\\\/E>$1\/;/
s/^\([^:]*\):\([^ ]*\)/s\/([^<>])(\1[^<>])\/$1<E msg="\2">$2<\\\/E>\/g; s\/([^>])<\\\/E>\/<\\\/E>$1\/g;/
