#!/usr/bin/perl -w

use strict;
use Lingua::GA::Gramadoir;
use Frontier::Daemon;
#  Must use utf-8 and not "perl strings" on the wire
use Encode qw(from_to encode);

$ENV{PATH}="/bin:/usr/bin";
delete @ENV{ 'IFS', 'CDPATH', 'ENV', 'BASH_ENV' };

my $gr = new Lingua::GA::Gramadoir(
	fix_spelling => 1,
	interface_language => 'ga',
);

sub gramadoir {
	my @errs = @{$gr->grammatical_errors("@_")};
	return encode("utf8", join("\n", @errs)."\n");
}
    
my $methods = {'gaeilge.gramadoir' => \&gramadoir};
Frontier::Daemon->new(LocalPort => 8080, methods => $methods)
     or die "Couldn't start HTTP server: $!";
