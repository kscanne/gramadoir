%{
/* Grammar for the three *.in data files */
#include <stdio.h>
#include <locale.h>
#include "gettext.h"
int lineno = 1;
int errors = 0;
int rules = 0;
%}

%token POSTAG NEGTAG POSTAGEND NEGTAGEND WORD MESSAGE MESSAGEARG MACRO MESSAGEPLUS COMMENT BLANK

%%

lines: 		line
	|	lines line
	;

line:		COMMENT
	|	BLANK
	|	rule
	;

rule:		phrase ':' _TAIL_MACRO_  	{rules++;}
	;

phrase:		phrase ' ' oneword
	|	oneword
	;

result:	 	_RESULT_MACRO_  ;

oneword:	tagged_word
	|	untagged_word
	;

tagged_word:	POSTAG untagged_word POSTAGEND
	|	NEGTAG untagged_word NEGTAGEND
	;

untagged_word:	WORD
	|	MACRO
	;


%%

extern FILE *yyin;

main()
{
  setlocale (LC_MESSAGES, "");  /* read from environment */
  setlocale (LC_CTYPE, "");     /* needed so accents appear correctly! */
  bindtextdomain (PACKAGE_NAME, LOCALEDIR);
  textdomain (PACKAGE_NAME);

	do
	{
		yyparse();
	}
	while (!feof(yyin));
	if (errors) {
		printf(ngettext ("There was %d error.\n",
		                 "There were %d errors.\n", 
				 errors), errors);
	     }
	else {
	        /* used to print number of lines parsed too: lineno-1 */
		printf(ngettext ("Successfully parsed %d rule.\n",
		                 "Successfully parsed %d rules.\n",
				 rules), rules);
	}
	return (errors);
}

yyerror(s)
char* s;
{
	fprintf(stderr, gettext ("Line %d: %s\n"), lineno, s);
	errors++;
}
