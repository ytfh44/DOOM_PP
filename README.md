# DOOM_PP

A modern C++11 game engine using SDL2 and Vulkan.

## Dependencies

- C++11 compiler
- SDL2
- Vulkan SDK
- autoconf
- automake
- libtool
- pkg-config
- wget
- tar

## Building from Source

1. Generate the build system:
```bash
./autogen.sh
```

2. Configure the project:
```bash
./configure
```
   
   Optional configuration flags:
   - `--with-sdl2=PATH`: Use SDL2 from specified path
   - `--with-vulkan-sdk=PATH`: Use Vulkan SDK from specified path

3. Build the project:
```bash
make
```

4. Run the program:
```bash
./doom_pp
```

## Features

- Modern C++11 codebase
- SDL2 for window management and input handling
- Vulkan for high-performance graphics
- Automatic dependency management

## Development

The project structure:
- `src/`: Source files
  - `renderer/`: Vulkan rendering code
  - `game/`: Game logic code
- `deps/`: Dependencies and build scripts
- `m4/`: Autoconf macro files 