#include <stdio.h>
#include <string.h>
#include <stdlib.h>    /* strtol */
#include <ctype.h>     /* tolower, isupper, etc. */
#include <locale.h>    /* so tolower, etc. actually WORK! */

struct foirm {
      char focal[32], coid[16];
    };

#define DICTTOTAL 312627

struct foirm focloir[DICTTOTAL];

int load_dictionary()
    {
     FILE* bs;
     char temp[32], *hold;
     int cp, meid=1;

     if ((bs=fopen(BSONRAI,"r"))==NULL) return 1;
     if (fgets(focloir[0].focal, 32, bs)==NULL) return 1;
     if (fgets(focloir[0].coid, 16, bs)==NULL) return 1;
     while (fgets(temp, 32, bs) != NULL) {
	  strncpy(focloir[meid].focal, focloir[meid-1].focal, 
	          (int) strtol(temp, &hold, 10));
	  strcat(focloir[meid].focal, hold);
	  fgets(focloir[meid].coid, 16, bs);
	  meid++;
         }
     if (meid != DICTTOTAL) 
         fprintf(stderr, "gramadóir: rabhadh: deimhnigh méid foclóra: %d?\n", meid);
     if (fclose(bs)) 
         fprintf(stderr, "gramadóir: rabhadh: fadhb ag dúnadh an fhoclóra\n");
     return 0;
    }

/* all encoding conventions should be contained in here!
   using same markup code for part of speech as the National Irish Corpus
   www.ite.ie/corpus/pos.htm
   Though they use a generic "w" word tag and attributes for grammar.
     Used:        ACDINOPQRSTUV
    "E" is used as error markup code in my stuff
    "B" is used to markup ambiguous words
    "Z" is used inside <B></B> to markup list of ambigous parts of speech 
    "Y" is used for words to ignore (proper words or from .grignore)
    "X" is used when a word is not in database
     Changes to these codes need to be reflected in rialacha.meta.sed too
 */
void byte_to_markup(const unsigned char c, char* fill, char* attrs)
   {
     unsigned char pos = (0xc0 & c) >> 6;
     unsigned char person = (c & 0x18) >> 3;  /* verbs only */
     unsigned char tense =  (c & 0x07);       /* verbs only */
     if (pos==0) {
           strcpy(attrs, "");
           switch (c >> 2) {   /* pspeech.cxx */
                 case 1:    strcpy(fill, "U");  break;  /* unknown/unique */
                 case 2:    strcpy(fill, "T");  break;  /* article */
                 case 3:    strcpy(fill, "S");  break;  /* adposition (prep) */
                 case 4:    strcpy(fill, "P");          /* pronoun */
		            if (c & 2) 
			      strcpy(attrs, " h=\"y\"");
		            break;
                 case 5:    strcpy(fill, "O");          /* adposition (pronm) */
		            if (c & 2) 
			      strcpy(attrs, " em=\"y\"");
		            break;
                 case 6:    strcpy(fill, "R");   break; /* adverb */
                 case 7:    strcpy(fill, "C");   break; /* conjunction */
                 case 8:    strcpy(fill, "Q");   break; /* interrogative */
                 case 9:    strcpy(fill, "I");   break; /* interjection */
                 case 10:   strcpy(fill, "D");   break; /* determiner (poss) */
                 case 11:   strcpy(fill, "Y");   break; /* proper name */
	       };
	  }
     else if (pos==1 || pos==2) {
	   strcpy(attrs,"");
           if (pos==1) strcpy(fill, "N"); else strcpy(fill,"A");
	   if (c & 0x20) strcat(attrs," pl=\"y\"");
	   else strcat(attrs," pl=\"n\"");
	   if (c & 0x10) strcat(attrs," gnt=\"y\"");
	   else strcat(attrs," gnt=\"n\"");
	   if (c & 0x08) {
	        if (c & 0x04) strcat(attrs," gnd=\"m\"");
		else strcat(attrs," gnd=\"f\"");
	       }
	   if (c & 0x02) strcat(attrs," h=\"y\"");
	  }
     else {
           strcpy(fill, "V");
	   strcpy(attrs,"");
	   if (c & 0x20) strcat(attrs," pl=\"y\"");
	   switch (person) {
	        case 0: strcat(attrs, " p=\"saor\""); break;
	        case 1: strcat(attrs, " p=\"1ú\""); break;
	        case 2: strcat(attrs, " p=\"2ú\""); break;
	        case 3: strcat(attrs, " p=\"3ú\""); break;
	       };
           switch (tense) {
	        case 0: strcat(attrs, " t=\"ord\""); break;
	        case 1: strcat(attrs, " t=\"láith\""); break;
		case 2:
		  fprintf(stderr,"gramadóir: cód gramadach neamhcheadaithe\n");
		  break;
	        case 3: strcat(attrs, " t=\"caite\""); break;
	        case 4: strcat(attrs, " t=\"fáist\""); break;
	        case 5: strcat(attrs, " t=\"gnáth\""); break;
	        case 6: strcat(attrs, " t=\"coinn"); break;
	        case 7: strcat(attrs, " t=\"foshuit\""); break;
	       };
	  }
   }

