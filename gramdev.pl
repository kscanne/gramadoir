#!/usr/bin/perl

=head1 NAME

@SCRIPTNAME@ - Utilities for An GramadE<oacute>ir @NAME_ENGLISH@ language developers

=head1 SYNOPSIS

B<@SCRIPTNAME@> --ambig [I<options>]

B<@SCRIPTNAME@> --brill [I<options>]

B<@SCRIPTNAME@> --freq [I<options>]

=head1 DESCRIPTION

This script provides several useful functions for language pack
developers of the An GramadE<oacute>ir grammar and style checker.
The script read from standard input in all cases.
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

if ($version) {
	my $vstring = gettext('version %s', $VERSION);
	my $copyright = 'Copyright (C) 2003, 2004 Kevin P. Scannell';
	my $gpl = gettext('This is free software; see the source for copying conditions.  There is NO\\nwarranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE,\\nto the extent permitted by law.');
	print "$clar, $vstring\n$copyright\n$gpl\n";
	exit 0;
}
if ($help) {
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
gettext(
"If no file is given, read from standard input."),
"",
gettext(
'Send bug reports to <%s>.','scannell@slu.edu'),
""
);

	print join("\n", @helpmessages);
	exit 0;
}

my $gr = new Lingua::@TEANGA@::Gramadoir(
	fix_spelling => 0,
	use_ignore_file => 0,
	unigram_tagging => 0,
	interface_language => '',
	input_encoding => '@NATIVE@',
);

binmode STDIN, ":bytes";
local $/;
$_ = <STDIN>;
my $bigboy = $gr->xml_stream($_);
exit 0;
