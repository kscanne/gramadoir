#!/usr/bin/perl


while (<STDIN>) {

	(my $sentence, my $err) = m/" sentence="([^"]+)" errortext="([^"]+)"/;
	$sentence =~ s/$err/<marker>$err<\/marker>/;
	s/^<E offset="[0-9]+" /<error /;
	s/" sentence="([^"]+)" errortext="([^"]+)" msg=/" ruleId="Lingua::GA::Gramadoir" context="$sentence" msg=/;
	s/>$/\/>/;
	print;

}
