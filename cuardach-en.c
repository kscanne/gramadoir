/*
  cuardach-en.c : decodes English grammatical codes
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
byte_to_markup_en (const unsigned char c, char *fill, char *attrs)
{
  strcpy (fill, "U");
  strcpy (attrs, "");
  return (c != 1);
}
