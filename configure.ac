dnl Process this file with autoconf to produce a configure script.
AC_INIT([gramadoir],[1.0pre2],[scannell@slu.edu], [gramadoir-1.0pre2])

dnl Checks for programs.
AC_PROG_AWK
AC_PROG_YACC
AC_PROG_LEX
AC_PROG_CC
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_EGREP
AC_PROG_INSTALL
AC_PATH_PROG(PERL, perl)

dnl Checks for libraries.
dnl Replace `main' with a function in -lfl:

dnl Checks for header files.
AC_HEADER_STDC

dnl Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST

dnl Checks for library functions.
AC_CHECK_FUNCS(strstr strtol)

AC_CONFIG_FILES(Makefile gr)
AC_OUTPUT
