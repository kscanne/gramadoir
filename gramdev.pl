#!/usr/bin/perl

=head1 NAME

@SCRIPTNAME@ - Utilities for An GramadE<oacute>ir @NAME_ENGLISH@ language developers

=head1 SYNOPSIS

B<@SCRIPTNAME@> --ambig

B<@SCRIPTNAME@> --brill

B<@SCRIPTNAME@> --freq

=head1 DESCRIPTION

This script provides several useful functions for language pack
developers of the An GramadE<oacute>ir grammar and style checker.
The script reads from standard input in all cases.
Try @SCRIPTNAME@ --help for more information.

=head1 SEE ALSO

=over 4

=item *
L<http://borel.slu.edu/gramadoir/>

=item *
L<Lingua::@TEANGA@::Gramadoir>

=item *
L<perl(1)>

=back

=head1 AUTHOR

Kevin P. Scannell, E<lt>scannell@slu.eduE<gt>.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2004 Kevin P. Scannell

This is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.2 or,
at your option, any later version of Perl 5 you may have available.

=cut

use strict;
use warnings;

use Getopt::Long qw(:config gnu_getopt);
use Lingua::@TEANGA@::Gramadoir;
use Lingua::@TEANGA@::Gramadoir::Languages;

my $lh;
my $clar;
my $VERSION = '@PACKAGE_VERSION@';

sub gettext
{
	my ( $string, @rest ) = @_;

	$string =~ s/\\n/\n/g;
	$string =~ s/\[/~[/g;
	$string =~ s/\]/~]/g;
	$string =~ s/\%s/[_1]/;
	$string =~ s/\%s/[_2]/;
	return $lh->maketext($string, @rest);
}

sub localized_die
{
	my ( $signal ) = @_;
	my $msg;

	if ( $signal =~ m/^Unknown option: (.*)/ ) {
		my $arg = $1;
		chomp $arg;
		$msg = gettext('unrecognized option %s', '`'.$arg.'\'');
	}
	elsif ( $signal =~ m/^Option (.*) does not take/ ) {
		$msg = gettext('option %s does not allow an argument', '`'.$1.'\'');
	}
	elsif ( $signal =~ m/^getopt/ ) {
		$msg = gettext('error parsing command-line options');
	}
	else {
		die $signal;
	}
	my $dieclar = gettext('An Gramadoir');  # can't use global $clar yet
	my $tryhelp = gettext('Try %s for more information.', '`@SCRIPTNAME@ --help\'');
	print STDERR "$dieclar: $msg\n$tryhelp\n";
	exit 1;
}

$lh = Lingua::@TEANGA@::Gramadoir::Languages->get_handle();
$SIG{__DIE__} = 'localized_die';
# scalars for global options
use vars qw($brill $help $version $ambig $freq);
eval { 
	local $SIG{__WARN__} = 'localized_die';
	GetOptions (	
		'help|cabhair|h'        => \$help,
		'version|leagan|v'      => \$version,
		'brill'			=> \$brill,
		'minic|freq'		=> \$freq,
		'ilchiall|ambig'	=> \$ambig,
		) 
};
die "getopt error" if $@;

binmode STDOUT, ":encoding(utf8)";
binmode STDERR, ":encoding(utf8)";

$clar = gettext('An Gramadoir');

sub do_help
{
	my @helpmessages = (
"  --ambig,",
gettext(
"    --ilchiall     report unresolved ambiguities, sorted by frequency"),
"  --freq,",
gettext(
"    --minic        output all tags, sorted by frequency (for unigram-xx.txt)"),
gettext(
"    --brill        find disambiguation rules via Brill's unsupervised algorithm"),
"  -h, --cabhair,",
gettext(
"    --help         display this help and exit"),
"  -v, --leagan,",
gettext(
"    --version      output version information and exit"),
"",
# gettext(
# "If no file is given, read from standard input."),
# "",
gettext(
'Send bug reports to <%s>.','scannell@slu.edu'),
""
);

	print join("\n", @helpmessages);
	exit 0;
}

if ($version) {
	my $vstring = gettext('version %s', $VERSION);
	my $copyright = 'Copyright (C) 2003, 2004 Kevin P. Scannell';
	my $gpl = gettext('This is free software; see the source for copying conditions.  There is NO\\nwarranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE,\\nto the extent permitted by law.');
	print "$clar, $vstring\n$copyright\n$gpl\n";
	exit 0;
}
do_help if $help;
do_help unless ($brill or $ambig or $freq);

my $gr = new Lingua::@TEANGA@::Gramadoir(
	fix_spelling => 0,
	use_ignore_file => 0,
	unigram_tagging => $freq,
	interface_language => '',
	input_encoding => '@NATIVE@',
);

