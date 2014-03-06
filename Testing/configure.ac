dnl#                                               -*- Autoconf -*-
dnl# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([MacOSXMacros],[0.0.3],[egall@gwmail.gwu.edu])
AC_CONFIG_HEADER([config.h])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([foreign])
AM_MAINTAINER_MODE
AC_SUBST([USE_MAINTAINER_MODE])

# Checks for programs.
EBG_MACOSX_OPTIONS
if test "x${USE_MAINTAINER_MODE}" = "xyes"; then
  EBG_MACOSX_OPTIONS_WITH_EXTERNAL_MACROS
elif test "x${USE_MAINTAINER_MODE}" = "xno"; then
  AC_MSG_WARN([maintainer mode not enabled, will not be able to use extra macros here])
else
  AC_MSG_WARN([USE_MAINTAINER_MODE should be either "yes" or "no"])
fi

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
