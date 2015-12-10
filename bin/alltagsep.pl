#!/usr/bin/perl
# like alltags, but prints one per line

use strict;
use warnings;

use Lingua::GA::Gramadoir;

binmode STDOUT, ":utf8";
binmode STDERR, ":utf8";

my $gr = new Lingua::GA::Gramadoir(input_encoding => 'utf-8',
								);

binmode STDIN, ":bytes";
while (<STDIN>) {
	chomp;
	my $w = $_;
	my $tagz = $gr->all_possible_tags($w);
	if ($tagz =~ /^<B><Z>/) {
		$tagz =~ s/^<B><Z>//;
		$tagz =~ s/<\/Z>(.+)<\/B>$//;
		my $w_as_perl = $1;
		while ($tagz =~ m/(<[^>]+>)/g) {
			my $tag = $1;
			(my $clib) = $tag =~ /^<(.)/;
			$tag =~ s/\/>$/>/;
			print "$tag$w_as_perl</$clib>\n";
		}
	}
	else {
		print $tagz."\n";
	}
}
exit 0;
