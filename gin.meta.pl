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
	$rule =~ s/^/ /;
	$rule =~ s/$/ /;
	while ($rule =~ m/(?<= )(<B><Z>((<[^>]+>)+|[^<>]+)<\/Z>[^<]+<\/B>|<[^\/][^>]*>[^<]+<\/[^>]+>|[^<> ]+)(?= )/g) {
		my $tok = $1;
		if ($tok =~ m/^<\[\^/) {
			$tok =~ s/<\[\^([A-DF-Z]+)\]>([^<]+)<\/[^>]*>/(?:<[^\\\/$1][^>]*>$2<\\\/[^$1]>|<B><Z>(?:<[^$1][^>]*>)+<\\\/Z>$2<\\\/B>)/;
		}
		elsif ($tok =~ m/^<\[[^\^]/) {
			$tok =~ s/<\[([A-DF-Z]+)\]>([^<]+)<\/[^>]*>/(?:<[$1][^>]*>$2<\\\/[$1]>|<B><Z>(?:<[$1][^>]*>)+<\\\/Z>$2<\\\/B>)/;
		}
		elsif ($tok =~ m/^<[A-Z]/) {
			$tok =~ s/<($noattrtags)>([^<]+)<\/[A-Z]>/<$1>$2<\\\/$1>/;
			$tok =~ s/<($attrtags)([^>]*)>([^<]+)<\/[A-Z][^>]*>/(?:<${1}[^>]*${2}[^>]*>$3<\\\/$1>|<B><Z>(?:<${1}[^>]*${2}[^>]*>)+<\\\/Z>$3<\\\/B>)/;
		}
		else {
			$tok =~ s/([^<> ]+)/(?:<[\\\/A-DF-Z][^>]*>)+$1<\\\/[A-DF-Z]>/;
			$tok =~ s/\+([^(<]*\|[^(<]*)</+(?:$1)</g;
		}
		$ans .= "$tok ";
	}
	$ans =~ s/ $/:$action/;
	print "$ans\n";
}
}
exit;
