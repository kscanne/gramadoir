/*
  cuardach-ga.c : decodes Irish grammatical codes
 Copyright (C) 2003 Kevin P. Scannell <scannell@slu.edu>

 This is free software; see the file COPYING for copying conditions.  There is
 NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
*/

#if STDC_HEADERS
#include <stdio.h>
#include <string.h>
#else
/* trouble! */
#endif

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
int
byte_to_markup_ga (const unsigned char c, char *fill, char *attrs)
{
  int ret_val = 0;
  unsigned char pos = (0xc0 & c) >> 6;
  unsigned char person = (c & 0x18) >> 3;	/* verbs only */
  unsigned char tense = (c & 0x07);	/* verbs only */
  if (pos == 0)
    {
      strcpy (attrs, "");
      switch (c >> 2)
	{			/* pspeech.cxx */
	case 1:
	  strcpy (fill, "U");
	  break;		/* unknown/unique */
	case 2:
	  strcpy (fill, "T");
	  break;		/* article */
	case 3:
	  strcpy (fill, "S");
	  break;		/* adposition (prep) */
	case 4:
	  strcpy (fill, "P");	/* pronoun */
	  if (c & 2)
	    strcpy (attrs, " h=\"y\"");
	  break;
	case 5:
	  strcpy (fill, "O");	/* adposition (pronm) */
	  if (c & 2)
	    strcpy (attrs, " em=\"y\"");
	  break;
	case 6:
	  strcpy (fill, "R");
	  break;		/* adverb */
	case 7:
	  strcpy (fill, "C");
	  break;		/* conjunction */
	case 8:
	  strcpy (fill, "Q");
	  break;		/* interrogative */
	case 9:
	  strcpy (fill, "I");
	  break;		/* interjection */
	case 10:
	  strcpy (fill, "D");
	  break;		/* determiner (poss) */
	case 11:
	  strcpy (fill, "Y");
	  break;		/* proper name */
	};
    }
  else if (pos == 1 || pos == 2)
    {
      strcpy (attrs, "");
      if (pos == 1)
	strcpy (fill, "N");
      else
	strcpy (fill, "A");
      if (c & 0x20)
	strcat (attrs, " pl=\"y\"");
      else
	strcat (attrs, " pl=\"n\"");
      if (c & 0x10)
	strcat (attrs, " gnt=\"y\"");
      else
	strcat (attrs, " gnt=\"n\"");
      if (c & 0x08)
	{
	  if (c & 0x04)
	    strcat (attrs, " gnd=\"m\"");
	  else
	    strcat (attrs, " gnd=\"f\"");
	}
      if (c & 0x02)
	strcat (attrs, " h=\"y\"");
    }
  else
    {
      strcpy (fill, "V");
      strcpy (attrs, "");
      if (c & 0x20)
	strcat (attrs, " pl=\"y\"");
      switch (person)
	{
	case 0:
	  strcat (attrs, " p=\"saor\"");
	  break;
	case 1:
	  strcat (attrs, " p=\"1ú\"");
	  break;
	case 2:
	  strcat (attrs, " p=\"2ú\"");
	  break;
	case 3:
	  strcat (attrs, " p=\"3ú\"");
	  break;
	};
      switch (tense)
	{
	case 0:
	  strcat (attrs, " t=\"ord\"");
	  break;
	case 1:
	  strcat (attrs, " t=\"láith\"");
	  break;
	case 2:
	  ret_val = 1;
	  break;
	case 3:
	  strcat (attrs, " t=\"caite\"");
	  break;
	case 4:
	  strcat (attrs, " t=\"fáist\"");
	  break;
	case 5:
	  strcat (attrs, " t=\"gnáth\"");
	  break;
	case 6:
	  strcat (attrs, " t=\"coinn\"");
	  break;
	case 7:
	  strcat (attrs, " t=\"foshuit\"");
	  break;
	};
    }
  return ret_val;
}
