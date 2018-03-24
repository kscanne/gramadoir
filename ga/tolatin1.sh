#!/bin/bash
# encoding of this file is UTF-8; that's important.
LC_ALL=C grep -v "[^'0-9a-zA-ZáéíóúÁÉÍÓÚâãäçèêëìîñòöü /-]" | iconv -f UTF-8 -t iso-8859-1
