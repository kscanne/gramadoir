/*
  cuardach.c : part of speech tagger for An Gramadóir
 Copyright (C) 2003 Kevin P. Scannell <scannell@slu.edu>

 This is free software; see the file COPYING for copying conditions.  There is
 NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
*/

#if STDC_HEADERS
#include <stdio.h>
#include <string.h>
#include <stdlib.h>		/* atoi, strtol */
#include <locale.h>
#include "gettext.h"
#else
/* trouble! */
#endif

#define GR_WORDMAX 32
#define GR_AMBIGMAX 16
#define GR_FILENAMEMAX 128
#define GR_REPLMAX 8*GR_WORDMAX

struct foirm
{
  char focal[GR_WORDMAX];
  unsigned char coid[GR_AMBIGMAX];
};

struct ignorable
{
  char focal[GR_WORDMAX];
};

struct replacement
{
  char focal[GR_WORDMAX];
  char *athfhocal;
};

char packagename[64];
char teanga[8];

int dict_total = 0;
int ignore_total = 0;
int repl_total = 0;

struct foirm *focloir = NULL;
struct ignorable *toignore = NULL;
struct replacement *torepl = NULL;

extern void byte_to_markup (const char *tng, const char *pkg,
			    const unsigned char c, char *fill, char *attrs);

/* return 0 if everything went well enough to proceed, non-zero if not */
int
load_replacements ()
{
  int wordlen, iomlan, retval = 0;
  FILE *repl;
  char token[GR_REPLMAX + GR_WORDMAX];
  char fn[GR_FILENAMEMAX], countstr[16], replfile[16] = "eile-";
  char *split;

  strcat (replfile, teanga);
  strcat (replfile, ".bs");
  strcpy (fn, BSONRAI);
  strcat (fn, "/");
  strcat (fn, replfile);
  repl = fopen (fn, "r");
  if (repl)
    {
      fgets (countstr, 16, repl);
      countstr[strlen (countstr) - 1] = 0;
      iomlan = atoi (countstr);
      if (!iomlan)
	{
	  repl_total = 0;
	  return 0;		/* prevent bad malloc */
	}
      torepl = malloc (iomlan * sizeof (struct replacement));
      if (torepl == NULL)
	{
	  fprintf (stderr, gettext ("%s: out of memory\n"), packagename);
	  return 1;
	}
      while (!feof (repl) && repl_total != iomlan)
	{
	  fgets (token, GR_REPLMAX + GR_WORDMAX, repl);
	  split = strchr (token, ' ');
	  if (split == NULL)
	    {
	      fprintf (stderr, gettext ("%s: `%s' corrupted at %s\n"),
		       packagename, replfile, token);
	      return 0;		/* muddle on thru */
	    }
	  else
	    {
	      wordlen = split - token;
	      torepl[repl_total].athfhocal = malloc (strlen (split));
	      if (torepl[repl_total].athfhocal == NULL)
		{
		  fprintf (stderr, gettext ("%s: out of memory\n"),
			   packagename);
		  return 1;
		}
	      strncpy (torepl[repl_total].focal, token, wordlen);
	      torepl[repl_total].focal[wordlen] = '\n';
	      torepl[repl_total].focal[wordlen + 1] = 0;
	      strcpy (torepl[repl_total].athfhocal, split + 1);
	      repl_total++;
	    }
	}
      if (repl_total != iomlan)
	{
	  fprintf (stderr, gettext ("%s: warning: check size of %s: %d?\n"),
		   packagename, replfile, ignore_total);
	}
      if (fclose (repl))
	{
	  fprintf (stderr, gettext ("%s: warning: problem closing %s\n"),
		   packagename, replfile);
	}
    }
  else
    retval = 1;
  return retval;
}

/* takes opened, non-zero FILE pointer and reads in words to ignore */
/* problem is signified in calling routine by (toignore==NULL) */
int
real_loader (char *grignore, FILE * grig)
{
  int iomlan;
  char countstr[16];

  fgets (countstr, 16, grig);
  countstr[strlen (countstr) - 1] = 0;
  iomlan = atoi (countstr);
  if (!iomlan)
    return;			/* in case of bad malloc */
  toignore = malloc (iomlan * sizeof (struct ignorable));
  if (toignore == NULL)
    {
      fprintf (stderr, gettext ("%s: out of memory\n"), packagename);
      return;
    }
  while (!feof (grig) && ignore_total != iomlan)
    {
      fgets (toignore[ignore_total].focal, GR_WORDMAX, grig);
      ignore_total++;
    }
  if (ignore_total != iomlan)
    {
      fprintf (stderr,
	       gettext ("%s: warning: check size of %s: %d?\n"),
	       packagename, grignore, ignore_total);
    }
  if (fclose (grig))
    {
      fprintf (stderr, gettext ("%s: warning: problem closing %s\n"),
	       packagename, grignore);
    }
}


