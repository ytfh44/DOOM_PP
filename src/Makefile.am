noinst_LIBRARIES = libdoom.a

libdoom_a_SOURCES = \
    renderer/vulkan_renderer.cpp \
    renderer/vulkan_renderer.h \
    game/game_logic.cpp \
    game/game_logic.h

libdoom_a_CPPFLAGS = \
    $(SDL2_CFLAGS) \
    $(VULKAN_CFLAGS) \
    -I$(top_srcdir)/src \
    -std=c++11 \
    -D_USE_MATH_DEFINES

if WINDOWS
libdoom_a_CPPFLAGS += -DVK_USE_PLATFORM_WIN32_KHR
else
libdoom_a_CPPFLAGS += -DVK_USE_PLATFORM_XCB_KHR
endif

pkginclude_HEADERS = \
    renderer/vulkan_renderer.h \
    game/game_logic.h