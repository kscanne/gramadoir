dnl Process this file with autoconf to produce a configure script.
AC_INIT([gramadoir],[0.5],[scannell@slu.edu], [gramadoir-0.5])

dnl Checks for programs.
AC_PROG_YACC
AC_PROG_LEX
AC_PROG_CC
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_EGREP
AC_PROG_INSTALL
AC_PATH_PROG(PERL, perl)

dnl Checks for header files.
AC_HEADER_STDC

dnl Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST

AM_GNU_GETTEXT([external])
if test "$USE_NLS" = "yes"
then
	AC_MSG_RESULT([NLS activated])
	SH_GETTEXT="gettext"
else
	AC_MSG_WARN([NLS deactivated])
	SH_GETTEXT="echo"
fi

AC_CONFIG_FILES(Makefile po/Makefile.in )
AC_OUTPUT
