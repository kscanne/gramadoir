dnl Process this file with autoconf to produce a configure script.
AC_INIT([gramadoir],[0.5],[scannell@slu.edu], [gramadoir-0.5])

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

AC_MSG_CHECKING(for regexp highlighter)
echo 'X' > conftestsc
if ${EGREP} --color -h . conftestsc > /dev/null 2>&1
then
	EGREP_COLOR="${EGREP} --color -h"
	AC_MSG_RESULT([using ${EGREP} --color])
else
	if glark -h -N -q . conftestsc > /dev/null 2>&1
	then
		EGREP_COLOR="glark -N -q"
		AC_MSG_RESULT([using glark])
	else
		EGREP_COLOR="${EGREP} -h"
		AC_MSG_RESULT([no])
		AC_MSG_WARN([not found; using vanilla ${EGREP}])
	fi
fi
AC_SUBST(EGREP_COLOR)

AM_GNU_GETTEXT([external])
if test "$USE_NLS" = "yes"
then
	AC_MSG_RESULT([NLS activated])
	SH_GETTEXT="gettext"
else
	AC_MSG_WARN([NLS deactivated])
	SH_GETTEXT="echo"
fi

TEANGACHA=`sed '/^#/d; s/ .*//' TEANGACHA | tr "\n" " "`
ALLIN=""
ALLPL=""
ALLOH=""
ALLMAC=""
for cod in ${TEANGACHA}
do
	ALLIN="${ALLIN} aonchiall-${cod}.in comhshuite-${cod}.in eisceacht-${cod}.in rialacha-${cod}.in unigram-${cod}.txt unigram-${cod}.pre"
	ALLPL="${ALLPL} aonchiall-${cod}.pl comhshuite-${cod}.pl eisceacht-${cod}.pl rialacha-${cod}.pl unigram-${cod}.pl"
	ALLOH="${ALLOH} cuardach-${cod}.o"
	ALLMAC="${ALLMAC} macra-${cod}.meta.sed"
done

AC_SUBST(SH_GETTEXT)
AC_SUBST(TEANGACHA)
AC_SUBST(ALLPL)
AC_SUBST(ALLIN)
AC_SUBST(ALLOH)
AC_SUBST(ALLMAC)

AC_CONFIG_FILES(Makefile gr po/Makefile.in )
AC_OUTPUT
