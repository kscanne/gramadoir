#!/usr/bin/perl
use Frontier::Client;
use Encode 'from_to';
my $server_url = 'http://borel.slu.edu:8080/RPC2';
my $server = Frontier::Client->new(url => $server_url,  debug => 0, );
my @textinput = <>;
my $toserver = "@textinput";
from_to($toserver, "iso-8859-1", "utf-8");
print $server->call('gaeilge.gramadoir', $toserver);




# (1) Download and install Perl for Windows from
# http://www.activestate.com/Products/ActivePerl/
# 
# (2) Open the "Command Prompt" (DOS)
# (3) Run the perl package manager:
#     C:\>ppm
# (4) Install the client RPC package:
#     ppm> install Frontier-RPC
# (5) Get gr.pl from me
# (6) Run it, enter some text, and type "Ctrl-Z", then Enter:
#     C:\>perl gr.pl
#     Ta tu in ann.
#     ^Z
# 
#   and you should see the XML error messages served from borel.slu.edu
