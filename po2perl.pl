#!/usr/bin/perl

use strict;
use warnings;
use Locale::PO;

sub massage
{
	my ( $string ) = @_;

	$string =~ s/@/\\@/g;
	$string =~ s/\\\\n/\\n/g;
	$string =~ s/\[/~[/g;
	$string =~ s/\]/~]/g;
	$string =~ s/\%s/[_1]/;
	$string =~ s/\%s/[_2]/;
	$string =~ s/\%s/[_3]/;
	$string =~ s#\\\\/\\\\([1-9])\\\\/#/[_$1]/#;
	$string =~ s#\\\\/([A-Za-z']+)\\\\/#/$1/#;

	return $string;
}

sub my_warn
{
return 1;
}

if (@ARGV != 2) {
	die "Usage: $0 POFILE LANGUAGECODE\n";
}

my $aref;
{
	local $SIG{__WARN__} = 'my_warn';
	$aref = Locale::PO->load_file_asarray($ARGV[0]);
}
shift(@$aref);
my $lang = $ARGV[1];

print 'package Lingua::@TEANGA@::Gramadoir::Languages::'."$lang;\n\n";
print 'use strict;'."\n";
print 'use warnings;'."\n";
print 'use utf8;'."\n";
print 'use base qw(Lingua::@TEANGA@::Gramadoir::Languages);'."\n";
print 'use vars qw(%Lexicon);'."\n\n";

print '%Lexicon = ('."\n";

foreach my $msg (@$aref) {
	my $id = $msg->msgid();
	my $str = $msg->msgstr();
	if (defined($id) && defined($str)) {
	$id = massage($id);
	$str = massage($str);
	if ($str eq '""') {
		$str = $id;
	}
	print "    ";
	print $id;
	print "\n";
	print " => ";
	print $str;
	print ",\n\n";
	}
}

print ");\n";
print "1;\n";

exit 0;
