# This sed script is used for converting the hopefully-user-readable
# rialacha.in into the somewhat complicated rialacha.pl
# It only needs to be changed if the grammar of the .in file changes
# or new tags are added, etc.
/^#/d
s/<\([A-Z]\)\([^>]*\)><\/[A-Z][^>]*>/<\1[^>]*\2[^>]*>[^<]*<\\\/\1>/g
s/<\([A-Z]\)\([^>]*\)>\([^<]*\)<\/[A-Z][^>]*>/(<\1[^>]*\2[^>]*>\3<\\\/\1>|<B><Z>(<\1[^>]*\2[^>]*>)+<\\\/Z>\3<\\\/B>)/g
s/^/~/
s/ /  /g
s/\([~ ]\)\([^(< ][^: ]*\)\([: ]\)/\1(<[A-Z][^>]*>\2<\\\/[A-Z]>|<B><Z>(<[A-Z][^>]*>)+<\\\/Z>\2<\\\/B>)\3/g
s/^~//
s/  / /g
s/INITIALS/[Ss][lnraeiouáéíóú][^<]*/g
s/INITIALVOWELORF/([aeiouAEIOUáéíóúÁÉÍÓÚ]|[Ff]h?[aeiouáéíóú])[^<]*/g
s/UNECLIPSED/([aeiouAEIOUáéíóúÁÉÍÓÚcfptCFPT]|d[^Tt']|g[^Cc]|b[^Pph]|bh[^fF])[^<]*/g
s/UNLENITEDBCGMP/[BbCcGgMmPp][^h][^<]*/g
s/UNLENITEDBCFGMP/[BbCcFfGgMmPp][^h][^<]*/g
s/UNMUTATEDBCFGMP/[BbCcFfGgMmPp][^hbBcCgGpP][^<]*/g
s/UNLENITEDF/[Ff][^h][^<]*/g
s/UNLENITED/([BbCcDdFfGgMmPpTt][^h]|[Ss][lnraeiouáéíóú])[^<]*/g
s/LENITED/([CcDdFfGgMmPpSsTt]h|bh[^fF])[^<]*/g
s/\*CS\[/*pl="n" gnt="n"[/g
s/\*FCS\[/*pl="n" gnt="n" gnd="f"[/g
s/\*FCP\[/*pl="y" gnt="n" gnd="f"[/g
s/\*FGS\[/*pl="n" gnt="y" gnd="f"[/g
s/\*FGP\[/*pl="y" gnt="y" gnd="f"[/g
s/\*MCS\[/*pl="n" gnt="n" gnd="m"[/g
s/\*MCP\[/*pl="y" gnt="n" gnd="m"[/g
s/\*MGS\[/*pl="n" gnt="y" gnd="m"[/g
s/\*MGP\[/*pl="y" gnt="y" gnd="m"[/g
s/\([^:]*\):\([^ ]*\)/s\/(\1)\/<E msg="\2">$1<\\\/E>\/g;/
