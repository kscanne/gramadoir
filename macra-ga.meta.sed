# Macros used in converting *.in files into *.pl scripts
# Copyright (C) 2003 Kevin P. Scannell <scannell@slu.edu>
#
# This is free software; see the file COPYING for copying conditions.  There is
# NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
s/ANYTHING/[^<]+/g
s/CAPITALLENITED/[BCDFGMPST]h[^<]+/g
s/CAPITAL/[A-ZÁÉÍÓÚ][^<]*/g
s/LENITEDFUTURE/[Gg]heo[^<]+/g
s/ABAIRPRFU/[Dd](eir|éar)[^<]*/g
s/FAIGHFC/bhfaigh[^<]+/g
s/GODTI/[Gg]o dtí/g
s/ARBITH/[Aa]r bith/g
s/COMPOUND/[^< ]+ [^<]+/g
s/GENITIVEPREP/([Cc]ois|[Dd]ála|[Ff]earacht|[Tt]impeall|[Tt]rasna)/g
s/IRREGULARPAST/(raibh|dtáinig|dtug|ndearnadh|gcuala|bhfuair)/g
s/PASTNORFORMLEN/(dúi?r|rai?bh|fuai?r|fhac|dheach|dhearna)[^<]*/g
s/PASTNORFORM/(ndúi?r|rai?bh|bhfuai?r|bhfac|ndeach|ndearna)[^<]*/g
s/PASTAFTERNI/(bhfuai?r|dúi?r|rai?bh|fhac|dheach|dhearna)[^<]*/g
s/INITIALH/h[^<]+/g
s/INITIALS/[Ss][lnraeiouáéíóú][^<]+/g
s/INITIALVOWELORF/([aeiouAEIOUáéíóúÁÉÍÓÚ]|[Ff]h?[aeiouáéíóú])[^<]+/g
s/INITIALVOWEL/[aeiouAEIOUáéíóúÁÉÍÓÚ][^<]*/g
s/INITIALCONSONANT/[^aeiouAEIOUáéíóúÁÉÍÓÚ][^<]+/g
s/NONVOWELNONF/[^aeiouAEIOUáéíóúÁÉÍÓÚFf][^<]+/g
s/UNECLIPSEDDT/([tT]|d[^Tt'])[^<]+/g
s/UNECLIPSEDCONS/([cfptCFPT]|d[^Tt']|g[^Cc]|b[^Pph]|bh[^fF])[^<]+/g
s/UNECLIPSED/([aeiouAEIOUáéíóúÁÉÍÓÚcfptCFPT]|d[^Tt']|g[^Cc]|b[^Pph]|bh[^fF])[^<]*/g
s/ECLIPSED/(n(-[aeiouáéíóú]|[AEIOUÁÉÍÓÚ])|d[Tt]|g[Cc]|b[Pp]|bh[fF])[^<]*/g
s/UNLENITABLE/([^BbCcDdFfGgMmPpTt]|[Ss][^lnraeiouáéíóú])[^<]*/g
s/UNLENITEDBCGMP/([BbCcGgMmPp][^h']|bh[fF])[^<]*/g
s/UNLENITEDBCFGMP/([BbCcFfGgMmPp][^h']|bh[fF])[^<]*/g
s/UNMUTATEDBCFGP/[BbCcFfGgPp][^hcCpP'][^<]*/g
s/UNMUTATED/[BbCcDdFfGgPpTt][^hcCpPtT'][^<]*/g
s/UNLENITEDF/[Ff][^h][^<]*/g
s/UNLENITED/([BbCcDdFfGgMmPpTt][^h']|[Ss][lnraeiouáéíóú]|bh[Ff])[^<]*/g
s/ORDINALADJ/[^<][^<]*[^m]ú/
s/PREFIXEDT/t([AEIOUÁÉÍÓÚ]|-[aeiouáéíóú])[^<]+/g
s/LENITEDBCFGMPS/([CcFfGgMmPpSs]h|[Bb]h[^fF])[^<]+/g
s/LENITEDDFST/[DdFfSsTt]h[^<]+/g
s/LENITED/([CcDdFfGgMmPpSsTt]h|[Bb]h[^fF])[^<]+/g
s/SLENDERFINALCONSONANT/[^<]*[eéií][^aeiouáéíóú<]+/g
s/FINALVOWEL/[^<]*[^bcdfghjlmnprstvxz<]+/g
s/FINALA/[^<]*[AÁaá]/g
s/NOBEEAPOST/([^b]|b[^'])[^<]+/g
s/VNISH/[^<]*(a[dm]h|i[nr]t|áil|ú)/g
s/NOTDO/[^<][^<][^<]+/g
s/AWITHGSM/(<N pl="y"[^>]*>)*(<A[^>]*>)*<A pl="n" gnt="y" gnd="m".>(<A[^>]*>)*/g
s/AWITHGSF/(<N pl="y"[^>]*>)*(<A[^>]*>)*<A pl="n" gnt="y" gnd="f".>(<A[^>]*>)*/g
s/ANYWITHGSF/(<N pl="y"[^>]*>)*(<[^>]*>)*<A pl="n" gnt="y" gnd="f".>(<[^>]*>)*/g
s/AWITHPL/(<N pl="y"[^>]*>)*(<A[^>]*>)*<A pl="y" gnt="n".>/g
s/AWITHCOMMON/(<N pl="y"[^>]*>)*<A pl="n" gnt="n".>(<A[^>]*>)*/g
s/ANYWITHCOMMONH/(<[^>]*>)*<A pl="n" gnt="n" h="y".>(<[^>]*>)*/g
s/ANYWITHCOMMON/(<[^>]*>)*<A pl="n" gnt="n".>(<[^>]*>)*/g
s/ANYNMGPL/(<[^>]*>)*<N pl="y" gnt="y" gnd="m"( h="y")?.>(<[^>]*>)*/g
s/ANYNFGPL/(<[^>]*>)*<N pl="y" gnt="y" gnd="f"( h="y")?.>(<[^>]*>)*/g
s/ANYNMG/(<[^>]*>)*<N pl="n" gnt="y" gnd="m"( h="y")?.>(<[^>]*>)*/g
s/ANYNFG/(<[^>]*>)*<N pl="n" gnt="y" gnd="f"( h="y")?.>(<[^>]*>)*/g
s/ANYNMC/(<[^>]*>)*<N pl="n" gnt="n" gnd="m"( h="y")?.>(<[^>]*>)*/g
s/ANYNFC/(<[^>]*>)*<N pl="n" gnt="n" gnd="f"( h="y")?.>(<[^>]*>)*/g
s/ANYNMPL/(<[^>]*>)*<N pl="y" gnt="n" gnd="m"( h="y")?.>(<[^>]*>)*/g
s/ANYNFPL/(<[^>]*>)*<N pl="y" gnt="n" gnd="f"( h="y")?.>(<[^>]*>)*/g
s/ANYIMPER/(<[^>]*>)*<V[^>]*t="ord".>(<[^>]*>)*/g
s/NMWITHHIMPER/<N pl="n" gnt="n" gnd="m" h="y".><V p="2ú" t="ord".>/g
s/NFWITHHIMPER/<N pl="n" gnt="n" gnd="f" h="y".><V p="2ú" t="ord".>/g
s/NFONEC/<N pl="n" gnt="n" gnd="f".><N pl="y" gnt="y" gnd="f".>/g
s/ANYNMONEC/(<[^>]*>)*<N pl="n" gnt="n" gnd="m"( h="y")?.><N pl="y" gnt="y" gnd="m"( h="y")?.>(<[^>]*>)*/g
s/ANYNMONE/(<[^>]*>)*<N pl="n" gnt="y" gnd="m"( h="y")?.><N pl="y" gnt="n" gnd="m"( h="y")?.>(<[^>]*>)*/g
s/NMONEC/<N pl="n" gnt="n" gnd="m"( h="y")?.><N pl="y" gnt="y" gnd="m"( h="y")?.>/g
s/NMONE/<N pl="n" gnt="y" gnd="m"( h="y")?.><N pl="y" gnt="n" gnd="m"( h="y")?.>/g
s/ANDROGYN/<N pl="n" gnt="n" gnd="f".><N pl="n" gnt="y" gnd="m".>/g
s/STRONGPLM/<N pl="y" gnt="n" gnd="m"( h="y")?.><N pl="y" gnt="y" gnd="m"( h="y")?.>/g
s/STRONGPLF/<N pl="y" gnt="n" gnd="f"( h="y")?.><N pl="y" gnt="y" gnd="f"( h="y")?.>(<A pl="n" gnt="y" gnd="f".>)?/g
s/NMFOUR/<N pl="n" gnt="n" gnd="m".><N pl="n" gnt="y" gnd="m".>(<V [^>]*t="foshuit".>)*/g
s/NFFOUR/<N pl="n" gnt="n" gnd="f"( h="y")?.><N pl="n" gnt="y" gnd="f"( h="y")?.>/g
s/NMADJ/<N pl="n" gnt="n" gnd="m".>(<N pl="y" gnt="y" gnd="m".>)?<A pl="n" gnt="n".>(<[A-Z][^>]*>)*/g
s/NFADJ/<N pl="n" gnt="n" gnd="f".><A pl="n" gnt="n".>(<[A-Z][^>]*>)*/g
s/NOUNADJH/(<N[^>]*>)+<A pl="n" gnt="n" h="y".>(<[AV][^>]*>)*/g
s/NOUNADJ/(<N[^>]*>)+<A pl="n" gnt="n".>(<[AV][^>]*>)*/g
s/NMVERB/<N pl="n" gnt="n" gnd="m".>(<V p=".."[^>]*>)+/g
s/NFVERB/<N pl="n" gnt="n" gnd="f".>(<V p=".."[^>]*>)+/g
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
s/BHIODHLIKE/<V p="3ú" t="ord".><V p="3ú" t="gnáth".><V pl="y" p="2ú" t="gnáth".>/g
s/BHIDISLIKE/<V pl="y" p="[13]ú" t="ord".><V pl="y" p="[13]ú" t="gnáth".>/g
s/PAUTGNATH/<V p="saor" t="caite".><V p="3ú" t="ord".><V p="3ú" t="gnáth".><V pl="y" p="2ú" t="gnáth".>/g
s/ADHWORD/<N pl="n" gnt="n" gnd="m".><V p="saor" t="caite".><V p="3ú" t="ord".>(<V p="3ú" t="gnáth".><V pl="y" p="2ú" t="gnáth".>)?/g
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
s/\*C\[/*gnt="n"[/g
s/\*G\[/*gnt="y"[/g
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
s/\*NOLEN\[/*t="[flo][^o][/g
s/\*PAST\[/*t="caite"[/g
s/\*NOTPASTSUBJ\[/*t=".[^a][^s][/g
s/\*NOTPAST\[/*t=".[^a][/g
s/\*COP\[/*cop="y"[/g
