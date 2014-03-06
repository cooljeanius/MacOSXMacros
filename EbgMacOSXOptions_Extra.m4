dnl# Like EbgMacOSXOptions.m4, except that macros in this file are allowed
dnl# to have dependencies on macros from outside of this package.

dnl# Synopis:
dnl# EBG_PROG_CLANG_WITH_VERSION([version-requested])
AC_DEFUN([EBG_PROG_CLANG_WITH_VERSION],[
  AC_REQUIRE([EBG_PROG_CLANG])
  if test "x${CLANG_VERSION}" != "x"; then
    if test "x$1" = "x"; then
      AC_MSG_WARN([no clang version requested])
    else
      AC_MSG_CHECKING([if clang version is at least requested version $1])
      AX_COMPARE_VERSION([${CLANG_VERSION}],[ge],[$1],[
        AC_MSG_RESULT([yes])
      ],[
        AC_MSG_ERROR([no, it is ${CLANG_VERSION}])
      ])
    fi
  else
    AC_MSG_WARN([CLANG_VERSION was not set properly])
  fi
])

AC_DEFUN([EBG_MACOSX_OPTIONS_WITH_EXTERNAL_MACROS],[
  AC_REQUIRE([AC_PROG_CXX])
  AC_REQUIRE([EBG_MACOSX_OPTIONS])
  AC_REQUIRE([AX_COUNT_CPUS])
  AC_REQUIRE([_AX_CHECK_GL_MANUAL_HEADERS_DARWIN_NOX])
  AC_REQUIRE([_AX_CHECK_GLU_VARARGS_TESSVB])
  AC_REQUIRE([AX_CHECK_ZLIB])
  AC_REQUIRE([AX_CHECK_JAVA_HOME])
  AC_REQUIRE([AX_PERL_EXT])
  AC_REQUIRE([AX_PROG_MD5SUM])
  AC_REQUIRE([AX_PTHREAD])
  AC_REQUIRE([AX_PYTHON_LSPEC])
  AC_REQUIRE([AC_USE_SYSTEM_EXTENSIONS])
  AC_REQUIRE([gl_VISIBILITY])
  AC_REQUIRE([LIBCURL_CHECK_CONFIG])
  AC_REQUIRE([XORG_MEMORY_CHECK_FLAGS])
  EBG_PROG_CLANG_WITH_VERSION([0.1])
  dnl# I want to use some gettext checks, too, but getting that set up is
  dnl# too complicated... same thing with libtool...
])

