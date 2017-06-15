#!/usr/bin/perl -wT
#  Under gentoo's apache configuration, this goes in /home/httpd/cgi-bin
#  owner and group are "apache".

use strict;
use CGI;
use Lingua::GA::Gramadoir;
use Lingua::GA::Gramadoir::Languages;
use Log::Dispatch::File;
use Date::Format;

my $VERSION = '0.70';

# arg looks like: ( message => $log_message, level => $log_level )
# just return the modified scalar message
sub log_callback {
	my %p = @_;
	return Date::Format::time2str('%Y-%m-%d %T', time)." (".$p{'level'}.") ".$p{'message'}."\n";
}

my $log = Log::Dispatch->new(callbacks => \&log_callback);
die unless $log;
$log->add(Log::Dispatch::File->new(
    'name' => 'log1',
    'min_level' => 'info',
    'binmode' => ':utf8',
    'filename' => '/home/httpd/gr.log',
    'mode' => 'append',
));

my $lh;

sub gettext
{
	my ( $string, @rest ) = @_;

	$string =~ s/\\n/\n/g;
	$string =~ s/\%s/[_1]/;
	return $lh->maketext($string, @rest);
}

binmode STDOUT, ":utf8";

$CGI::DISABLE_UPLOADS = 1;
$CGI::POST_MAX        = 1024;

$ENV{PATH}="/bin:/usr/bin";
delete @ENV{ 'IFS', 'CDPATH', 'ENV', 'BASH_ENV' };

my $q = new CGI;
my $pure_input = $q->param( "foirm_ionchur" );
my $ionchur;
my $pure_lang = $q->param( "teanga" );
my $teanga;

my $ip = $ENV{'REMOTE_ADDR'};

$log->error("No foirm_ionchur parameter in CGI query [$ip]") unless defined($pure_input);
$log->warning("No teanga parameter in CGI query [$ip]") unless defined($pure_lang);

( $ionchur ) = $pure_input =~ /^(.+)$/s if defined $pure_input;
( $teanga ) = $pure_lang =~ /^([a-z][a-z](?:_[A-Z][A-Z])?)$/ if defined $pure_lang;

if (defined($pure_lang) and !defined($teanga)) {
	$log->error("Malformed language parameter $pure_lang [$ip]");
}

if (defined $teanga) {
	$lh = Lingua::GA::Gramadoir::Languages->get_handle($teanga);
}
else {
	$lh = Lingua::GA::Gramadoir::Languages->get_handle();
}

unless ($lh) {
	$log->error("Problem setting language handle [$ip]");
	die;
}

# rightfully this file should go in po/POTFILES.in
# but each string is taken directly from gram.pl
my $clar = gettext('An Gramadoir');
my $vstring = gettext('version %s', $VERSION);
my $copyright = 'Copyright (C) 2003-2007 <a href="//borel.slu.edu/">Kevin P. Scannell</a><br><br>';
my $gpl = gettext('This is free software; see the source for copying conditions.  There is NO\\nwarranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE,\\nto the extent permitted by law.');

print $q->header(-type=>"text/html",
		 -charset=>'utf-8'),
"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\"\n",
"\"http://www.w3.org/TR/html4/strict.dtd\">\n",
"<html>\n",
"<head>\n",
"<title>An Gramad&oacute;ir</title>\n",
"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\n",
"<link rel=\"stylesheet\" href=\"//borel.slu.edu/kps.css\" type=\"text/css\">\n",
"</head>\n<body>\n";

print "<p>\n<a href=\"//borel.slu.edu/gramadoir/\">$clar</a>, $vstring<br>\n$copyright\n<i>$gpl</i></p><hr>\n";

if (defined($ionchur)) {
	$ionchur =~ s/\x{e2}\x{80}\x{99}/'/g;  # unicode single quote to '
	my $gr = new Lingua::GA::Gramadoir(
		fix_spelling => 1,
		interface_language => $teanga,
		input_encoding => 'UTF-8',
	);

	my $error_count = 0;
	foreach (@{$gr->grammatical_errors($ionchur)}) {
		$error_count++;
		# these lines copied from gram.pl
		(my $ln, my $msg, my $snt, my $offset, my $len) = m/^<error fromy="([0-9]+)".* msg="([^"]+)".* context="([^"]+)" contextoffset="([0-9]+)" errorlength="([0-9]+)"\/>$/;
		my $errortext = substr($snt,$offset,$len);
		$ln++;   # humans count lines from 1
		print "<br><br>$ln: ".substr($snt,0,$offset)."<b class=gramadoir>$errortext</b>".substr($snt,$offset+$len)."<br>\n$msg.\n\n";
	}
	$log->info("Checked text of length ".length($ionchur).", found $error_count errors [$ip]");
}
else {
	$log->warning("Empty input [$ip]");
}

print $q->hr;
print $q->end_html;
exit 0;
