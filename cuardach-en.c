/*
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
my_tolower_en (const char *w, int *pos, char *lowered)
{
  int ans = (w[*pos] >= 'A' && w[*pos] <= 'Z');
  if (ans)
    lowered[*pos] = (w[*pos] | 0x20);
  else
    lowered[*pos] = w[*pos];
  return ans;
}

int
make_all_lowercase_en (const char *word, char *lowered, int lowers,
		       int uppers, int firstupper)
{
  if (uppers == 0)
    return 0;
  else if (lowers == 0)
    return 1;
  else
    return (uppers == 1 && firstupper == 0);
}


int
byte_to_markup_en (const unsigned char c, char *fill, char *attrs)
{
  strcpy (fill, "U");
  strcpy (attrs, "");
  return (c != 1);
}
