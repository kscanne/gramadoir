# Macros used in converting *.in files into *.pl scripts
# Copyright (C) 2003 Kevin P. Scannell <scannell@slu.edu>
#
# This is free software; see the file COPYING for copying conditions.  There is
# NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
s/ANYTHING/[^<]*/g
s/CAPITALLENITED/[BCDFGMPST]h[^<]*/g
s/CAPITAL/[A-ZÁÉÍÓÚ][^<]*/g
s/INITIALH/h[^<]*/g
s/INITIALS/[Ss][lnraeiouáéíóú][^<]*/g
s/INITIALVOWELORF/([aeiouAEIOUáéíóúÁÉÍÓÚ]|[Ff]h?[aeiouáéíóú])[^<]*/g
s/INITIALVOWEL/[aeiouAEIOUáéíóúÁÉÍÓÚ][^<]*/g
s/UNECLIPSED/([aeiouAEIOUáéíóúÁÉÍÓÚcfptCFPT]|d[^Tt']|g[^Cc]|b[^Pph]|bh[^fF])[^<]*/g
s/ECLIPSED/(n(-[aeiouáéíóú]|[AEIOUÁÉÍÓÚ])|d[Tt]|g[Cc]|b[Pp]|bh[fF])[^<]*/g
s/UNLENITEDBCGMP/[BbCcGgMmPp][^h'][^<]*/g
s/UNLENITEDBCFGMP/[BbCcFfGgMmPp][^h'][^<]*/g
s/UNMUTATEDBCFGP/[BbCcFfGgPp][^hbBcCgGpP'][^<]*/g
s/UNLENITEDF/[Ff][^h][^<]*/g
s/UNLENITED/([BbCcDdFfGgMmPpTt][^h']|[Ss][lnraeiouáéíóú])[^<]*/g
s/PREFIXEDT/t([AEIOUÁÉÍÓÚ]|-[aeiouáéíóú])[^<]*/g
s/LENITEDDFST/[DdFfSsTt]h[^<]*/g
s/LENITED/([CcDdFfGgMmPpSsTt]h|bh[^fF])[^<]*/g
s/SLENDERFINALCONSONANT/[^<]*[eéií][^aeiouáéíóú<]+/g
s/NONVOWELNONF/[^AEIOUÁÉÍÓÚaeiouáéíóúFf][^<]*/g
s/FINALVOWEL/[^<]*[^bcdfghjlmnprstvxz<]+/g
s/NOBEEAPOST/([^b]|b[^'])[^<]*/g
s/VNISH/[^<]*(a[dm]h|i[nr]t|áil|ú)/g
s/NOTDO/[^<][^<][^<]+/g
s/AWITHGSM/(<N pl="y"[^>]*>)*(<A[^>]*>)*<A pl="n" gnt="y" gnd="m".>(<A[^>]*>)*/g
s/AWITHGSF/(<N pl="y"[^>]*>)*(<A[^>]*>)*<A pl="n" gnt="y" gnd="f".>(<A[^>]*>)*/g
s/ANYWITHGSF/(<N pl="y"[^>]*>)*(<[^>]*>)*<A pl="n" gnt="y" gnd="f".>(<[^>]*>)*/g
s/AWITHPL/(<N pl="y"[^>]*>)*(<A[^>]*>)*<A pl="y" gnt="n".>/g
s/AWITHCOMMON/(<N pl="y"[^>]*>)*<A pl="n" gnt="n".>(<A[^>]*>)*/g
s/ANYWITHCOMMONH/(<[^>]*>)*<A pl="n" gnt="n" h="y".>(<[^>]*>)*/g
s/ANYWITHCOMMON/(<[^>]*>)*<A pl="n" gnt="n".>(<[^>]*>)*/g
s/ANYNMG/(<[^>]*>)*<N pl="n" gnt="y" gnd="m"( h="y")?.>(<[^>]*>)*/g
s/ANYNFG/(<[^>]*>)*<N pl="n" gnt="y" gnd="f"( h="y")?.>(<[^>]*>)*/g
s/ANYNMC/(<[^>]*>)*<N pl="n" gnt="n" gnd="m"( h="y")?.>(<[^>]*>)*/g
s/ANYNFC/(<[^>]*>)*<N pl="n" gnt="n" gnd="f"( h="y")?.>(<[^>]*>)*/g
s/ANYNMPL/(<[^>]*>)*<N pl="y" gnt="n" gnd="m"( h="y")?.>(<[^>]*>)*/g
s/ANYNFPL/(<[^>]*>)*<N pl="y" gnt="n" gnd="f"( h="y")?.>(<[^>]*>)*/g
s/NFONEC/<N pl="n" gnt="n" gnd="f".><N pl="y" gnt="y" gnd="f".>/g
s/NMONEC/<N pl="n" gnt="n" gnd="m"( h="y")?.><N pl="y" gnt="y" gnd="m"( h="y")?.>/g
s/NMONE/<N pl="n" gnt="y" gnd="m"( h="y")?.><N pl="y" gnt="n" gnd="m"( h="y")?.>/g
s/ANDROGYN/<N pl="n" gnt="n" gnd="f".><N pl="n" gnt="y" gnd="m".>/g
s/STRONGPLM/<N pl="y" gnt="n" gnd="m"( h="y")?.><N pl="y" gnt="y" gnd="m"( h="y")?.>/g
s/STRONGPLF/<N pl="y" gnt="n" gnd="f"( h="y")?.><N pl="y" gnt="y" gnd="f"( h="y")?.>(<A pl="n" gnt="y" gnd="f".>)?/g
s/NMFOUR/<N pl="n" gnt="n" gnd="m".><N pl="n" gnt="y" gnd="m".>(<V [^>]*t="foshuit".>)*/g
s/NFFOURH/<N pl="n" gnt="n" gnd="f" h="y".><N pl="n" gnt="y" gnd="f" h="y".>/g
s/NFFOUR/<N pl="n" gnt="n" gnd="f".><N pl="n" gnt="y" gnd="f".>/g
s/NMADJ/<N pl="n" gnt="n" gnd="m".>(<N pl="y" gnt="y" gnd="m".>)?<A pl="n" gnt="n".>(<[A-Z][^>]*>)*/g
s/NFADJ/<N pl="n" gnt="n" gnd="f".><A pl="n" gnt="n".>(<[A-Z][^>]*>)*/g
s/NOUNADJH/(<N[^>]*>)+<A pl="n" gnt="n" h="y".>(<[AV][^>]*>)*/g
s/NOUNADJ/(<N[^>]*>)+<A pl="n" gnt="n".>(<[AV][^>]*>)*/g
s/NMVERB/<N pl="n" gnt="n" gnd="m".>(<V[^>]*>)+/g
s/NFVERB/<N pl="n" gnt="n" gnd="f".>(<V[^>]*>)+/g
s/NMSUBJ/<N pl="n" gnt="n" gnd="m".>(<V [^>]*t="foshuit".>)+/g
s/NPLMSUBJ/<N pl="y" gnt="n" gnd="m".>(<V [^>]*t="foshuit".>)+/g
s/NPLFSUBJ/<N pl="y" gnt="n" gnd="f".>(<V [^>]*t="foshuit".>)+/g
s/NPLF/<N pl="y" gnt="n".><N pl="y" gnt="n" gnd="f".>/g
s/PLADJSUBJ/<A pl="y" gnt="n".>(<V [^>]*t="foshuit".>)+/g
s/PRESSUBJ/<V pl="y" p="1ú" t="láith".><V pl="y" p="1ú" t="foshuit".>/g
s/NFGSUBJ/<N pl="n" gnt="y" gnd="f".>(<V [^>]*t="foshuit".>)+/g
s/GENADJ/<N pl="n" gnt="y" gnd=".".><A pl="n" gnt="n".>(<A [^>]*>)*/g
s/PROPER/<Y.>(<[^>]*>)+/g
s/MASCPL/<N pl="y" gnt="n".><N pl="y" gnt="n" gnd="m".>/g
s/ADJADV/<R.><A pl="n" gnt="n".>/g
s/PREPCONJ/<S.><C.>/g
s/PREPPOSS/<S.><D.>/g
s/PREPADV/<S.><R.>(<A pl="n" gnt="n".>)?/g
s/PREPPRONM/<S.><O.>/g
s/TEMPORAL/<R.><N pl="n" gnt="n".>/g
s/SEOSIN/<P.><A pl="n" gnt="n".>(<A pl="n" gnt="y" gnd="m".>)?/g
s/GENERICPRES/(<V[^>]* t="láith".>)+/g
s/GENERICPAST/(<V[^>]* t="caite".>)*(<V p="2ú" t="ord".>)?(<V[^>]* t="caite".>)*/g
s/GENERICFUTURE/(<V[^>]* t="fáist".>)+/g
s/GENERICCOND/(<V[^>]* t="coinn".>)+/g
s/GENERICAUT/(<V p="saor" t="ord".>)?<V p="saor" t="láith".>(<V p="saor" t="foshuit".>)?/g
s/GENERICPAUT/<V p="saor" t="caite".><V p="3ú" t="ord".>/g
s/GENERICFIRST/<V p="1ú" t="ord".><V p="1ú" t="láith".>/g
s/GENERICSUB/(<V[^>]* t="foshuit".>)+/g
s/NUMERICAL/<N pl="n" gnt="n" gnd="m".><N pl="n" gnt="y" gnd="m".><A pl="n" gnt="n".>/g
s/COPULAPART/<U.><C.><Q.><V cop="y".>/g
s/\*P\[/*pl="y"[/g
s/\*CP\[/*pl="y" gnt="n"[/g
s/\*GP\[/*pl="y" gnt="y"[/g
s/\*CS\[/*pl="n" gnt="n"[/g
s/\*FCS\[/*pl="n" gnt="n" gnd="f"[/g
s/\*FCP\[/*pl="y" gnt="n" gnd="f"[/g
s/\*FGS\[/*pl="n" gnt="y" gnd="f"[/g
s/\*FGP\[/*pl="y" gnt="y" gnd="f"[/g
s/\*MCS\[/*pl="n" gnt="n" gnd="m"[/g
s/\*MCP\[/*pl="y" gnt="n" gnd="m"[/g
s/\*MGS\[/*pl="n" gnt="y" gnd="m"[/g
s/\*MGP\[/*pl="y" gnt="y" gnd="m"[/g
s/\*NOPAUT\[/*( p=.[^s]|t=..[^a])[/g
s/\*WITHH\[/*h="y"[/g
s/\*IMP\[/*t="ord"[/g
