dnl Checks for special options needed on MacOS X.
dnl Based on part of Vim's configure.in file.
dnl (By "based on" I mean "shamelessly stolen from")
dnl
dnl License: Whatever Vim's license is
dnl
dnl Usage: EBG_MACOSX_OPTIONS to include everything
dnl Usage: EBG_PROG_* to check for program *
dnl
dnl Other macros useful for OS X that I did NOT include in this file are:
dnl AC_PROG_OBJC (many configure scripts include this anyway so I didn't want to duplicate it)
dnl gt_INTL_MACOSX (This comes from intlmacosx.m4 from recent Mac versions of gettext, which some people might not have, so I left it out just in case)
dnl

AC_DEFUN([EBG_PROG_APPLESINGLE],
[
AC_PATH_PROG(APPLESINGLE, applesingle)
  if test "x$APPLESINGLE" != "x"; then
      AC_MSG_CHECKING(for applesingle version)
      APPLESINGLE_VERSION=`applesingle --version`
      AC_MSG_RESULT([$APPLESINGLE_VERSION])
  fi
])

AC_DEFUN([EBG_PROG_CLANG],
[
AC_PATH_PROG(CLANG, clang)
  if test "x$CLANG" != "x"; then
      AC_MSG_CHECKING(for clang version)
      CLANG_VERSION=`clang --version`
      AC_MSG_RESULT([$CLANG_VERSION])
  fi
])

AC_DEFUN([EBG_PROG_DNSSD],
[
AC_PATH_PROG(DNSSD, dns-sd)
  if test "x$DNSSD" != "x"; then
      AC_MSG_CHECKING(for dns-sd version)
      DNSSD_VERSION=`dns-sd -V`
      AC_MSG_RESULT([$DNSSD_VERSION])
  fi
])

AC_DEFUN([EBG_PROG_HDIUTIL],
[
AC_PATH_PROG(HDIUTIL, hdiutil)
  if test "x$HDIUTIL" != "x"; then
      AC_MSG_CHECKING(hdiutil info)
      HDIUTIL_INFO=`hdiutil info`
      printf "\n"
      AC_MSG_RESULT([$HDIUTIL_INFO])
  fi
])

AC_DEFUN([EBG_PROG_IBTOOL],
[
AC_PATH_PROG(IBTOOL, ibtool)
  if test "x$IBTOOL" != "x"; then
      AC_MSG_CHECKING(for ibtool version)
      dnl FIXME: Output is in plist format, figure out what to do with it
      IBTOOL_VERSION=`ibtool --version`
      printf "\n"
      AC_MSG_RESULT([$IBTOOL_VERSION])
  fi
])

AC_DEFUN([EBG_PROG_MACBINARY],
[
AC_PATH_PROG(MACBINARY, macbinary)
  if test "x$MACBINARY" != "x"; then
      AC_MSG_CHECKING(for macbinary version)
      MACBINARY_VERSION=`macbinary --version`
      AC_MSG_RESULT([$MACBINARY_VERSION])
  fi
])

AC_DEFUN([EBG_PROG_MACHINE],
[
AC_PATH_PROG(MACHINE, machine)
  if test "x$MACHINE" != "x"; then
      AC_MSG_CHECKING(machine type)
      MACHINE_TYPE=`machine`
      AC_MSG_RESULT([$MACHINE_TYPE])
  fi
])

AC_DEFUN([EBG_PROG_NIBTOOL],
[
AC_PATH_PROG(NIBTOOL, nibtool)
  if test "x$NIBTOOL" != "x"; then
      AC_MSG_CHECKING(for nibtool version)
      NIBTOOL_VERSION=`nibtool --version`
      AC_MSG_RESULT([$NIBTOOL_VERSION])
  fi
])

AC_DEFUN([EBG_PROG_NMBLOOKUP],
[
AC_PATH_PROG(NMBLOOKUP, nmblookup)
  if test "x$NMBLOOKUP" != "x"; then
      AC_MSG_CHECKING(for nmblookup version)
      NMBLOOKUP_VERSION=`nmblookup --version`
      AC_MSG_RESULT([$NMBLOOKUP_VERSION])
  fi
])

AC_DEFUN([EBG_PROG_OSALANG],
[
AC_PATH_PROG(OSALANG, osalang)
  if test "x$OSALANG" != "x"; then
      AC_MSG_CHECKING(for available OSA languages)
      OSA_LANGUAGES=`osalang`
      printf "\n"
      AC_MSG_RESULT([$OSA_LANGUAGES])
  fi
])

AC_DEFUN([EBG_PROG_SHARK],
[
AC_PATH_PROG(SHARK, shark)
  if test "x$SHARK" != "x"; then
      AC_MSG_CHECKING(for shark version)
      SHARK_VERSION=`shark -v`
      AC_MSG_RESULT([$SHARK_VERSION])
  fi
])

AC_DEFUN([EBG_PROG_XCODEBUILD],
[
AC_PATH_PROG(XCODEBUILD, xcodebuild)
  if test "x$XCODEBUILD" != "x"; then
      AC_MSG_CHECKING(for Xcode version)
      XCODEBUILD_VERSION=`xcodebuild -version`
      AC_MSG_RESULT([$XCODEBUILD_VERSION])
  fi
  if test "x$XCODEBUILD" != "x"; then
      AC_MSG_CHECKING(for available Xcode sdks)
      dnl FIXME: Format output properly for long sdk names so they don't start including the next field over
      dnl See for example what happens when you have a Darwinbuild-created sdk present
      XCODE_SDKS=`xcodebuild -showsdks | grep sdk | cut -d\  -f1,2,3,4`
      printf "\n The available Xcode sdks are: \n"
      AC_MSG_RESULT([$XCODE_SDKS])
  fi
])

AC_DEFUN([EBG_PROG_XED],
[
AC_PATH_PROG(XED, xed)
  if test "x$XED" != "x"; then
      AC_MSG_CHECKING(for xed version)
      XED_VERSION=`xed --version`
      AC_MSG_RESULT([$XED_VERSION])
  fi
])

AC_DEFUN([EBG_DEVELOPER_DIR],
[
AC_MSG_CHECKING(--with-developer-dir argument)
AC_ARG_WITH(developer-dir, [  --with-developer-dir=PATH    use PATH as location for Xcode developer tools],
  DEVELOPER_DIR="$withval"; AC_MSG_RESULT($DEVELOPER_DIR),
      DEVELOPER_DIR=""; AC_MSG_RESULT(not present))
  
if test "x$DEVELOPER_DIR" = "x"; then
  AC_PATH_PROG(XCODE_SELECT, xcode-select)
  if test "x$XCODE_SELECT" != "x"; then
    AC_MSG_CHECKING(for developer dir using xcode-select)
    DEVELOPER_DIR=`$XCODE_SELECT -print-path`
    AC_MSG_RESULT([$DEVELOPER_DIR])
  else
    DEVELOPER_DIR=/Developer
  fi
fi
])

dnl
dnl Now that we have all the sub-macros out of the way, it's time for the main one
dnl
AC_DEFUN([EBG_MACOSX_OPTIONS],
[
AC_MSG_CHECKING([for Darwin (Mac OS X)])
if test "`(uname) 2>/dev/null`" = Darwin; then
  AC_MSG_RESULT(yes)

  AC_MSG_CHECKING(--disable-darwin argument)
  AC_ARG_ENABLE(darwin,
	  [  --disable-darwin        Disable Darwin (Mac OS X) support.],
	  , [enable_darwin="yes"])
  if test "$enable_darwin" = "yes"; then
    AC_MSG_RESULT(no)
  else
    AC_MSG_RESULT([yes, Darwin support excluded])
  fi

  AC_MSG_CHECKING(--with-mac-arch argument)
  AC_ARG_WITH(mac-arch, [  --with-mac-arch=ARCH    current, intel, ppc or both],
	MACARCH="$withval"; AC_MSG_RESULT($MACARCH),
	MACARCH="current"; AC_MSG_RESULT(defaulting to $MACARCH))
  
  EBG_DEVELOPER_DIR
  
  AC_PATH_PROG(AGVTOOL, agvtool)
  AC_PATH_PROG(APPLEPING, appleping)
  EBG_PROG_APPLESINGLE
  AC_PATH_PROG(AUTOMATOR, automator)
  AC_PATH_PROG(AUVAL, auval)
  AC_PATH_PROG(AUVALTOOL, auvaltool)
  AC_PATH_PROG(BUILD_STRINGS, BuildStrings)
  AC_PATH_PROG(CF_INFO_PLIST_CONVERTER, CFInfoPlistConverter)
  EBG_PROG_CLANG
  AC_PATH_PROG(CMPDYLIB, cmpdylib)
  AC_PATH_PROG(CODESIGN, codesign)
  AC_PATH_PROG(CODESIGN_ALLOCATE, codesign_allocate)
  AC_PATH_PROG(CODESIGN_WRAPPER, codesign_wrapper)
  AC_PATH_PROG(CPMAC, CpMac)
  AC_PATH_PROG(DEFAULTS, defaults)
  AC_PATH_PROG(DEREZ, DeRez)
  AC_PATH_PROG(DEV_TOOLS_SECURITY, DevToolsSecurity)
  AC_PATH_PROG(DISTCC, distcc)
  AC_PATH_PROG(DISTCCD, distccd)
  AC_PATH_PROG(DISTCCMON_TEXT, distccmon-text)
  EBG_PROG_DNSSD
  AC_PATH_PROG(DOCSETUTIL, docsetutil)
  AC_PATH_PROG(DSCACHEUTIL, dscacheutil)
  AC_PATH_PROG(DSCL, dscl)
  AC_PATH_PROG(DSERR, dserr)
  AC_PATH_PROG(DSEXPORT, dsexport)
  AC_PATH_PROG(DSIMPORT, dsimport)
  AC_PATH_PROG(DSMEMBERUTIL, dsmemberutil)
  AC_PATH_PROG(DSPERFMONITOR, dsperfmonitor)
  AC_PATH_PROG(DTRUSS, dtruss)
  AC_PATH_PROG(GATHERHEADERDOC, gatherheaderdoc)
  AC_PATH_PROG(GEN_BRIDGE_METADATA, gen_bridge_metadata)
  AC_PATH_PROG(GET_FILE_INFO, GetFileInfo)
  AC_PATH_PROG(HDXML2MANXML, hdxml2manxml)
  EBG_PROG_HDIUTIL
  AC_PATH_PROG(HIUTIL, hiutil)
  AC_PATH_PROG(HEADERDOC2HTML, headerdoc2html)
  AC_PATH_PROG(HWPREFS, hwprefs)
  EBG_PROG_IBTOOL
  AC_PATH_PROG(IMAGE_UNIT_ANALYZER, ImageUnitAnalyzer)
  AC_PATH_PROG(INSTRUMENTS, instruments)
  AC_PATH_PROG(IPHONEOS_OPTIMIZE, iphoneos-optimize)
  AC_PATH_PROG(LD_CLASSIC, ld_classic)
  AC_PATH_PROG(LD64, ld64)
  AC_PATH_PROG(LEAKS, leaks)
  AC_PATH_PROG(LSDISTCC, lsdistcc)
  AC_PATH_PROG(LSMAC, lsmac)
  EBG_PROG_MACBINARY
  AC_PATH_PROG(MDCHECKSCHEMA, mdcheckschema)
  AC_PATH_PROG(MERGE_PEF, MergePef)
  AC_PATH_PROG(MIG, mig)
  AC_PATH_PROG(MKSDK, mksdk)
  AC_PATH_PROG(MOMC, momc)
  AC_PATH_PROG(MVMAC, MvMac)
  EBG_PROG_NIBTOOL
  AC_PATH_PROG(NIUTIL, niutil)
  EBG_PROG_NMBLOOKUP
  AC_PATH_PROG(OPEN, open)
  AC_PATH_PROG(OSACOMPILE, osacompile)
  AC_PATH_PROG(OSADECOMPILE, osadecompile)
  EBG_PROG_OSALANG
  AC_PATH_PROG(OSASCRIPT, osascript)
  AC_PATH_PROG(PACKAGE_APPLICATION, PackageApplication)
  AC_PATH_PROG(PACKAGEMAKER, packagemaker)
  AC_PATH_PROG(PBCOPY, pbcopy)
  AC_PATH_PROG(PBPASTE, pbpaste)
  AC_PATH_PROG(PBHELPINDEXER, pbhelpindexer)
  AC_PATH_PROG(PBPROJECTDUMP, pbprojectdump)
  AC_PATH_PROG(PBUTIL, pbutil)
  AC_PATH_PROG(PBXCP, pbxcp)
  AC_PATH_PROG(PBXHMAPDUMP, pbxhmapdump)
  AC_PATH_PROG(PKGBUILD, pkgbuild)
  AC_PATH_PROG(PLUTIL, plutil)
  AC_PATH_PROG(PPCEXPLAIN, PPCExplain)
  AC_PATH_PROG(PROJECT_INFO, projectInfo)
  AC_PATH_PROG(PUMP, pump)
  AC_PATH_PROG(PURGE, purge)
  AC_PATH_PROG(PWPOLICY, pwpolicy)
  AC_PATH_PROG(QLMANAGE, qlmanage)
  AC_PATH_PROG(QUARTZ_WM, quartz-wm)
  AC_PATH_PROG(REDO_PREBINDING, redo_prebinding)
  AC_PATH_PROG(RESMERGER, ResMerger)
  AC_PATH_PROG(REZ, Rez)
  AC_PATH_PROG(REZDET, RezDet)
  AC_PATH_PROG(REZWACK, RezWack)
  AC_PATH_PROG(RSA_SECURID_GETPASSWD, RSA_SecurID_getpasswd)
  AC_PATH_PROG(RUN_PLATFORM_UNIT_TESTS, RunPlatformUnitTests)
  AC_PATH_PROG(RUN_TARGET_UNIT_TESTS, RunTargetUnitTests)
  AC_PATH_PROG(RUN_UNIT_TESTS, RunUnitTests)
  AC_PATH_PROG(SAMPLE, sample)
  AC_PATH_PROG(SANDBOX_EXEC, sandbox-exec)
  AC_PATH_PROG(SANDBOX_simplify, sandbox-simplify)
  AC_PATH_PROG(SAY, say)
  AC_PATH_PROG(SDEF, sdef)
  AC_PATH_PROG(SDP, sdp)
  AC_PATH_PROG(SECURITY, Security)
  AC_PATH_PROG(SET_FILE, SetFile)
  EBG_PROG_SHARK
  AC_PATH_PROG(SPLIT_FORKS, SplitForks)
  AC_PATH_PROG(TEXTURETOOL, texturetool)
  AC_PATH_PROG(UNREZWACK, UnRezWack)
  AC_PATH_PROG(UPDATE_DYLD_SHARED_CACHE, update_dyld_shared_cache)
  AC_PATH_PROG(USERS, users)
  AC_PATH_PROG(VERS_STRING, vers_string)
  AC_PATH_PROG(WSMAKE_STUBS, WSMakeStubs)
  AC_PATH_PROG(XATTR, xattr)
  AC_PATH_PROG(XCMAN, xcman)
  AC_PATH_PROG(XCODE_DISTCC_RULE_INSTALLER, Xcode_distcc_rule_installer)
  EBG_PROG_XCODEBUILD
  AC_PATH_PROG(XCODEINDEX, xcodeindex)
  AC_PATH_PROG(XCRUN, xcrun)
  EBG_PROG_XED
  AC_PATH_PROG(XGRID, xgrid)

  if test "x$MACARCH" = "xboth"; then
    AC_MSG_CHECKING(specifically for 10.4 universal SDK)
    dnl There is a terrible inconsistency (but we appear to get away with it):
    dnl $CFLAGS uses the 10.4u SDK library for the headers, while $CPPFLAGS
    dnl doesn't, because "gcc -E" doesn't grok it.  That means the configure
    dnl tests using the preprocessor are actually done with the wrong header
    dnl files. $LDFLAGS is set at the end, because configure uses it together
    dnl with $CFLAGS and we can only have one -sysroot argument.
    save_cppflags="$CPPFLAGS"
    save_cflags="$CFLAGS"
    save_ldflags="$LDFLAGS"
    CFLAGS="$CFLAGS -isysroot $DEVELOPER_DIR/SDKs/MacOSX10.4u.sdk -arch i386 -arch ppc"
    AC_TRY_LINK([ ], [ ],
	AC_MSG_RESULT(found, will make universal binary),

	AC_MSG_RESULT(not found)
	CFLAGS="$save_cflags"
	AC_MSG_CHECKING(if Intel architecture is supported)
	CPPFLAGS="$CPPFLAGS -arch i386"
	LDFLAGS="$save_ldflags -arch i386"
	AC_TRY_LINK([ ], [ ],
	    AC_MSG_RESULT(yes); MACARCH="intel",
	    AC_MSG_RESULT(no, using PowerPC)
		MACARCH="ppc"
		CPPFLAGS="$save_cppflags -arch ppc"
		LDFLAGS="$save_ldflags -arch ppc"))
  elif test "x$MACARCH" = "xintel"; then
    CPPFLAGS="$CPPFLAGS -arch intel"
    LDFLAGS="$LDFLAGS -arch intel"
  elif test "x$MACARCH" = "xppc"; then
    CPPFLAGS="$CPPFLAGS -arch ppc"
    LDFLAGS="$LDFLAGS -arch ppc"
  fi

  if test "$enable_darwin" = "yes"; then
    MACOSX=yes
    dnl TODO: use -arch i386 on Intel machines
    CPPFLAGS="$CPPFLAGS -DMACOS_X_UNIX -no-cpp-precomp"
    AC_CHECK_HEADER(Carbon/Carbon.h, CARBON=yes)
  fi

  dnl Avoid a bug with -O2 with gcc 4.0.1.  Symptom: malloc() reports double
  dnl free.  This happens in expand_filename(), because the optimizer swaps
  dnl two blocks of code, both using "repl", that can't be swapped.
  if test "$MACARCH" = "intel" -o "$MACARCH" = "both"; then
    CFLAGS=`echo "$CFLAGS" | sed 's/-O[[23456789]]/-Oz/'`
  fi

else
  AC_MSG_RESULT(no)
fi
])
