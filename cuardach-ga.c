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

int
my_tolower_ga (const char *w, int *pos, char *lowered)
{
  char x = w[*pos];
  int ans;
  if (x & 0x80)
    ans = !(x & 0x20);
  else
    ans = (x >= 'A' && x <= 'Z');
  if (ans)
    lowered[*pos] = (x | 0x20);
  else
    lowered[*pos] = x;
  return ans;
}

/* exploit the fact that the only non-ASCII chars in Irish are vowels! */
int
vowel_p_ga (char w)
{
  char z = (w | 0x20);		/* tolower */
  return ((z & 0x80) || z == 'a' || z == 'e' || z == 'i' || z == 'o'
	  || z == 'u');
}

int
make_all_lowercase_ga (const char *word, char *lowered, int lowers,
		       int uppers, int firstupper)
{
  int i = 0;

  if (uppers == 0)
    return 0;
  else if (lowers == 0)
    return 1;
  else if (uppers > 1 && (lowers > 2 || lowers != firstupper))
    return 0;
  /* here, either exactly one upper, or one/two lowers+all uppers */
  else if (firstupper == 0)
    return 1;
  else if (firstupper == 1)
    {
      if (vowel_p_ga (word[1]))
	{
	  if (word[0] == 'n' || word[0] == 't')
	    {
	      i = strlen (lowered);
	      while (i > 0)
		{
		  lowered[i + 1] = lowered[i];
		  i--;
		}
	      lowered[1] = '-';
	      return 1;
	    }
	  else
	    return (word[0] == 'h');
	}
      else
	return ((word[0] == 'b' && word[1] == 'P') ||
		(word[0] == 'd' && word[1] == 'T') ||
		(word[0] == 'g' && word[1] == 'C') ||
		(word[0] == 'm' && word[1] == 'B') ||
		(word[0] == 'n' && (word[1] == 'D' || word[1] == 'G')) ||
		(word[0] == 't' && word[1] == 'S'));
    }

  else if (firstupper == 2)
    {
      return (word[0] == 'b' && word[1] == 'h' && word[2] == 'F');
    }
  else
    return 0;
}

/* all encoding conventions should be contained in here!
   using same markup code for part of speech as the National Irish Corpus
   www.ite.ie/corpus/pos.htm
   Though they use a generic "w" word tag and attributes for grammar.
     Used:        ACDGHIJKLMNOPQRSTUVW
                  ***  *    ********* 
    "E" is used as error markup code in my stuff
    "F" is used for marking up rare words
    "B" is used to markup ambiguous words
    "Z" is used inside <B></B> to markup list of ambigous parts of speech 
    "Y" is used for words to ignore (proper words or from .neamhshuim)
    "X" is used when a word is not in database
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
      if (c == (unsigned char) 127)
	{
	  strcpy (fill, "F");
	  return 0;
	}
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
      else if (tense == 2 && person == 0)
	{
	  strcat (attrs, " cop=\"y\"");
	  return 0;
	}
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
