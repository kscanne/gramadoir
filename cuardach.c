/*
  cuardach.c : part of speech tagger for An Gramadóir
 Copyright (C) 2003 Kevin P. Scannell <scannell@slu.edu>

 This is free software; see the file COPYING for copying conditions.  There is
 NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
*/

#if STDC_HEADERS
#include <stdio.h>
#include <string.h>
#include <stdlib.h>    /* atoi, strtol */
#include <ctype.h>     /* tolower, isupper, etc. */
#include <locale.h>    /* so tolower, etc. actually WORK! */
#else
/* trouble! */
#endif

#define GR_WORDMAX 32
#define GR_AMBIGMAX 16
#define GR_FILENAMEMAX 128
#define GR_REPLMAX 8*GR_WORDMAX

struct foirm {
      char focal[GR_WORDMAX], coid[GR_AMBIGMAX];
    };

struct ignorable {
      char focal[GR_WORDMAX];
    };

struct replacement {
      char focal[GR_WORDMAX];
      char* athfhocal;
    };

#define DICTTOTAL 313956
int ignore_total=0;
int repl_total=0;

struct foirm focloir[DICTTOTAL];
struct ignorable* toignore=NULL;
struct replacement* torepl=NULL;

/* return 0 if everything went well enough to proceed, non-zero if not */
int load_replacements()
    {
     int wordlen, iomlan, retval=0;
     FILE* repl;
     char token[GR_REPLMAX+GR_WORDMAX];
     char fn[GR_FILENAMEMAX], countstr[8];
     char* split;
     
     strcpy(fn, BSONRAI);
     strcat(fn, "/eile.bs");
     repl = fopen(fn, "r");
     if (repl) {
           fgets(countstr, 8, repl);
	   countstr[strlen(countstr)-1]=0;
	   iomlan = atoi(countstr);
	   if (!iomlan) {
	         repl_total = 0;
	         return 0;   /* prevent bad malloc */ 
		}
	   torepl = malloc(iomlan * sizeof(struct replacement));
	   if (torepl==NULL) {
                               /* "An Gramadóir: out of memory\n" */
                fprintf(stderr, "An Gramadóir: cuimhne ídithe\n");
	        return 1;
	       }
	   while (!feof(repl) && repl_total != iomlan)
	   	{
	         fgets(token, GR_REPLMAX+GR_WORDMAX, repl);
		 split = strchr(token, ' ');
		 if (split==NULL) {
                      /* "An Gramadóir: corrupted eile.bs at %s\n" */
                      fprintf(stderr, "An Gramadóir: eile.bs truaillithe ag %s\n", token);
		      return 0;  /* muddle on thru */
		     }
		 else {
		       wordlen = split-token; 
		       torepl[repl_total].athfhocal = malloc(strlen(split));
		       if (torepl[repl_total].athfhocal==NULL) {
                               /* "An Gramadóir: out of memory\n" */
                              fprintf(stderr, "An Gramadóir: cuimhne ídithe\n");
	                      return 1;
		             }
		       strncpy(torepl[repl_total].focal, token, wordlen);
		       torepl[repl_total].focal[wordlen] = '\n';
		       torepl[repl_total].focal[wordlen+1] = 0;
		       strcpy(torepl[repl_total].athfhocal, split+1);
		       repl_total++; 
		      }
		}
	   if (repl_total != iomlan) {
                    /* "An Gramadóir: warning: check size of %s: %d?\n" */
                 fprintf(stderr, "An Gramadóir: rabhadh: deimhnigh méid de %s: %d?\n", fn, ignore_total);
	   	}
     	   if (fclose(repl)) {
                /* "An Gramadóir: warning: problem closing %s\n" */
                 fprintf(stderr, "An Gramadóir: rabhadh: fadhb ag dúnadh %s\n", fn);
                }
          }
     else retval=1;
     return retval;
    }

