s/abairti |/abairti > DEBUG1; (echo "Abairti done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG1 |/
s/unchecked_xml |/unchecked_xml > DEBUG2; (echo "Cuardach done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG2 |/
s/aonchiall |/aonchiall > DEBUG3; (echo "First Aonchiall done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG3 |/
s/| aonchiall |/| aonchiall > DEBUG4; (echo "Second Aonchiall done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG4 |/
s/unigram |/unigram > DEBUG5; (echo "Unigram done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG5 |/
s/rialacha |/rialacha > DEBUG6; (echo "Rialacha done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG6 |/
s/xml_output |/(echo "Start at"; date "+%F %T.%N") >> DEBUG.log; xml_output > DEBUG7; (echo "Eisceacht done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG7 |/
s/loganu |/loganu > DEBUG8; (echo "Comheadan and Loganu done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG8 |/
s/{versionstring}/{versionstring} DEBUG/
