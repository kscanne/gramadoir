#!/usr/bin/perl -w

use strict;
use warnings;

use Test::More tests => 1;
use Lingua::@TEANGA@::Gramadoir::Languages;
use Lingua::@TEANGA@::Gramadoir;
use Encode 'decode';

BEGIN { use_ok('Lingua::@TEANGA@::Gramadoir') };

my $lh = Lingua::@TEANGA@::Gramadoir::Languages->get_handle('ga');

ok( defined $lh, 'Irish language handle created' );

my $gr = new Lingua::@TEANGA@::Gramadoir(
			fix_spelling => 1,
			use_ignore_file => 0,
			interface_language => 'ga',
			input_encoding => '@NATIVE@');

ok (defined $gr, 'grammar checker created' );

my $test = <<'EOF';
EOF

my $results = <<'RESEOF';
RESEOF

$results = decode('utf8', $results);

my @resultarr = split(/\n/,$results);

my $output = $gr->grammatical_errors($test);
my $errorno = 0;
is( @resultarr, @$output, 'Verifying correct number of errors found');
foreach my $error (@$output) {
	(my $ln, my $snt, my $offset, my $len) = $error =~ m/^<error fromy="([0-9]+)".* context="([^"]+)" contextoffset="([0-9]+)" errorlength="([0-9]+)"\/>$/;
	my $errortext = substr($snt,$offset,$len);
	is ( $error, $resultarr[$errorno], "Verifying error \"$errortext\" found on input line $ln" );
	++$errorno;
}

exit;