/* no return value, since no matter what happens we'll proceed */
void load_ignore()
    {
     int iomlan;
     FILE* grig;
     char* baile; 
     char grignore[GR_FILENAMEMAX], countstr[8];
     
     baile = getenv("HOME");
     strcpy(grignore, baile);
     strcat(grignore, "/.neamhshuim");
     grig = fopen(grignore, "r");
     if (grig) {
           fgets(countstr, 8, grig);
	   countstr[strlen(countstr)-1]=0;
	   iomlan = atoi(countstr);
	   if (!iomlan) return;  /* in case of bad malloc */
	   toignore = malloc(iomlan * sizeof(struct ignorable));
	   if (toignore==NULL) {
                               /* "An Gramadóir: warning: out of memory\n" */
                 fprintf(stderr, "An Gramadóir: rabhadh: cuimhne ídithe\n");
	        return; 
	       }
	   while (!feof(grig) && ignore_total != iomlan)
	   	{
	         fgets(toignore[ignore_total].focal, GR_WORDMAX, grig);
		 ignore_total++; 
		}
	   if (ignore_total != iomlan) {
                    /* "An Gramadóir: warning: check size of %s: %d?\n" */
                 fprintf(stderr, "An Gramadóir: rabhadh: deimhnigh méid de %s: %d?\n", grignore, ignore_total);
	   	}
     	   if (fclose(grig)) {
                /* "An Gramadóir: warning: problem closing %s\n" */
                 fprintf(stderr, "An Gramadóir: rabhadh: fadhb ag dúnadh %s\n", grignore);
                }
          }
     else /* move on silently */  ;
    }

int load_dictionary()
    {
     FILE* bs;
     char fn[GR_FILENAMEMAX], temp[GR_WORDMAX], *hold;
     int cp, meid=1;

     strcpy(fn, BSONRAI);
     strcat(fn, "/focail.bs");
     if ((bs=fopen(fn,"r"))==NULL) return 1;
     if (fgets(focloir[0].focal, GR_WORDMAX, bs)==NULL) return 1;
     if (fgets(focloir[0].coid, GR_AMBIGMAX, bs)==NULL) return 1;
     while (fgets(temp, GR_WORDMAX, bs) != NULL) {
	  strncpy(focloir[meid].focal, focloir[meid-1].focal, 
	          (int) strtol(temp, &hold, 10));
	  strcat(focloir[meid].focal, hold);
	  fgets(focloir[meid].coid, GR_AMBIGMAX, bs);
	  meid++;
         }
     if (meid != DICTTOTAL) {
                    /* "An Gramadóir: warning: check dictionary size: %d?\n" */
         fprintf(stderr, "An Gramadóir: rabhadh: deimhnigh méid foclóra: %d?\n", meid);
	 }
     if (fclose(bs)) {
                /* "An Gramadóir: warning: problem closing the dictionary\n" */
         fprintf(stderr, "An Gramadóir: rabhadh: fadhb ag dúnadh an fhoclóra\n");
	 }
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
    "Y" is used for words to ignore (proper words or from .neamhshuim)
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
		/*      "An Gramadóir: illegal grammatical code\n" */
		  fprintf(stderr,"An Gramadóir: cód gramadach neamhcheadaithe\n");
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
    else {
                       /* "An Gramadóir: no grammar codes\n" */
          fprintf(stderr, "An Gramadóir: cód gramadach folamh\n");
	 }
   }

/* this does the actual log search, concatenates codes */
/* word is terminated with "\n\0" already */
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

/* Assert: toignore != NULL */
/* word is terminated with "\n\0" already */
int rawignorelookup(const char* word)
    {
     int min=0, max=ignore_total-1;
     int guess, cmp;
     while (min <= max) {
          guess = (max+min)/2;
	  cmp = strcmp(toignore[guess].focal, word);
	  if (cmp == 0) return 1;
          else if (cmp < 0) min = guess+1;
          else max = guess-1;
         }
     return 0;
    }

/* word is terminated with "\n\0" already */
int replacementlookup(const char* word, char* repl)
    {
     int min=0, max=repl_total-1;
     int guess, cmp;
     while (min <= max) {
          guess = (max+min)/2;
	  cmp = strcmp(torepl[guess].focal, word);
	  if (cmp == 0) {
	         strcpy(repl, torepl[guess].athfhocal);
		 repl[strlen(repl)-1]='}';  /* replace newline */
	         return 1;
		}
          else if (cmp < 0) min = guess+1;
          else max = guess-1;
         }
     return 0;
    }

