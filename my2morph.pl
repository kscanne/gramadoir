#!/usr/bin/perl

use strict;
use warnings;

binmode STDIN, ":bytes";
binmode STDOUT, ":bytes";
while (<STDIN>) {
	if (/^\s*#/) {
		print;
	}
	elsif (/^([PS])FX\s+(\S)\s+(\S+)\s+(\S+)\s+(\S+)\s*(#.*)?$/) {
		my $type = $1;
		my $lipead = $2;
		my $withoutaff = $3;
		my $withaff = $4;
		my $cond = $5;
		my $comment = $6;
		my $output;
		
		$withoutaff='' if ($withoutaff eq '0');
		$withaff='' if ($withaff eq '0');
		if ($type eq 'P') {
			print STDERR "Regexp doesn't guarantee $withoutaff can be stripped, line $.\n" unless ($cond =~ m/^$withoutaff/);
			$cond =~ s/^$withoutaff(.*)$/^$withaff($1)/;
			$output = "$cond\t$withoutaff\$1\t-1\t".'<(.*) pfx="[^"]*'.$lipead.'[^"]*"(.*)>'."\t<\$1\$2>";
		}
		elsif ($type eq 'S') {
			print STDERR "Regexp doesn't guarantee $withoutaff can be stripped, line $.\n" unless ($cond =~ m/$withoutaff$/);
			$cond =~ s/^(.*)$withoutaff$/($1)$withaff\$/;
			$output = "$cond\t\$1$withoutaff\t-1\t".'<(.*) sfx="[^"]*'.$lipead.'[^"]*"(.*)>'."\t<\$1\$2>";
		}
		else {
			print STDERR "Parse error on line $.\n";
		}
		$output =~ s/\$1// if ($output =~ s/\(\)//);
		print $output;
		print "\t$comment" if $comment;
		print "\n";
	}
}

exit 0;
