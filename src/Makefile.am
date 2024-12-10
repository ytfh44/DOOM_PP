noinst_LIBRARIES = libdoom.a

libdoom_a_SOURCES = \
    renderer/vulkan_renderer.cpp \
    renderer/vulkan_renderer.h \
    game/game_logic.cpp \
    game/game_logic.h

libdoom_a_CPPFLAGS = \
    $(SDL2_CFLAGS) \
    $(VULKAN_CFLAGS)

pkginclude_HEADERS = \
    renderer/vulkan_renderer.h \
    game/game_logic.h