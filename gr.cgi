#!/usr/bin/perl -wT

use strict;
use CGI;

$CGI::DISABLE_UPLOADS = 1;
$CGI::POST_MAX        = 1024;

$ENV{PATH}="/bin:/usr/bin";
delete @ENV{ 'IFS', 'CDPATH', 'ENV', 'BASH_ENV' };

my $GRAMADOIR = '/usr/local/bin/grweb';
my $q = new CGI;
my( $ionchur ) = $q->param( "foirm_ionchur" ) =~ /^(['áéíóúÁÉÍÓÚ\w\s,.!?-]+)$/;

local *PIPE;

print $q->header( "text/plain" ),
"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\"\n",
"\"http://www.w3.org/TR/html4/strict.dtd\">\n",
"<html lang=\"ga\">\n",
"<head>\n",
"<title>An Gramad&oacute;ir: Tortha&iacute;</title>\n",
"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\">\n",
"<link rel=\"stylesheet\" href=\"http://borel.slu.edu/kps.css\" type=\"text/css\">\n",
"</head>\n<body>\n";

unless ( $ionchur ) {
print "<a href=\"http://borel.slu.edu/gramadoir/\">An Gramadóir</a>: carachtair neamhbhailí sa théacs";
exit;
}

$ionchur =~ s/'/\'/g;

my $pid = open PIPE, "-|";
die "Fork failed: $!" unless defined $pid;
unless ( $pid ) {
	exec $GRAMADOIR, "$ionchur" or die "Can't open pipe: $!";
	}

print while <PIPE>;
close PIPE;
print $q->hr;
print $q->end_html;
