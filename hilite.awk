#!/bin/awk
# My replacement for "egrep --color" and "glark" when "gr --html" is called.
# Takes one argument which is a regexp matching the substring to be hilighted
# The text itself is piped through this.
{
sub(/^/,"<br><br>")
sub(/$/,"<br>")
gsub(pattern,"<b class=gramadoir>&</b>")
print
}
