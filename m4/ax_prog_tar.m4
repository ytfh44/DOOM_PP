# ===========================================================================
#      https://www.gnu.org/software/autoconf-archive/ax_prog_tar.html
# ===========================================================================
AC_DEFUN([AC_PROG_TAR], [
    AC_CHECK_PROG(TAR,tar,tar)
    if test -z "$TAR"; then
        AC_MSG_ERROR([tar not found - please install tar])
    fi
]) 