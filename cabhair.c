#include <stdio.h>
#include <string.h>

int main()
   {
    const char unusedcode='\n';
    char token[32], prev[32];   // ngearr-chlóscríobhneoireachta  has 28
    int code;
    char codec;
    scanf("%s", prev);
    scanf("%d", &code);   codec = (char) code;
    printf("%s%c%c",prev,unusedcode,codec); 
    while (scanf("%s", token) != EOF) {
          scanf("%d", &code);   codec = (char) code;
	  if (!strcmp(prev,token)) {
	         printf("%c",codec);
	        }
          else {
	        int m=0;
	        while (prev[m]) {
		     if (prev[m]==token[m]) m++;
		     else break;
		    }
	        printf("%c%d%s%c%c",unusedcode,m,token+m,unusedcode,codec); 
	        strcpy(prev,token);
	       }
         }
    return 0;
   }
