#!/usr/bin/perl

#  Copyright (C) 2003 Kevin P. Scannell <scannell@slu.edu>
 
# This is free software; see the file COPYING for copying conditions.  There is
# NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#  
#  This used to be the C program "cabhair.c" up through v.0.4; it is used to
#  compress a file containing a sorted word list with integer part-of-speech
#  codes.

use strict;
use warnings;

use Getopt::Long qw(:config gnu_getopt);

my $rarebyte = 127;

my $unicode = '';
my $encoding = 'ISO-8859-1';
my $compress = '';
my $decompress = '';
GetOptions (
		'encoding=s'			=> \$encoding,
		'unsq|decompress|uncompress|d'	=> \$decompress,
		'sq|compress|c'			=> \$compress,
	) or die "Error parsing command line options";

die "You must specify either -d(ecompress) or -c(ompress)"
unless ($compress or $decompress);

$unicode=1 if ($encoding =~ m/utf-?8/i);

sub sq
{
	my ($word, $prev) = @_;

	if ($prev) {
		my $count = 0;
		if ($word eq $prev) {
			$count = length($word);
		}
		else {
			while (substr($word,$count,1) eq substr($prev,$count,1)) {
				$count++;
			}
		}
		return "$count".substr($word,$count);
	}
	else {
		return $word;
	}
}

if ($compress) {
	binmode STDOUT, ":bytes";
	if ($unicode) {
		binmode STDIN, ":utf8";
	}
	else {
		binmode STDIN, ":bytes";
	}
	my %seen;
	my $prevword;
	my $currword='';
	while (<STDIN>) {
		chomp;
		( my $word, my $code ) = m/([^ ]+) (.*)/;
		if ($word ne $currword) {
			if ($currword) {
				binmode STDOUT, ":utf8" if $unicode;
				print sq($currword, $prevword)."\cJ" if $currword;
				delete($seen{$rarebyte}) unless ( keys %seen == 1 );
				binmode STDOUT, ":bytes" if $unicode;
				print chr($_) foreach (sort { $a <=> $b } keys %seen);
				print "\cJ";
			}
			%seen = ();
			$prevword = $currword;
			$currword = $word;
		}
		$seen{$code}++;
	}
	binmode STDOUT, ":utf8" if $unicode;
	print sq($currword, $prevword)."\cJ";
	delete($seen{$rarebyte}) unless ( keys %seen == 1 );
	binmode STDOUT, ":bytes" if $unicode;
	print chr($_) foreach (sort { $a <=> $b } keys %seen);
	print "\cJ";
}
else {
	binmode STDIN, ":bytes";
	if ($unicode) {
		binmode STDOUT, ":utf8";
	}
	else {
		binmode STDOUT, ":bytes";
	}
	{
	local $/ = "\cJ";
	my $grambytes;  # byte semantics always
	binmode STDIN, ":utf8" if $unicode;
	chomp(my $currword=<STDIN>);
	binmode STDIN, ":bytes" if $unicode;
	chomp($grambytes = <STDIN>);
	print "$currword ".ord($_)."\n" foreach (split //, $grambytes);
	binmode STDIN, ":utf8" if $unicode;
	while (<STDIN>) {
		chomp;
		m/^([0-9]*)(.*)/;
		$currword = substr($currword,0,$1).$2;
		binmode STDIN, ":bytes" if $unicode;
		chomp ($grambytes = <STDIN>);
		print "$currword ".ord($_)."\n" foreach (split //, $grambytes);
		binmode STDIN, ":utf8" if $unicode;
	}
	}
}
