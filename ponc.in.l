%{
/* Lexer for the three *.in data files */
#include "y.tab.h"

extern int lineno;
%}

%option noyywrap

%%

^#.*		{return COMMENT;}

^[ \t]+		{return BLANK;}

\<[A-Z]*>	{return  POSTAG;}

\<\^[A-Z]*>	{return  NEGTAG;}

\<\/[A-Z]*>   {return  POSTAGEND;}

\<\/\^[A-Z]*> {return  NEGTAGEND;}

ANYTHING |
CAPITALLENITED |
CAPITAL |
INITIALS |
INITIALVOWELORF |
INITIALVOWEL |
UNECLIPSED |
UNLENITEDBCGMP |
UNLENITEDBCFGMP |
UNMUTATEDBCFGP |
UNLENITEDF |
UNLENITED |
LENITEDDFST |
LENITED |
SLENDERFINALCONSONANT |
FINALVOWEL 	{return MACRO;}

ANAITHNID |
ANAITHNIDSRL |
CLAOCHLU |
NISEIMHIU |
PREFIXH |
PREFIXT |
SEIMHIU |
URU 		{return MESSAGE;}

BACHOIR	|
CAIGHDEAN	 {return  MESSAGEPLUS;}


([A-Za-zΑΙΝΣΪαινσϊ[][-a-zαινσϊ'?]?|[a-zαινσϊ][A-Z])[][A-Za-zΑΙΝΣΪαινσϊ'?()|-]*	{return  WORD;}

"{"([A-Za-zΑΙΝΣΪαινσϊ][- a-zαινσϊ+']?|[a-zαινσϊ][A-Z])[- A-Za-zΑΙΝΣΪαινσϊ+']*"}" {return  MESSAGEARG;}

\n		{lineno++;}

.		{return yytext[0];}

%%