/* cod has trailing newline on there */
void code_to_markup(const char* cod, char* fill, char* attrs, char* extratags)
   {
    int len=strlen(cod)-1, j;
    unsigned char c;
    char temp[8], tempatt[128];
    if (len > 1) {
         strcpy(fill, "B");
	 strcpy(attrs, "");
	 strcpy(extratags, "<Z>");
	 for (j=0; j < len; j++) {
              byte_to_markup(cod[j], temp, tempatt);
	      strcat(extratags, "<");
	      strcat(extratags, temp);
	      if (*tempatt) strcat(extratags, tempatt);
	      strcat(extratags, "/>");
	     }
	 strcat(extratags, "</Z>");
        }
    else if (len==1) {
         byte_to_markup(cod[0], fill, attrs);
	 strcpy(extratags,"");
        }
    else fprintf(stderr, "gramadóir: cód gramadach folamh\n");
   }

/* this does the actual log search, concatenates codes */
int rawlookup(const char* word, char* codes)
    {
     int min=0, max=DICTTOTAL-1;
     int guess, cmp;
     while (min <= max) {
          guess = (max+min)/2;
	  cmp = strcmp(focloir[guess].focal, word);
	  if (cmp == 0) {
	       strcat(codes, focloir[guess].coid);
	       return 1;
	      }
          else if (cmp < 0) min = guess+1;
          else max = guess-1;
         }
     return 0;
    }

/* Assert, word is non-zero length */
/* return non-zero iff some match found, so zero iff <X> markup */
void dictlookup(const char* word, char* fill, char* attrs, char* extratags)
    {
     int len;
     char unused, codes[32], lowered[32];
     *codes = 0;
     rawlookup(word, codes);
     if (isupper(word[0])) {
          strcpy(lowered, word);
	  *lowered = (char) tolower(word[0]);
	  len = strlen(codes);
	  unused = codes[len-1];
	  codes[len-1] = 0;
	  if (!rawlookup(lowered, codes)) {/* strip repeats? */
	      codes[len-1] = unused;
	      codes[len] = 0;
	     }
	 }
     if (*codes) code_to_markup(codes, fill, attrs, extratags);
     else {
           strcpy(fill, "X");   /* "residual" tag -- not in dictionary */
           strcpy(attrs, "");
           strcpy(extratags, "");
          }
    }

/* 
  w looks like "<c>word</c>!!'" or the like
  token includes leading characters too: "`<c>word</c>!!'"
*/
void markup(char* token, char* w)
    {
     char mu[8], attrs[128], extratags[512];
     char* tail = strstr(token, "</c>")+4;
     *(tail-4)='\n';              /* \n since it is kept around in focloir */ 
     *(tail-3)='\0';              /* null terminate the word itself */
     dictlookup(w+3, mu, attrs, extratags);
     *(tail-4)='\0';                
     *w = '\0';
     printf("%s", token);                /** chars before <c> **/
     printf("<%s", mu);                  /** new markup **/
     printf("%s", attrs);                /** attributes **/
     printf(">%s", extratags);           /** any additional tags **/
     printf("%s", w+3);                  /** word itself **/
     printf("</%s>", mu);                /** end of new markup **/
     printf("%s", tail);                 /** chars after </c> **/
    }

int main()
   {
    char token[512], *w;
    /* set locale for the toupper/tolower stuff, NOT for sorting
       since I use strcmp instead of strcoll -- if you look in the 
       makefile when focail.bs is built I set LC_COLLATE to POSIX */
    if (!setlocale(LC_CTYPE, "ga_IE.iso88591") ||
        !setlocale(LC_COLLATE, "ga_IE.iso88591")) {
         fprintf(stderr, "gramadóir: fadhb leis an logánú\n");
         return 1;
	}
    if (load_dictionary()) {
         fprintf(stderr, "gramadóir: fadhb ag léamh an bhunachair sonraí\n");
         return 1;
        }

    while (scanf("%s",token) != EOF)
          {
           if (strstr(token, "<line")==token) printf("\n");
           else printf(" ");
           if ((w=strstr(token, "<c>"))==NULL) 
                 printf("%s", token);
           else markup(token,w);
          }
    return 0;
   }
