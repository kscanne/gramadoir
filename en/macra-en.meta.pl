#!/usr/bin/perl
# Macros used in converting *.in files into *.pl scripts
# Copyright (C) 2004 Kevin P. Scannell <scannell@slu.edu>
#                    
#
# This is free software; see the file COPYING for copying conditions.  There is
# NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
s/ANYTHING/[^<]*/g;
s/CAPITAL/[A-Z -¯À-Þ][^<]*/g;
s/INITIALVOWEL/[AEIOUaeiou][^<]*/g;
s/YOO/[Uu](?:ni[^mn]|[^aeioun][aeiou])[^<]*/g;
