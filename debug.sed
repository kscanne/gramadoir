s/abairti |/abairti > DEBUG1; (echo "Abairti done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG1 |/
s/unchecked_xml |/unchecked_xml > DEBUG2; (echo "Cuardach done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG2 |/
s/aonchiall |/aonchiall > DEBUG3; (echo "First Aonchiall done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG3 |/
s/| aonchiall |/| aonchiall > DEBUG4; (echo "Second Aonchiall done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG4 |/
s/rialacha |/rialacha > DEBUG5; (echo "Rialacha done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG5 |/
s/xml_output |/(echo "Start at"; date "+%F %T.%N") >> DEBUG.log; xml_output > DEBUG6; (echo "Eisceacht done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG6 |/
s/loganu |/loganu > DEBUG7; (echo "Comheadan and Loganu done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG7 |/
s/{versionstring}/{versionstring} DEBUG/