/* no return value, since no matter what happens we'll proceed */
void
load_ignore ()
{
  FILE *grig;
  char *baile;
  char grignore[GR_FILENAMEMAX];

  baile = getenv ("HOME");
  if (baile != NULL)
    {
      strcpy (grignore, baile);
      strcat (grignore, "/.neamhshuim");
      grig = fopen (grignore, "r");
      if (grig)
	{
	  real_loader (grignore, grig);
	  return;
	}
    }
  strcpy (grignore, BSONRAI);
  strcat (grignore, "/Neamhshuim");
  grig = fopen (grignore, "r");
  if (grig)
    real_loader (grignore, grig);
}

int
load_dictionary ()
{
  FILE *bs;
  char fn[GR_FILENAMEMAX], temp[GR_WORDMAX], *hold;
  int meid = 1;
  char dictfile[16] = "focail-";
  char countstr[16];

  strcat (dictfile, teanga);
  strcat (dictfile, ".bs");
  strcpy (fn, BSONRAI);
  strcat (fn, "/");
  strcat (fn, dictfile);
  if ((bs = fopen (fn, "r")) == NULL)
    return 1;
  fgets (countstr, 16, bs);
  countstr[strlen (countstr) - 1] = 0;
  dict_total = atoi (countstr);
  if (!dict_total)
    return 0;			/* in case of bad malloc - main() works with focloir NULL! */
  focloir = malloc (dict_total * sizeof (struct foirm));
  if (focloir == NULL)
    {
      fprintf (stderr, gettext ("%s: out of memory\n"), packagename);
      return 1;
    }
  if (fgets (focloir[0].focal, GR_WORDMAX, bs) == NULL)
    return 1;
  if (fgets (focloir[0].coid, GR_AMBIGMAX, bs) == NULL)
    return 1;
  while (fgets (temp, GR_WORDMAX, bs) != NULL)
    {
      strncpy (focloir[meid].focal, focloir[meid - 1].focal,
	       (int) strtol (temp, &hold, 10));
      strcat (focloir[meid].focal, hold);
      fgets (focloir[meid].coid, GR_AMBIGMAX, bs);
      meid++;
    }
  if (meid != dict_total)
    {
      fprintf (stderr,
	       gettext ("%s: warning: check size of %s: %d?\n"),
	       packagename, dictfile, meid);
    }
  if (fclose (bs))
    {
      fprintf (stderr,
	       gettext ("%s: warning: problem closing %s\n"), packagename,
	       dictfile);
    }
  return 0;
}

/* cod has trailing newline on there */
/* return 0 if ok, 1 if problem */
int
code_to_markup (const unsigned char *cod, char *fill, char *attrs,
		char *extratags)
{
  int len = strlen (cod) - 1, j;
  char temp[8], tempatt[128];
  if (len > 1)
    {
      strcpy (fill, "B");
      strcpy (attrs, "");
      strcpy (extratags, "<Z>");
      for (j = 0; j < len; j++)
	{
	  byte_to_markup (teanga, packagename, cod[j], temp, tempatt);
	  strcat (extratags, "<");
	  strcat (extratags, temp);
	  if (*tempatt)
	    strcat (extratags, tempatt);
	  strcat (extratags, "/>");
	}
      strcat (extratags, "</Z>");
      return 0;
    }
  else if (len == 1)
    {
      byte_to_markup (teanga, packagename, cod[0], fill, attrs);
      strcpy (extratags, "");
      return 0;
    }
  else
    return 1;
}

/* this does the actual log search, concatenates codes */
/* word is terminated with "\n\0" already */
/* return 1 if found, 0 otherwise */
int
rawlookup (const char *word, unsigned char *codes)
{
  int min = 0, max = dict_total - 1;
  int guess, cmp;
  while (min <= max)
    {
      guess = (max + min) / 2;
      cmp = strcmp (focloir[guess].focal, word);
      if (cmp == 0)
	{
	  strcat (codes, focloir[guess].coid);
	  return 1;
	}
      else if (cmp < 0)
	min = guess + 1;
      else
	max = guess - 1;
    }
  return 0;
}

