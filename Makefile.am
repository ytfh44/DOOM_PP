ACLOCAL_AMFLAGS = -I m4

SUBDIRS = deps src

bin_PROGRAMS = doom_pp

doom_pp_SOURCES = src/main.cpp

doom_pp_LDADD = \
    src/libdoom.a \
    $(SDL2_LIBS) \
    $(VULKAN_LIBS)

doom_pp_CPPFLAGS = \
    $(SDL2_CFLAGS) \
    $(VULKAN_CFLAGS) \
    -I$(top_srcdir)/src

EXTRA_DIST = \
    README.md \
    autogen.sh \
    m4/ax_prog_wget.m4 \
    m4/ax_prog_tar.m4

dist-hook:
	chmod +x $(distdir)/autogen.sh 