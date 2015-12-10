#!/usr/bin/perl

use strict;
use warnings;

use Lingua::GA::Gramadoir;

binmode STDOUT, ":utf8";
binmode STDERR, ":utf8";

my $gr = new Lingua::GA::Gramadoir(
			input_encoding => 'UTF-8',
			);

binmode STDIN, ":bytes";
while (<STDIN>) {
	chomp;
	print $gr->all_possible_tags($_);
	print "\n";
}
exit 0;
