s/abairti |/abairti > DEBUG1; (echo "Abairti done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG1 |/
s/unchecked_xml |/unchecked_xml > DEBUG2; (echo "Cuardach done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG2 |/
s/comhshuite |/comhshuite > DEBUG3; (echo "Comhshuite done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG3 |/
s/aonchiall |/aonchiall > DEBUG4; (echo "First Aonchiall done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG4 |/
s/| aonchiall |/| aonchiall > DEBUG5; (echo "Second Aonchiall done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG5 |/
s/unigram |/unigram > DEBUG6; (echo "Unigram done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG6 |/
s/rialacha |/rialacha > DEBUG7; (echo "Rialacha done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG7 |/
/XML_OUTPUT.*|/s/.*/(echo "Start at"; date "+%F %T.%N") >> DEBUG.log; "${XML_OUTPUT}" > DEBUG8; (echo "Eisceacht done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG8 |/
s/loganu |/loganu > DEBUG9; (echo "Comheadan and Loganu done"; date "+%F %T.%N") >> DEBUG.log; cat DEBUG9 |/
s/{versionstring}/{versionstring} DEBUG/
