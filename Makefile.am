ACLOCAL_AMFLAGS = -I m4

SUBDIRS = deps src
if ENABLE_TESTING
SUBDIRS += tests/unit
endif

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
    autogen.sh

dist-hook:
	chmod +x $(distdir)/autogen.sh 