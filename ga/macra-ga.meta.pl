#!/usr/bin/perl
# Macros used in converting *.in files into *.pl scripts
# Copyright (C) 2004 Kevin P. Scannell <scannell@slu.edu>
#
# This is free software; see the file COPYING for copying conditions.  There is
# NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
s/ANYTHING/[^<]+/g;
s/CAPITALLENITED/[BCDFGMPST]h[^<]+/g;
s/CAPITAL/[A-ZÁÉÍÓÚ][^<]*/g;
s/CAPVOWEL/[AEIOUÁÉÍÓÚ][^<]*/g;
s/CAPVOWELWITHH/h[AEIOUÁÉÍÓÚ][^<]*/g;
s/LENITEDFUTURE/[Gg]heo[^<]+/g;
s/ABAIRPAST/[Dd]ú(?:irt|ra[dm]ar|radh)/g;
s/ABAIRPRFU/[Dd](?:eir|éar)[^<]*/g;
s/FAIGHFC/bhfaigh[^<]+/g;
s/ABSPASTVERB/(?:rinne[^<]*|chonai?c[^<]*|chua(?:igh|[md]ar|thas)|bhí(?:o[md]ar|othas)?)/g;
s/ABSNONPASTVERB/(?:n?gh?eo[bf][^<]+|d'íosf[^<]+|tá(?:im|imid|thar)?)/g;
# "ní bhfaighimid" is dep fut, but "faighimid" is abs pres so leave it out
s/DEPENDENT/(?:rai?bh(?:a[md]ar|thas)?|bhfuil(?:im|imid|tear)?|n?dh?each(?:aigh|a[md]ar|thas)|íosf[aá][^<]+|(?:bhf|fh)ac(?:a|a[dm]ar|thas)|(?:bhf|fh)aigh(?:idh|fear|inn|feá|eadh|imis|idís|fí)|n?dh?earn[^<]+)/g;
s/JUSTTA/[Tt]á(?:i[dm]|imid|thar)?/g;
s/NONRFORMCONJ/(?:[Gg]o|[Mm]ura|[Ss]ula)/g;
# dá done separately b/c of aonchiall issues
s/NONRFORMPREP/(?:faoi|i|le|ó|trí)na/g;
s/RFORMCONJ/(?:[Gg]ur|[Mm]urar|[Ss]ular)/g;
s/RFORMPREP/(?:dár|(?:faoi|i|le|ó|trí)nar)/g;
s/COMPOUND/[^< ]+ [^<]+/g;
s/GENITIVEPREP/(?:[Cc]ois|[Dd]ála|[Ff]earacht|[Tt]impeall|[Tt]rasna)/g;
s/IRREGULARPAST/(?:raibh|dtáinig|dtug|ndearnadh|gcuala|bhfuair)/g;
# separate fuarthas to avoid "fuaraíodh", etc.
s/PASTNORFORMLEN/(?:(?:dúi?r|rai?bh|fuair|fhac|dheach|dhearna)[^<]*|fuarthas)/g;
s/PASTNORFORM/(?:ndúi?r|rai?bh|bhfuai?r|bhfac|ndeach|ndearna)[^<]*/g;
s/PASTAFTERNI/(?:bhfuai?r|dúi?r|rai?bh|fhac|dheach|dhearna)[^<]*/g;
s/FAIGHECLIPSED/bh[Ff]ua(?:ir(?:ea[md]ar)?|rthas)/g;
s/FAIGHTOECLIPSE/[Ff]ua(?:ir(?:ea[md]ar)?|rthas)/g;
s/VOWELNUMERAL/(?:[0-9]?[18]|1?8[0-9][0-9][0-9]*)/g;
s/VOWELORDINAL/(?:80|[0-9]?[18]|1?8[0-9][0-9][0-9]*)ú/g;
s/NIBS/[Nn]í(?: ?ba|b)/g;
s/UNLENITEDS/[Ss][lnraeiouáéíóú][^<]+/g;
s/INITIALVOWELORF/(?:[aeiouAEIOUáéíóúÁÉÍÓÚ]|[Ff]h?[aeiouáéíóú])[^<]+/g;
s/INITIALVOWEL/[aeiouAEIOUáéíóúÁÉÍÓÚ][^<]*/g;
s/INITIALCONSONANT/[^aeiouAEIOUáéíóúÁÉÍÓÚ][^<]+/g;
s/NONVOWELNONF/(?:[^aeiouAEIOUáéíóúÁÉÍÓÚfF]|[Ff]h?[lr])[^<]+/g;
s/UNECLIPSEDDT/(?:[tT]|d[^Tt'])[^<]+/g;
# note this rule doesn't represent all possible eclipses since m/n don't ecl.
s/UNECLIPSEDCONS/(?:[cfptCFPT]|d[^Tt']|g[^Cc]|b[^Pph]|bh[^fF])[^<]+/g;
s/UNECLIPSED/(?:[aeiouAEIOUáéíóúÁÉÍÓÚcfptCFPT]|d[^Tt']|g[^Cc]|b[^Pph]|bh[^fF])[^<]*/g;
s/ECLIPSEDVOWEL/n(?:-[aeiouáéíóú]|[AEIOUÁÉÍÓÚ])[^<]*/g;
s/ECLIPSEDDT/(?:d[Tt]|n[Dd])[^<]+/g;
s/ECLIPSEDBCFGP/(?:g[Cc]|b[Pp]|m[Bb]|n[Gg]|bh[fF])[^<]+/g;
s/ECLIPSED/(?:n(?:-[aeiouáéíóú]|[AEIOUÁÉÍÓÚ])|d[Tt]|g[Cc]|b[Pp]|m[Bb]|n[DdGg]|bh[fF])[^<]*/g;
s/ECLIPSINGNUMBER/(?:n?[Dd]h?eich|[Nn]aoi|(?:h|[mbd]')?[Oo]cht|[Ss]h?eacht|[0-9]*[789]|[0-9]*10)/g;
s/ECLIPSINGPOSS/(?:(?:[Ff]aoin|[Ii]n|[Ll]en|[Óó]n|[Tt]rín)?(?:[Aa]|ár)|[Dd]?[Áá]r?|[Bb]hur|[Aa]rna)/g;
# all feminine
s/INITIALC/[Cc][^<]+/g;
s/INITIALH/h[^<]+/g;
s/INITIALL/[Ll][^<]+/g;
s/INITIALM/[Mm][^<]+/g;
s/INITIALN/[Nn][^<]+/g;
s/INITIALS/[Ss][lnraeiouáéíóúh][^<]+/g;
s/INITIALTS/t[sS][^<]+/g;
s/UNLENITABLE/(?:[^BbCcDdFfGgMmPpTt]|[Ss][^lnraeiouáéíóú])[^<]*/g;
s/UNLENITEDBCGMP/[BbCcGgMmPp][^h'][^<]*/g;
s/UNLENITEDBCFGMP/(?:[BbCcFfGgMmPp][^h']|bh[fF])[^<]*/g;
s/UNMUTATEDBCFGP/[BbCcFfGgPp][^hcCpP'][^<]*/g;
# s,m+vowel not *definitely* UNMUTATED since it could be an eclipsis scenario 
s/UNMUTATED/[BbCcDdFfGgPpTt][^hcCpPtT'][^<]*/g;
s/UNLENITEDF/[Ff][aeiouáéíóú][^<]*/g;
s/UNLENITED/(?:[BbCcDdFfGgMmPpTt][^h']|[Ss][lnraeiouáéíóú]|bh[Ff])[^<]*/g;
s/LENITEDF/[Ff]h[aeiouáéíóú][^<]*/g;
s/ORDINALADJ/(?:[^<][^<]*[^m]|[0-9]+)ú/g;
s/PREFIXEDT/t(?:[AEIOUÁÉÍÓÚ]|-[aeiouáéíóú])[^<]+/g;
s/EIRE/(?:[nh])?Éire(?:ann)?/g;
# gan/chun/ainneoin disallow "[^ >]+n"
s/FUSEDPOSS/(?:[Dd]ár?|(?:[Ff]aoi|[Ii]|[Ll]e|[Tt]rí)n(?:a|ár))/g;
s/FUSEDPREP/(?:[Dd][eo]n|[Ss]an?|[Ff]aoin|[Óó]n)/g;
# LGG p.32, CB p.134 (omitting infreq "dar", "ionsar", "os")
# neither lists "gan" but in practice dative forms used after it
# ok to include "tríd" here since it won't be resolved as <S>
# unless there is an article after it...
#   corpus is split on "idir" - LGG doesn't list it as dative
s/DATIVEPREP/(?:[Aa][grs]|[Cc]huig|[Dd][eo]|[Ff]aoi|[Gg]an|[Gg]o|[Ll]e|[Óó]|[Ii]n?|[Rr]oimh|[Tt]har|[Tt]ríd?|[Uu]m)/g;
s/INITIALDAPOST/d'[^<]+/g;
s/INITIALBAPOST/b'[^<]+/g;
s/LENITEDBCFGMPS/(?:[CcFfGgMmPpSs]h|[Bb]h[^fF])[^<]+/g;
s/MUTATEDDST/(?:n[Dd]|d[Tt]|[DdSsTt]h)[^<]+/g;
s/LENITEDDFST/[DdFfSsTt]h[^<]+/g;
s/LENITEDDST/[DdSsTt]h[^<]+/g;
s/LENITED/(?:[CcDdFfGgMmPpSsTt]h|[Bb]h[^fF])[^<]+/g;
s/SLENDERFINALCONSONANT/[^<]*[eéií][^aeiouáéíóú<]+/g;
s/BROADFINALCONSONANT/[^<]*[aáoóuú][^aeiouáéíóú<]+/g;
s/FINALVOWEL/[^<]*[^bcdfghjlmnprstvxz<]+/g;
s/FINALA/[^<]*[AÁaá]/g;
s/NOBEEAPOST/(?:[^b]|b[^'])[^<]+/g;
s/NOTVNISHVN/(?:bheith|cheannach|chur|dhíol|dhul|fhoghlaim|íoc|iompar|oscailt|rá|roinnt|scríobh|sholáthar|theacht)/g;
s/VNISH/[^<]*(?:a[dm]h|i[nr]t|áil|ú)/g;
s/NOTDO/[^<][^<][^<]+/g;
############################################################################
s/AWITHGSM/(?:<N pl="y"[^>]*>)*(?:<A[^>]*>)*<A pl="n" gnt="y" gnd="m".>(?:<A[^>]*>)*/g;
s/AWITHGSF/(?:<N pl="y"[^>]*>)*(?:<A[^>]*>)*<A pl="n" gnt="y" gnd="f".>(?:<A[^>]*>)*/g;
s/ANYWITHGSF/(?:<N pl="y"[^>]*>)*(?:<[^>]*>)*<A pl="n" gnt="y" gnd="f".>(?:<[^>]*>)*/g;
s/AWITHPL/(?:<N pl="y"[^>]*>)*(?:<A[^>]*>)*<A pl="y" gnt="n".>/g;
s/AWITHCOMMON/(?:<N pl="y"[^>]*>)*<A pl="n" gnt="n".>(?:<A[^>]*>)*/g;
s/ANYWITHCOMMONH/(?:<[^>]*>)*<A pl="n" gnt="n" h="y".>(?:<[^>]*>)*/g;
s/ANYWITHCOMMON/(?:<[^>]*>)*<A pl="n" gnt="n".>(?:<[^>]*>)*/g;
s/ANYNMGPL/(?:<[^>]*>)*<N pl="y" gnt="y" gnd="m".>(?:<[^>]*>)*/g;
s/ANYNFGPL/(?:<[^>]*>)*<N pl="y" gnt="y" gnd="f".>(?:<[^>]*>)*/g;
s/ANYNMGH/(?:<[^>]*>)*<N pl="n" gnt="y" gnd="m" h="y".>(?:<[^>]*>)*/g;
s/ANYNMG/(?:<[^>]*>)*<N pl="n" gnt="y" gnd="m".>(?:<[^>]*>)*/g;
s/ANYNFGH/(?:<[^>]*>)*<N pl="n" gnt="y" gnd="f" h="y".>(?:<[^>]*>)*/g;
s/ANYNFG/(?:<[^>]*>)*<N pl="n" gnt="y" gnd="f".>(?:<[^>]*>)*/g;
s/ANYNMCH/(?:<[^>]*>)*<N pl="n" gnt="n" gnd="m" h="y".>(?:<[^>]*>)*/g;
s/ANYNMC/(?:<[^>]*>)*<N pl="n" gnt="n" gnd="m".>(?:<[^>]*>)*/g;
s/ANYNFCH/(?:<[^>]*>)*<N pl="n" gnt="n" gnd="f" h="y".>(?:<[^>]*>)*/g;
s/ANYNFC/(?:<[^>]*>)*<N pl="n" gnt="n" gnd="f".>(?:<[^>]*>)*/g;
s/ANYNMPLH/(?:<[^>]*>)*<N pl="y" gnt="n" gnd="m" h="y".>(?:<[^>]*>)*/g;
s/ANYNMPL/(?:<[^>]*>)*<N pl="y" gnt="n" gnd="m".>(?:<[^>]*>)*/g;
s/ANYNFPLH/(?:<[^>]*>)*<N pl="y" gnt="n" gnd="f" h="y".>(?:<[^>]*>)*/g;
s/ANYNFPL/(?:<[^>]*>)*<N pl="y" gnt="n" gnd="f".>(?:<[^>]*>)*/g;
s/ANYCOPULA/(?:<[^>]*>)*<V cop="y".>(?:<[^>]*>)*/g;
s/ANYPASTIMPER/(?:<[^>]*>)*<V p="y" t="ord".><V p="y" t="caite".>(?:<[^>]*>)*/g;
s/ANYIMPER/(?:<[^>]*>)*<V p="y" t="ord".>(?:<[^>]*>)*/g;
s/ANYPASTAUT/(?:<[^>]*>)*<V p="n" t="caite".>(?:<[^>]*>)*/g;
s/ANYPAST/(?:<[^>]*>)*<V p="y" t="caite".>(?:<[^>]*>)*/g;
s/NMWITHHIMPER/<N pl="n" gnt="n" gnd="m" h="y".><V p="y" t="ord".>/g;
s/NFWITHHIMPER/<N pl="n" gnt="n" gnd="f" h="y".><V p="y" t="ord".>/g;
s/NFONEC/<N pl="n" gnt="n" gnd="f".><N pl="y" gnt="y" gnd="f".>/g;
s/ANYNMONEC/(?:<[^>]*>)*<N pl="n" gnt="n" gnd="m".><N pl="y" gnt="y" gnd="m".>(?:<[^>]*>)*/g;
s/ANYNMONE/(?:<[^>]*>)*<N pl="n" gnt="y" gnd="m".><N pl="y" gnt="n" gnd="m".>(?:<[^>]*>)*/g;
s/NMONEADJ/<N pl="n" gnt="n" gnd="m".><N pl="y" gnt="y" gnd="m".><A pl="n" gnt="n".>/g;
s/NMONEC/<N pl="n" gnt="n" gnd="m".><N pl="y" gnt="y" gnd="m".>/g;
s/NMONE/<N pl="n" gnt="y" gnd="m".><N pl="y" gnt="n" gnd="m".>/g;
s/ANDROGYN/<N pl="n" gnt="n" gnd="f".><N pl="n" gnt="y" gnd="m".>/g;
s/STRONGPLM/<N pl="y" gnt="n" gnd="m".><N pl="y" gnt="y" gnd="m".>/g;
s/STRONGPLF/<N pl="y" gnt="n" gnd="f".><N pl="y" gnt="y" gnd="f".>(?:<A pl="n" gnt="y" gnd="f".>)?/g;
# n-oibrí, n-éirí, etc.
s/NMFOURSUBJ/<N pl="n" gnt="n" gnd="m".><N pl="n" gnt="y" gnd="m".><V p="y" t="foshuit".>/g;
s/NMFOUR/<N pl="n" gnt="n" gnd="m".><N pl="n" gnt="y" gnd="m".>(?:<V p="." t="foshuit".>)?/g;
s/NFFOUR/<N pl="n" gnt="n" gnd="f".><N pl="n" gnt="y" gnd="f".>/g;
s/NMADJ/<N pl="n" gnt="n" gnd="m".>(?:<N pl="y" gnt="y" gnd="m".>)?<A pl="n" gnt="n".>(?:<[A-Z][^>]*>)*/g;
s/NFADJ/<N pl="n" gnt="n" gnd="f".><A pl="n" gnt="n".>(?:<[A-Z][^>]*>)*/g;
s/NOUNADJ/(?:<N[^>]*>)+<A pl="n" gnt="n".>(?:<[AV][^>]*>)*/g;
s/NMVERB/<N pl="n" gnt="n" gnd="m".>(?:<V p="y"[^>]*>)+/g;
s/NFVERB/<N pl="n" gnt="n" gnd="f".>(?:<V p="y"[^>]*>)+/g;
s/NMSUBJ/<N pl="n" gnt="n" gnd="m".><V p="." t="foshuit".>/g;
s/NPLMSUBJ/<N pl="y" gnt="n" gnd="m".><V p="." t="foshuit".>/g;
s/NPLFSUBJ/<N pl="y" gnt="n" gnd="f".><V p="." t="foshuit".>/g;
s/NPLF/<N pl="y" gnt="n".><N pl="y" gnt="n" gnd="f".>/g;
s/PLADJSUBJ/<A pl="y" gnt="n".><V p="." t="foshuit".>/g;
s/PRESSUBJ/<V p="y" t="láith".><V p="y" t="foshuit".>/g;
s/NFGSUBJ/<N pl="n" gnt="y" gnd="f".><V p="." t="foshuit".>/g;
# allowing feminine noun catches "breise" too; gets some absurdities like "ait"
s/GENADJ/<N pl="n" gnt="y" gnd=".".><A pl="n" gnt="n".><A pl="n" gnt="y" gnd="f".><A pl="n" gnt="y" gnd="m".><A pl="y" gnt="n".>/g;
s/PROPER/<Y.>(?:<[^>]*>)+/g;
s/MASCPL/<N pl="y" gnt="n".><N pl="y" gnt="n" gnd="m".>/g;
s/ADJADV/<R.><A pl="n" gnt="n".>/g;
s/PREPCONJ/<S.><C.>/g;
s/PREPPOSS/<S.><D.>/g;
s/PREPADV/<S.><R.>(?:<A pl="n" gnt="n".>)?/g;
s/PREPPRONM/<S.><O.>/g;
s/TEMPORAL/<R.><N pl="n" gnt="n".>/g;
s/SEOSIN/<P.><A pl="n" gnt="n".>(?:<A pl="n" gnt="y" gnd="m".>)?/g;
s/BHIODHLIKE/<V p="y" t="ord".><V p="y" t="gnáth".>/g;
# s/BHIDISLIKE/<V pl="y" p="[13]ú" t="ord".><V pl="y" p="[13]ú" t="gnáth".>/g;
s/PAUTGNATH/<V p="n" t="caite".><V p="y" t="ord".><V p="y" t="gnáth".>/g;
s/ADHWORD/<N pl="n" gnt="n" gnd="m".><V p="n" t="caite".><V p="y" t="ord".>(?:<V p="y" t="gnáth".>)?/g;
s/GENERICPAST/<V p="y" t="ord".><V p="y" t="caite".>/g;
s/GENERICAUT/(?:<V p="n" t="ord".>)?<V p="n" t="láith".>(?:<V p="n" t="foshuit".>)?/g;
s/GENERICPAUT/<V p="n" t="caite".><V p="y" t="ord".>/g;
s/GENERICFIRST/<V p="y" t="ord".><V p="y" t="láith".>/g;
s/NUMERICAL/<N pl="n" gnt="n" gnd="m".><N pl="n" gnt="y" gnd="m".><A pl="n" gnt="n".>/g;
s/COPULAPART/<U.><C.><Q.><V cop="y".>/g;
############################################################################
s/\*S\[/*pl="n"[/g;
s/\*P\[/*pl="y"[/g;
s/\*C\[/*gnt="n"[/g;
s/\*G\[/*gnt="y"[/g;
s/\*D\[/*gnt="d"[/g;
s/\*CP\[/*pl="y" gnt="n"[/g;
s/\*GP\[/*pl="y" gnt="y"[/g;
s/\*CS\[/*pl="n" gnt="n"[/g;
s/\*GS\[/*pl="n" gnt="y"[/g;
s/\*CDS\[/*pl="n" gnt="[nd]"[/g;
s/\*FCS\[/*pl="n" gnt="n" gnd="f"[/g;
s/\*FCP\[/*pl="y" gnt="n" gnd="f"[/g;
s/\*FGS\[/*pl="n" gnt="y" gnd="f"[/g;
s/\*FGP\[/*pl="y" gnt="y" gnd="f"[/g;
s/\*MCS\[/*pl="n" gnt="n" gnd="m"[/g;
s/\*MCP\[/*pl="y" gnt="n" gnd="m"[/g;
s/\*MGS\[/*pl="n" gnt="y" gnd="m"[/g;
s/\*MGP\[/*pl="y" gnt="y" gnd="m"[/g;
s/\*NOPAUT\[/*(?: p=.y|t=..[^a])[/g;
s/\*DEE\[/*t="(?:caite|gnáth|coinn)"[/g;
s/\*PWITHH\[/*pl="y" .+ h="y"[/g;
s/\*WITHH\[/*h="y"[/g;
s/\*IMP\[/*t="ord"[/g;
s/\*NOLEN\[/*t="[flo][^o][/g;
s/\*PAST\[/*t="caite"[/g;
s/\*SUBJ\[/*t="foshuit"[/g;
s/\*NOTPASTSUBJ\[/*t=".[^a][^s][/g;
s/\*NOTPAST\[/*t=".[^a][/g;
s/\*NOTCOP\[/* p="."[/g;
