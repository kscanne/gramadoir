# My replacement for "egrep --color" and "glark" when "gr --html" is called.
# Takes one argument which is a regexp matching the substring to be hilighted
# The text itself is piped through this.
# Copyright (C) 2003 Kevin P. Scannell <scannell@slu.edu>
#
# This is free software; see the file COPYING for copying conditions.  There is
# NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
{
sub(/^/,"<br><br>")
sub(/$/,"<br>")
gsub(pattern,"<b class=gramadoir>&</b>")
print
}
