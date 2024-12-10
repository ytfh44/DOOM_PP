# ===========================================================================
#      https://www.gnu.org/software/autoconf-archive/ax_prog_wget.html
# ===========================================================================
AC_DEFUN([AC_PROG_WGET], [
    AC_CHECK_PROG(WGET,wget,wget)
    if test -z "$WGET"; then
        AC_MSG_ERROR([wget not found - please install wget])
    fi
]) 