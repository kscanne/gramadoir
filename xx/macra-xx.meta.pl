#!!PERLPATH!
# Macros used in converting *.in files into *.pl scripts
# Copyright (C) 2007 Kevin P. Scannell <kscanne@gmail.com>
#
# This is free software; see the file COPYING for copying conditions.  There is
# NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
s/ANYTHING/[^<]*/g;
s/CAPITAL/[A-Z][^<]*/g;