/* Assert, word is non-zero length, terminated with "\n\0" */
int dictlookup(const char* word, char* fill, char* attrs, char* extratags)
    {
     int len, retval=1;
     char unused, repl[GR_REPLMAX], codes[2*GR_AMBIGMAX], lowered[GR_WORDMAX];
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
           strcpy(attrs, "");
           strcpy(extratags, "");
           strcpy(fill, "X");   /* "residual" tag -- not in dictionary */
	   if (toignore != NULL) {
	         if (rawignorelookup(word)) {strcpy(fill, "Y"); return 1;}
		}
	   if (replacementlookup(word, repl)) retval=0;
	   else if (isupper(word[0])) {
	             if (replacementlookup(lowered, repl)) retval=0;
	            }
           if (retval==0) {
	        strcpy(fill, "E");
                strcpy(extratags, "<Y>");
		strcpy(attrs, " msg=\"CAIGHDEAN{");
		strcat(attrs, repl);
		strcat(attrs, "\"");
               }
          }
     return retval;
    }

/* 
  w points into the "token": looks like "<c>word</c>!!'" or the like.
  token includes leading characters too: "`<c>word</c>!!'"
  No guarantee that the token is well-formed (e.g. if len>=512)
  Return 1 if no <c> or </c> and token is filled up (len==511), 0 otherwise
*/
int markup(char* token)
    {
     char mu[8], attrs[128], extratags[512];
     char* tail, *w; 
     int val;

     w=strstr(token, "<c>");
     tail = strstr(token, "</c>");
     if (tail==NULL || w==NULL) {   /* e.g. punct, "<line", length>511, etc. */
          printf("%s",token);
	  return (strlen(token)==511);
	 }
     else {
        *tail='\n';              /* \n since it is kept around in focloir */ 
        *(tail+1)='\0';              /* null terminate the word itself */
        val=dictlookup(w+3, mu, attrs, extratags);
        *tail='\0';                
        *w = '\0';
        printf("%s", token);              /** chars before <c> **/
        printf("<%s", mu);                /** new markup **/
        printf("%s", attrs);              /** attributes **/
        printf(">%s", extratags);         /** any additional tags **/
        printf("%s", w+3);                /** word itself **/
        if (!val) printf("</Y>");         /** dummy markup in case of repl. **/
        printf("</%s>", mu);              /** end of new markup **/
        printf("%s", tail+4);             /** chars after </c> **/
       }
     return 0;
    }

void cleanup()
   {
    int l;
    if (toignore != NULL) free(toignore);
    for (l=0; l < repl_total; l++) 
       free(torepl[repl_total].athfhocal);
   }

int main(int argc, char* argv[])
   {
    char token[512], *w;
    int badtoken=0;

    if (argc != 2) {
                      /* "An Gramadóir: problem with the 'cuardach' command" */
            fprintf(stderr, "An Gramadóir: fadhb leis an ordú 'cuardach'\n");
	    return 1;
           }

    /* set locale for the toupper/tolower stuff, NOT for sorting
       since I use strcmp instead of strcoll -- if you look in the 
       makefile when focail.bs is built I set LC_COLLATE to POSIX */
    if (!setlocale(LC_CTYPE, "ga_IE.iso88591")) 
       if (!setlocale(LC_CTYPE, "en_US.iso88591"))
         if (!setlocale(LC_CTYPE, "en_US.ISO8859-1")) {
                         /* "An Gramadóir: problem with the locale\n" */
            fprintf(stderr, "An Gramadóir: fadhb leis an logánú\n");
            return 1;
	   }
      if (load_dictionary() || load_replacements()) {
                   /* "An Gramadóir: problem reading the database\n" */
         fprintf(stderr, "An Gramadóir: fadhb ag léamh an bhunachair sonraí\n");
	 cleanup();
         return 1;
        }

    if (!strcmp(argv[1], "ignore")) load_ignore();

    printf("<?xml version=\"1.0\" encoding=\"ISO-8859-1\" standalone=\"no\"?>\n");
    printf("<!DOCTYPE teacs SYSTEM \"/dtds/gramadoir.dtd\">\n");
    printf("<teacs>");
    while (scanf("%511s",token) != EOF)
          {
           if (!strcmp(token, "<line")) printf("\n");
           else if (!badtoken) printf(" ");
	   badtoken=markup(token);
          }
    printf("\n</teacs>\n");
    cleanup();
    return 0;
   }
