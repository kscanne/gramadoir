%{
/* Grammar for the three *.in data files */
#include <stdio.h>
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
	do
	{
		yyparse();
	}
	while (!feof(yyin));
	if (errors) {
		printf("There were %d errors.\n", errors);
	     }
	else {
		printf("Successfully parsed %d lines, %d rules.\n", lineno-1, rules);
	}
	return (errors);
}

yyerror(s)
char* s;
{
	fprintf(stderr, "Line %d: %s\n", lineno, s);
	errors++;
}