binmode STDIN, ":bytes";
local $/;
$_ = <STDIN>;
my $big = $gr->xml_stream($_);
if ($brill) {
	 # hash, keys are brill replacement rules (aonchiall lines)
	 # and values are "scores" according to brill algorithm
	my %candidates;
	my %posseen;
	while ($big =~ /(<[ACDF-W][^>\/]*>)/g) {
		$posseen{$1}++;
	}

	my %wordsseen;
	pos $big = 0;
	while ($big =~ /<(?:\/Z|[ACDF-Y][^>]*)>([^<]+)<\/[A-Z]>/g) {
		$wordsseen{$1}++;
	}

	sub total_count
	{
		my ($tocount) = @_;
		if ($tocount =~ m/^</) {
			return $posseen{$tocount};
		}
		else {
			return $wordsseen{$tocount};
		}
	}

	sub find_rules_given_context
	{
		my ($patt, $printpatt, $before_p) = @_;
		my $ambig_nbr = $patt.' <B><Z>((?:<[A-Z][^>]*/>)+)</Z>';
		my $unambig_nbr = $patt.' (<[ACDF-W][^>]*>)';
		if ($before_p) {
			$ambig_nbr = '<B><Z>((?:<[A-Z][^>]*/>)+)</Z>[^<]+</B> '.$patt;
			$unambig_nbr = '(<[ACDF-W][^>]*>)[^<]+</[ACDF-W]> '.$patt;
		}
		my %ambig_this_context;
		my %unambig_this_context;
		my %ppm_this_context;
		pos $big = 0;
		while ($big =~ m/$ambig_nbr/g) {
			$ambig_this_context{$1}++;
		}
		pos $big = 0;
		while ($big =~ m/$unambig_nbr/g) {
			$unambig_this_context{$1}++;
		}
		foreach (keys %unambig_this_context) {
			$ppm_this_context{$_} = ($unambig_this_context{$_}*1000000)/total_count($1);
		}
		foreach (keys %ambig_this_context) {
			my @viable;
			while (m/(<[^>]+>)/g) {
				my $t = $1;
				$t =~ s/\/>$/>/;
				push @viable, $t if (exists($ppm_this_context{$t}));
			}
			my @cands = sort {$ppm_this_context{$b} <=> $ppm_this_context{$a}} @viable;
			if (@cands > 0) {
				my $nextppm = 0;
				$nextppm = $ppm_this_context{$cands[1]} if (@cands > 1);
				my $score = int(($ppm_this_context{$cands[0]} - $nextppm)*total_count($cands[0]));
				if ($before_p) {
					$candidates{"<B><Z>$_</Z>ANYTHING</B> $printpatt:$cands[0]"} = $score;
				}
				else {
					$candidates{"$printpatt <B><Z>$_</Z>ANYTHING</B>:$cands[0]"} = $score;
				}
			}
		}
	}

	foreach my $tag (keys %posseen) {
		my $printable = $tag;
		$tag =~ s/(<([A-Z]).*>)/${1}[^<]+<\/${2}>/;
		$printable =~ s/(<([A-Z]).*>)/${1}ANYTHING<\/${2}>/;
		find_rules_given_context($tag, $printable, 0);
		find_rules_given_context($tag, $printable, 1);
	}

	my @highfreq = sort {$wordsseen{$b} <=> $wordsseen{$a}} keys %wordsseen;
	foreach (splice (@highfreq, 0, 50)) {
		my $w = $_;
		s/(.*)/(?:<[^>]+>)+$1<\/[A-Z]>/;
		find_rules_given_context($_, $w, 0);
		find_rules_given_context($_, $w, 1);
	}
	print "$_\n" foreach (sort {$candidates{$b} <=> $candidates{$a}} keys %candidates);

}
elsif ($ambig) {
	my %genotypes;
	for ($big) {
		while (/<Z>((?:<[^<]+>)+)<\/Z>/g) {
			$genotypes{$1}++;
		}
		foreach my $genotype (sort {$genotypes{$b} <=> $genotypes{$a}} keys %genotypes) {
			my %examples;
			print "$genotype\n";
			while (/<Z>$genotype<\/Z>([^<]+)<\/B>/g) {
				$examples{$1}++;
			}
			my @samplai = sort {$examples{$b} <=> $examples{$a}} keys %examples;
			foreach my $example (splice (@samplai, 0, 15)) {
				print "$examples{$example}\t$example\n";
			}
		}
	}
}
elsif ($freq) {
	my %posseen;
	for ($big) {
		while (/(<[ACDF-W][^>]*>)(?!<)/g) {
			$posseen{$1}++;
		}
		print "$_\n" foreach (sort {$posseen{$b} <=> $posseen{$a}} keys %posseen);
	}
}
exit 0;
