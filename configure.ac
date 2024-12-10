dnl Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([DOOM_PP], [0.1], [your_email@example.com])
AC_COPYRIGHT([Copyright (C) 2024. Licensed under BSD Zero Clause License.
Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.])

# 确保源码目录存在
AC_CONFIG_SRCDIR([src/main.cpp])

# 设置宏目录
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_AUX_DIR([build-aux])

# 初始化automake
AM_INIT_AUTOMAKE([foreign -Wall -Werror subdir-objects])

# 检查基本编译工具
AC_PROG_CC
AC_PROG_CXX
AC_PROG_INSTALL
AC_PROG_MAKE_SET
AC_PROG_RANLIB
AM_PROG_AR
LT_INIT

# 检查操作系统类型
AC_CANONICAL_HOST
case $host_os in
  *mingw* | *cygwin* | *msys* )
    windows=yes
    AC_DEFINE([WINDOWS], [1], [Building on Windows])
    ;;
  *)
    windows=no
    ;;
esac

# 检查pkg-config
PKG_PROG_PKG_CONFIG

# 检查wget和tar
AC_PATH_PROG([WGET], [wget])
AC_PATH_PROG([TAR], [tar])

# 检查C++11支持
AX_CXX_COMPILE_STDCXX_11([mandatory], [noext])

# 初始化下载标志
need_download_sdl2=no
need_download_vulkan=no

# SDL2检查和自动下载
SDL2_VERSION="2.26.5"
AC_ARG_WITH([sdl2],
    [AS_HELP_STRING([--with-sdl2=PATH], [path to SDL2 installation])],
    [SDL2_PATH="$withval"],
    [SDL2_PATH=""])

AS_IF([test "x$SDL2_PATH" != "x"],
    [SDL2_CFLAGS="-I$SDL2_PATH/include/SDL2"
     if test "x$windows" = "xyes"; then
         SDL2_LIBS="-L$SDL2_PATH/lib -lSDL2main -lSDL2"
     else
         SDL2_LIBS="-L$SDL2_PATH/lib -lSDL2"
     fi],
    [PKG_CHECK_MODULES([SDL2], [sdl2],
        [AC_MSG_NOTICE([SDL2 found])],
        [AC_MSG_NOTICE([SDL2 not found, will download and build from source])
         need_download_sdl2=yes])])

# Vulkan检查和自动下载
VULKAN_VERSION="1.3.261.1"
AC_ARG_WITH([vulkan-sdk],
    [AS_HELP_STRING([--with-vulkan-sdk=DIR], [Vulkan SDK installation directory])],
    [VULKAN_SDK="$withval"],
    [VULKAN_SDK=""])

AS_IF([test "x$VULKAN_SDK" != "x"],
    [VULKAN_CFLAGS="-I$VULKAN_SDK/include"
     if test "x$windows" = "xyes"; then
         VULKAN_LIBS="-L$VULKAN_SDK/lib -lvulkan-1"
     else
         VULKAN_LIBS="-L$VULKAN_SDK/lib -lvulkan"
     fi],
    [PKG_CHECK_MODULES([VULKAN], [vulkan],
        [AC_MSG_NOTICE([Vulkan found])],
        [AC_MSG_NOTICE([Vulkan SDK not found, will download and build from source])
         need_download_vulkan=yes])])

# 配置依赖下载命令
AC_CONFIG_COMMANDS([download-deps],
    [if test "x$need_download_sdl2" = "xyes"; then
        sh $srcdir/deps/download_deps.sh sdl2 $SDL2_VERSION
     fi
     if test "x$need_download_vulkan" = "xyes"; then
        sh $srcdir/deps/download_deps.sh vulkan $VULKAN_VERSION
     fi],
    [need_download_sdl2=$need_download_sdl2
     need_download_vulkan=$need_download_vulkan
     SDL2_VERSION=$SDL2_VERSION
     VULKAN_VERSION=$VULKAN_VERSION])

# Optional: Check for optional dependencies
PKG_CHECK_MODULES([GLSLANG], [glslang], [have_glslang=yes], [have_glslang=no])

# 检查头文件
AC_CHECK_HEADERS([stdlib.h string.h])
if test "x$windows" != "xyes"; then
    AC_CHECK_HEADERS([unistd.h])
fi

# 检查函数
AC_CHECK_FUNCS([memset])

# Windows特定设置
if test "x$windows" = "xyes"; then
    AC_DEFINE([SDL_MAIN_HANDLED], [1], [SDL main handling])
    LIBS="$LIBS -lmingw32"
fi

# 导出变量
AC_SUBST([SDL2_CFLAGS])
AC_SUBST([SDL2_LIBS])
AC_SUBST([VULKAN_CFLAGS])
AC_SUBST([VULKAN_LIBS])

# 配置输出文件
AC_CONFIG_FILES([Makefile
                 src/Makefile
                 deps/Makefile])

# 生成配置头文件
AC_CONFIG_HEADERS([config.h])

# 添加测试支持
AC_ARG_ENABLE([testing],
    [AS_HELP_STRING([--enable-testing], [enable unit testing with Google Test])],
    [enable_testing=$enableval],
    [enable_testing=no])

AM_CONDITIONAL([ENABLE_TESTING], [test "x$enable_testing" = "xyes"])

if test "x$enable_testing" = "xyes"; then
    # 检查Google Test
    AC_LANG_PUSH([C++])
    AC_CHECK_HEADERS([gtest/gtest.h], [],
        [AC_MSG_ERROR([Google Test headers not found. Please install Google Test.])])
    
    save_LIBS=$LIBS
    LIBS="$LIBS -lgtest -lgtest_main -lpthread"
    AC_MSG_CHECKING([for Google Test library])
    AC_LINK_IFELSE(
        [AC_LANG_PROGRAM([#include <gtest/gtest.h>],
            [testing::InitGoogleTest(nullptr, nullptr);])],
        [AC_MSG_RESULT([yes])],
        [AC_MSG_RESULT([no])
         AC_MSG_ERROR([Google Test library not found])])
    LIBS=$save_LIBS
    AC_LANG_POP([C++])
    
    # 导出Google Test变量
    AC_SUBST([GTEST_LIBS], ["-lgtest -lgtest_main -lpthread"])
fi

AC_OUTPUT

# 显示配置摘要
AC_MSG_NOTICE([
Configuration summary:
  Host system: $host
  Windows build: $windows
  SDL2: ${SDL2_PATH:-system}
  Vulkan SDK: ${VULKAN_SDK:-system}
  GLSLANG: $have_glslang

Download summary:
  SDL2: $need_download_sdl2
  Vulkan: $need_download_vulkan
]) 