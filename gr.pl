#!/usr/bin/perl
use Frontier::Client;
use Encode 'from_to';
my $server_url = 'http://borel.slu.edu:8080/RPC2';
my $server = Frontier::Client->new(url => $server_url,  debug => 0, );
my @textinput = <>;
my $toserver = "@textinput";
from_to($toserver, "iso-8859-1", "utf-8");
print $server->call('gaeilge.gramadoir', $toserver);