/* Assert: toignore != NULL */
/* word is terminated with "\n\0" already */
int
rawignorelookup (const char *word)
{
  int min = 0, max = ignore_total - 1;
  int guess, cmp;
  while (min <= max)
    {
      guess = (max + min) / 2;
      cmp = strcmp (toignore[guess].focal, word);
      if (cmp == 0)
	return 1;
      else if (cmp < 0)
	min = guess + 1;
      else
	max = guess - 1;
    }
  return 0;
}

/* word is terminated with "\n\0" already */
int
replacementlookup (const char *word, char *repl)
{
  int min = 0, max = repl_total - 1;
  int guess, cmp;
  while (min <= max)
    {
      guess = (max + min) / 2;
      cmp = strcmp (torepl[guess].focal, word);
      if (cmp == 0)
	{
	  strcpy (repl, torepl[guess].athfhocal);
	  repl[strlen (repl) - 1] = '}';	/* replace newline */
	  return 1;
	}
      else if (cmp < 0)
	min = guess + 1;
      else
	max = guess - 1;
    }
  return 0;
}

/* used to set the locale for these and use ctype functions.
  Might as well do them myself for those without Latin-1 locales. 
  In each case we may assume that "x" is an Irish latin-1 character
  since others are filtered out earlier */

char
my_tolower (const char x)
{
  return (x | 0x20);		/* know that x is upper as determined by my_isupper */
}

int
my_isupper (const char x)
{
  if (x & 0x80)
    return !(x & 0x20);
  else
    return (x >= 'A' && x <= 'Z');
}

int
sort_bytes (const void *a, const void *b)
{
  return (*(const unsigned char *) a - *(const unsigned char *) b);
}

/* Assert, word is non-zero length, terminated with "\n\0" */
/* return 0 iff found in replacement dict and <E> will be the markup */
int
dictlookup (const char *word, char *fill, char *attrs, char *extratags)
{
  int i, j, k, len, totlen, retval = 1;
  unsigned char prev, unused, codes[2 * GR_AMBIGMAX];
  char repl[GR_REPLMAX], lowered[GR_WORDMAX];
  *codes = 0;
  rawlookup (word, codes);
  if (my_isupper (word[0]))
    {
      i = 0;
      while (word[i] != 0)
	{
	  if (my_isupper (word[i]))
	    lowered[i] = my_tolower (word[i]);
	  else
	    lowered[i] = word[i];
	  i++;
	}
      lowered[i] = 0;
      len = strlen (codes) - 1;
      if (len < 0)
	len = 0;
      unused = codes[len];
      codes[len] = 0;
      if (!rawlookup (lowered, codes))
	{
	  codes[len] = unused;
	  codes[len + 1] = 0;
	}
      else
	{
	  if (len)
	    {
	      totlen = strlen (codes) - 1;	/* ASSERT: at least two */
	      qsort (codes, (size_t) totlen, sizeof (unsigned char),
		     sort_bytes);
	      if (totlen > 2 || codes[0] != codes[1])
		{		/* strip repeats */
		  j = 0;
		  prev = (unsigned char) 127;
		  for (k = 0; k < totlen; k++)
		    {
		      if (codes[k] != prev && codes[k] != (unsigned char) 127)
			{
			  if (j < k)
			    codes[j] = codes[k];
			  j++;
			}
		      prev = codes[j - 1];
		    }
		}
	      else
		j = 1;
	      codes[j] = unused;
	      codes[j + 1] = 0;
	    }			/* if capital word was found originally */
	}			/* if lowered version found */
    }				/* if capital */
  if (*codes)
    {
      if (code_to_markup (codes, fill, attrs, extratags))
	fprintf (stderr, gettext ("%s: no grammar codes: %s\n"), packagename,
		 word);
    }
  else
    {
      strcpy (attrs, "");
      strcpy (extratags, "");
      strcpy (fill, "X");	/* "residual" tag -- not in dictionary */
      if (toignore != NULL)
	{
	  if (rawignorelookup (word))
	    {
	      strcpy (fill, "Y");
	      return 1;
	    }
	  else if (my_isupper (word[0]))
	    {
	      if (rawignorelookup (lowered))
		{
		  strcpy (fill, "Y");
		  return 1;
		}
	    }
	}
      if (replacementlookup (word, repl))
	retval = 0;
      else if (my_isupper (word[0]))
	{
	  if (replacementlookup (lowered, repl))
	    retval = 0;
	}
      if (retval == 0)
	{
	  strcpy (fill, "E");
	  strcpy (extratags, "<Y>");
	  strcpy (attrs, " msg=\"CAIGHDEAN{");
	  strcat (attrs, repl);
	  strcat (attrs, "\"");
	}
    }
  return retval;
}

