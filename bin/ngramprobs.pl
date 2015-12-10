#!/usr/bin/perl

use strict;
use warnings;
use utf8;

# pipe the output of   "togail ga ngrams N" through this
# togail ga ngrams 3 | ./ngramprobs.pl 

my %big;
my %ans;

binmode STDIN, ":utf8";
binmode STDOUT, ":utf8";
binmode STDERR, ":utf8";

while (<STDIN>) {
	chomp;
	/^([0-9]+) (.+)$/;
	$big{$2} = $1;
}

foreach (keys %big) {
	if (/[áéíóúÁÉÍÓÚ]/) {
		unless (/[A-ZÁÉÍÓÚ]/) {
			my $eile = $_;
			$eile =~ tr/áéíóúÁÉÍÓÚ/aeiouAEIOU/;
			if (exists($big{$eile})) {
				$ans{$_} = $big{$_}/$big{$eile};
			}
		}
	}
}

foreach (sort {$ans{$b} <=> $ans{$a}} keys %ans) {
	my $eile = $_;
	$eile =~ tr/áéíóúÁÉÍÓÚ/aeiouAEIOU/;
	print $ans{$_}." ".$_." (".$big{$_}.") vs. ".$eile." (".$big{$eile}.")\n";
}

exit 0;
