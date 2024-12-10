if ENABLE_TESTING

check_PROGRAMS = test_runner

test_runner_SOURCES = \
    main_test.cpp

test_runner_CPPFLAGS = \
    -I$(top_srcdir)/src \
    $(SDL2_CFLAGS) \
    $(VULKAN_CFLAGS)

test_runner_LDADD = \
    $(top_builddir)/src/libdoom.a \
    $(SDL2_LIBS) \
    $(VULKAN_LIBS) \
    $(GTEST_LIBS)

TESTS = test_runner

endif 