/* 
  w points into the "token": looks like "<c>word</c>!!'" or the like.
  Can also just be some non-word chars: "+++++" in which case no change
  token includes leading characters too: "`<c>word</c>!!'"
  No guarantee that the token is well-formed (e.g. if len>=512)
  Return 1 if no <c> or </c> and token is filled up (len==511), 0 otherwise
*/
int
markup (char *token, char *wrd)
{
  char mu[8], attrs[128], extratags[512];
  char *tail, *w;
  int val, doubled;

  w = strstr (token, "<c>");
  tail = strstr (token, "</c>");
  if (tail == NULL || w == NULL)
    {				/* e.g. punct, "<line", length>511, etc. */
      printf ("%s", token);
      return (strlen (token) == 511);
    }
  else
    {
      *tail = '\n';		/* \n since it is kept around in focloir */
      *(tail + 1) = '\0';	/* null terminate the word itself */
      val = dictlookup (w + 3, mu, attrs, extratags);
      *tail = '\0';
      *w = '\0';
      doubled = (val && !strcmp (w + 3, wrd));
      if (strlen (tail + 4))
	strcpy (wrd, "");
      else
	strcpy (wrd, w + 3);		  /** ignore dbls if punct intervenes*/
      printf ("%s", token);		  /** chars before <c> **/
      if (doubled)
	printf ("<E msg=\"DUBAILTE\">");
      printf ("<%s", mu);		  /** new markup **/
      printf ("%s", attrs);		  /** attributes **/
      printf (">%s", extratags);	  /** any additional tags **/
      printf ("%s", w + 3);		  /** word itself **/
      if (!val)
	printf ("</Y>");		  /** dummy markup in case of repl. **/
      printf ("</%s>", mu);		  /** end of new markup **/
      if (doubled)
	printf ("</E>");
      markup (tail + 4, wrd);		  /** chars after </c> **/
    }
  return 0;
}

void
cleanup ()
{
  int l;
  if (toignore != NULL)
    free (toignore);
  if (focloir != NULL)
    free (focloir);
  if (torepl != NULL)
    {
      for (l = 0; l < repl_total; l++)
	free (torepl[l].athfhocal);
      free (torepl);
    }
}

void
flush_input (char *buf)
{
  while (scanf ("%511s", buf) != EOF);
}

int
main (int argc, char *argv[])
{
  char token[512], w[512];
  int badtoken = 0;

  setlocale (LC_MESSAGES, "");	/* read from environment */
  setlocale (LC_CTYPE, "");	/* needed so accents appear correctly! */
  bindtextdomain (PACKAGE_NAME, LOCALEDIR);
  textdomain (PACKAGE_NAME);

  if (argc != 4)
    {
      fprintf (stderr, gettext ("problem with the `cuardach' command\n"));
      flush_input (token);
      return 1;
    }

  strcpy (packagename, argv[2]);
  strcpy (teanga, argv[3]);

  if (load_dictionary () || load_replacements ())
    {
      fprintf (stderr, gettext ("%s: problem reading the database\n"),
	       packagename);
      cleanup ();
      flush_input (token);
      return 1;
    }

  if (!strcmp (argv[1], "ignore"))
    load_ignore ();

  printf
    ("<?xml version=\"1.0\" encoding=\"ISO-8859-1\" standalone=\"no\"?>\n");
  printf ("<!DOCTYPE teacs SYSTEM \"/dtds/gramadoir.dtd\">\n");
  printf ("<teacs>");
  while (scanf ("%511s", token) != EOF)
    {
      if (!strcmp (token, "<line"))
	{
	  printf ("\n");
	  strcpy (w, "");
	}
      else if (!badtoken)
	printf (" ");
      badtoken = markup (token, w);
    }
  printf ("\n</teacs>\n");
  cleanup ();
  return 0;
}
