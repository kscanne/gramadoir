/* 
  This is a short program developers can use to create a database of words.
  See the Makefile target "focail.bs" for usage.

  Copyright (C) 2003 Kevin P. Scannell <scannell@slu.edu>
 
 This is free software; see the file COPYING for copying conditions.  There is
 NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
*/

#if STDC_HEADERS
#include <stdio.h>
#include <string.h>
#else
/* trouble */
#endif

/* ngearr-chlóscríobhneoireachta  has 28 */
#define GR_WORDMAX 32       

int main(int argc, char* argv[])
   {
    const char unusedcode='\n';
    char token[GR_WORDMAX], prev[GR_WORDMAX], repl[GR_WORDMAX];
    int code,m;
    char codec;

    if (argc != 2) {
        fprintf(stderr, "Úsáid: cabhair [0|1]\n");
	return 1;
       }
    if (argv[1][0]=='0') {   /* focail.bs */
  	  scanf("%s", prev);
   	  scanf("%d", &code);   codec = (char) code;
   	  printf("%s%c%c",prev,unusedcode,codec); 
   	  while (scanf("%s", token) != EOF) {
    	      scanf("%d", &code);   codec = (char) code;
		  if (!strcmp(prev,token)) {
		         printf("%c",codec);
		        }
     	          else {
		        m=0;
		        while (prev[m]) {
			     if (prev[m]==token[m]) m++;
			     else break;
			    }
		        printf("%c%d%s%c%c",unusedcode,m,token+m,unusedcode,codec); 
		        strcpy(prev,token);
		       }
      	     }
	 }
    else {
          strcpy(prev, "");
   	  while (scanf("%s %s", token, repl) != EOF) {
	       if (!strcmp(prev, token)) {
	             printf(",_%s", repl);
	            }
               else {
	             printf("\n%s %s", token, repl);
		     strcpy(prev, token);
	            }
	      }
         }
    return 0;
   }
