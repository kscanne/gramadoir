#!/usr/bin/perl
# Copyright (C) 2004 Kevin P. Scannell
# This is free software; see the file COPYING for copying conditions.  There is
# NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# Usage:
# $ cat wordlist.txt | count.pl freqs.txt

use strict;
use warnings;

my %freqhash;
open (FREQ, "$ARGV[0]");
while(<FREQ>) {
	chomp;
	my ($word,$freq) = split;
	$freqhash{$word} = $freq;
}
while (<STDIN>) {
	my $line = $_;
	chomp;
	s/ .*//;
	my $ans = $freqhash{$_};
	if (defined $ans) {
		print "$ans $line";
	}
	else {
		print "0 $line";
	}
}
exit 0;
