#!/bin/bash
perl -I ${HOME}/gaeilge/gramadoir/gr/ga/Lingua-GA-Gramadoir/lib ${HOME}/gaeilge/gramadoir/gr/ga/Lingua-GA-Gramadoir/scripts/gram-ga.pl --ionchod=utf-8 --iomlan --xml | egrep '^<line>' | egrep -o '<([ABCDF-Z])[^>]*>[^<]+</\1>' | sed 's/^<[^>]*>//' | sed 's/<\//_/' | sed 's/>$//' |
sed '
s/_A/ ADJ/
s/_C/ CONJ/
s/_D/ DET/
s/_F/ X/
s/_G/ PRT/
s/_H/ PRT/
s/_I/ X/
s/_N/ NOUN/
s/_O/ ADP/
s/_P/ PRON/
s/_Q/ PRT/
s/_R/ ADV/
s/_S/ ADP/
s/_T/ DET/
s/_U/ X/
s/_V/ VERB/
s/_X/ X/
s/_Y/ VB/
'
