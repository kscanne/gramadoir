#!/usr/bin/perl
# This perl script is used for converting the hopefully-user-readable
# *.in files into the somewhat complicated *.pl scripts
# Copyright (C) 2004 Kevin P. Scannell <scannell@slu.edu>
#
# This is free software; see the file COPYING for copying conditions.  There is
# NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
my $attrtags = '['.$ARGV[0].']';
my $noattrtags = '[^BEZ'.$ARGV[0].']';

while (<STDIN>) {
if ( /^[^#]/ ) {
	chomp;
	my ($rule, $action) = m/^([^:]+):(.*)$/;
	my $ans;
	$rule =~ s/\(/(?:/g;
	$rule =~ s/\/>/\\\/>/g;
	$rule =~ s/^/ /;
	$rule =~ s/$/ /;
	# loop over tokens in the rule; the optional <E>,</E> tokens
	# are from the OK lines in rialacha-xx.in
	while ($rule =~ m/(?<= )(<E>)?(<B><Z>(?:(?:<[^>]+>)+|[^<>]+)<\/Z>[^<]+<\/B>|<[^\/][^>]*>[^<]+<\/[^>]+>|[^<> ]+)(<\/E>)?(?= )/g) {
		my $aon = $1;
		my $tok = $2;
		my $tri = $3;
		# e.g. <[^N]>ANYTHING</[^N]>
		if ($tok =~ m/^<\[\^/) {
			$tok =~ s/<\[\^([A-DF-Z]+)\]>([^<]+)<\/[^>]*>/(?:<[^\\\/$1][^>]*>$2<\\\/[^$1]>|<B><Z>(?:<[^$1][^>]*>)+<\\\/Z>$2<\\\/B>)/;
		}
		# e.g. <[AN]>ANYTHING</[AN]>
		elsif ($tok =~ m/^<\[[^\^]/) {
			$tok =~ s/<\[([A-DF-Z]+)\]>([^<]+)<\/[^>]*>/(?:<[$1][^>]*>$2<\\\/[$1]>|<B><Z>(?:<[$1][^>]*>)+<\\\/Z>$2<\\\/B>)/;
		}
		elsif ($tok =~ m/^<[A-Z]/) {
			# e.g. <C>
			$tok =~ s/<($noattrtags)>([^<]+)<\/[A-Z]>/<$1>$2<\\\/$1>/;
			# e.g. <N pl="n" gnt="n">
			$tok =~ s/<($attrtags)( [^>]+)>([^<]+)<\/[A-Z][^>]*>/<${1}${2}>$3<\\\/$1>/;
			# e.g. <N>
			$tok =~ s/<($attrtags)>([^<]+)<\/[A-Z][^>]*>/(?:<${1}[^>]*>$2<\\\/$1>|<B><Z>(?:<${1}[^>]*>)+<\\\/Z>$2<\\\/B>)/;
			# e.g. <NCS>, or (see wa) <NCS h="y">
			$tok =~ s/<($attrtags)([^ >][^>]*)>([^<]+)<\/[A-Z][^>]*>/(?:<${1}[^>]*${2}[^>]*>$3<\\\/$1>|<B><Z>(?:<${1}[^>]*${2}[^>]*>)+<\\\/Z>$3<\\\/B>)/;
		}
		# e.g. barewords or macros with no tags
		else {
			$tok =~ s/([^<> ]+)/(?:<[\\\/A-DF-Z][^>]*>)+$1<\\\/[A-DF-Z]>/;
			$tok =~ s/\+([^(<]*\|[^(<]*)</+(?:$1)</g;
		}
		$tri =~ s/\//\\\//;  # </E> -> <\/E>
		$ans .= "$aon$tok$tri ";
	}
	$ans =~ s/ $/:$action/;
	print "$ans\n";
}
}
exit;
