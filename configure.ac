dnl Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([doom_pp], [0.1], [bugs@example.com])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])
AC_CONFIG_SRCDIR([src/main.cpp])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIRS([m4])

# Checks for programs
AC_PROG_CXX
AC_PROG_CC
AC_PROG_RANLIB
AC_PROG_WGET
AC_PROG_TAR

# Platform detection
AC_CANONICAL_HOST
case $host_os in
    *mingw* | *cygwin* | *msys*)
        AC_DEFINE([WINDOWS], [1], [Windows platform])
        AM_CONDITIONAL([WINDOWS], [true])
        ;;
    *)
        AM_CONDITIONAL([WINDOWS], [false])
        ;;
esac

# Enable C++11
AX_CXX_COMPILE_STDCXX_11([noext], [mandatory])

# Check for SDL2
PKG_CHECK_MODULES([SDL2], [sdl2])

# Check for Vulkan
AC_CHECK_HEADERS([vulkan/vulkan.h], [], [AC_MSG_ERROR([Vulkan headers not found])])
AC_CHECK_LIB([vulkan], [vkCreateInstance], [], [AC_MSG_ERROR([Vulkan library not found])])

# Enable testing
AC_ARG_ENABLE([testing],
    AS_HELP_STRING([--enable-testing], [Enable unit testing]))
AM_CONDITIONAL([ENABLE_TESTING], [test "x$enable_testing" = "xyes"])

AC_CONFIG_FILES([
    Makefile
    deps/Makefile
    src/Makefile
    tests/unit/Makefile
])
AC_OUTPUT 