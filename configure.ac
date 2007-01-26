dnl Process this file with autoconf to produce a configure script.
AC_INIT([gramadoir],[0.6],[kscanne@gmail.com], [gramadoir-0.6])

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

AC_MSG_CHECKING([for perl module Locale::PO])
if "$PERL" -e 'eval {use Locale::PO};' 2> /dev/null
then
	AC_MSG_RESULT([yes])
else
	AC_MSG_RESULT([no])
	AC_MSG_ERROR([Locale::PO is required])
fi

AC_CONFIG_FILES(Makefile po/Makefile.in )
AC_OUTPUT
