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
/*  can redefine this to something like 257 to turn this business off */
#define RAREBYTE 127

int
main (int argc, char *argv[])
{
  const char unusedcode = '\n';
  char token[GR_WORDMAX], prev[GR_WORDMAX], repl[GR_WORDMAX];
  int code, m, pendingrarebit = 0;
  char codec;

  if (argc != 2)
    {
      fprintf (stderr, "Úsáid: cabhair [0|1]\n");
      return 1;
    }
  if (argv[1][0] == '0')
    {				/* focail.bs */
      scanf ("%s", prev);
      scanf ("%d", &code);
      codec = (char) code;
      printf ("%s%c%c", prev, unusedcode, codec);
      while (scanf ("%s", token) != EOF)
	{
	  scanf ("%d", &code);
	  codec = (char) code;
	  if (!strcmp (prev, token))
	    {
	      if (pendingrarebit)
		{
		  printf ("%c%d%s%c", unusedcode, m, token + m, unusedcode);
		  pendingrarebit = 0;
		}
	      if (code != RAREBYTE)
		printf ("%c", codec);
	      /* else, if it is 127, we've written this word before, so skip */
	    }
	  else
	    {
	      if (pendingrarebit)	/* previous word had just one code == 127 */
		printf ("%c%d%s%c%c", unusedcode, m, prev + m, unusedcode,
			(char) RAREBYTE);
	      m = 0;		/*  how much in common with previous word */
	      while (prev[m])
		{
		  if (prev[m] == token[m])
		    m++;
		  else
		    break;
		}
	      if (code != RAREBYTE)
		{
		  printf ("%c%d%s%c%c", unusedcode, m, token + m, unusedcode,
			  codec);
		  pendingrarebit = 0;
		}
	      else
		pendingrarebit = 1;
	      strcpy (prev, token);
	    }
	}
      printf ("%c", unusedcode);
    }
  else
    {
      strcpy (prev, "");
      while (scanf ("%s %s", token, repl) != EOF)
	{
	  if (!strcmp (prev, token))
	    {
	      printf (",_%s", repl);
	    }
	  else
	    {
	      printf ("\n%s %s", token, repl);
	      strcpy (prev, token);
	    }
	}
    }
  return 0;
}
