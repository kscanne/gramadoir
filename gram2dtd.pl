#!/usr/bin/perl
# Copyright (C) 2005 Kevin P. Scannell
# This is free software; see the file COPYING for copying conditions.  There is
# NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# This script is called from a language pack directory via the
# Makefile target "gram-xx.dtd"

use strict;
use warnings;

my %HoH = ();
open (POS, "pos-$ARGV[0].txt");
$HoH{'X'}{'>'}=1;
while(<POS>) {
	chomp;
	s/^[0-9]+\s+//; 
	(my $tag, my $attrs) = m/^<([A-Z]) *([^>]*)>/;
	$HoH{ $tag }{ '>' }++;    # the '>' entry holds the count for this tag
	if ($attrs) {
		while ($attrs =~ m/([^ ]+)/g) {
			my $full = $1;
			$full =~ s/[ =].*//;
			$HoH{ $tag }{ $full }++; # '>' can't be an attribute!
		}
	}
}
close POS;

my @sorted = sort keys %HoH;
my $gramtags = join ' | ',@sorted;
print "<?xml version=\"1.0\"?>\n";
print "<!ENTITY % tag \"( $gramtags )\">\n";
print "<!ENTITY % mycontent \"( #PCDATA | $gramtags | E | B )*\">\n";
print "<!ELEMENT teacs ( line )+>\n";
print "<!ELEMENT line \%mycontent; >\n";
foreach my $t (@sorted) {
	print "<!ELEMENT $t (#PCDATA)>\n";
	my @attrs = sort keys %{$HoH{$t}};
	if (scalar @attrs > 1) {
		print "<!ATTLIST $t\n";
		foreach my $attr (@attrs) {
			unless ($attr eq '>') {
				print "\t\t$attr CDATA #";
				if ($HoH{$t}->{'>'} == $HoH{$t}->{$attr}) {
					print "REQUIRED\n";
				}
				else {
					print "IMPLIED\n";
				}
			}
		}
		print ">\n";
	}
}
print "<!ELEMENT B (#PCDATA | Z )*>\n";
print "<!ELEMENT E \%mycontent; >\n";
print "<!ATTLIST E msg CDATA #REQUIRED>\n";
print "<!ELEMENT Z (\%tag;)* >\n";

exit 0;
