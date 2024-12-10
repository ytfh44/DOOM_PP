#!/bin/bash
set -e

DEPS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="$DEPS_DIR/build"
INSTALL_DIR="$DEPS_DIR/install"

mkdir -p "$BUILD_DIR"
mkdir -p "$INSTALL_DIR"

download_sdl2() {
    local version=$1
    echo "Downloading SDL2 version $version..."
    
    cd "$BUILD_DIR"
    wget "https://github.com/libsdl-org/SDL/releases/download/release-$version/SDL2-$version.tar.gz"
    tar xzf "SDL2-$version.tar.gz"
    cd "SDL2-$version"
    
    ./configure --prefix="$INSTALL_DIR" \
                --enable-shared \
                --enable-static
    make -j$(nproc)
    make install
    
    # Export environment variables
    export SDL2_CFLAGS="-I$INSTALL_DIR/include"
    export SDL2_LIBS="-L$INSTALL_DIR/lib -lSDL2"
}

download_vulkan() {
    local version=$1
    echo "Downloading Vulkan SDK version $version..."
    
    cd "$BUILD_DIR"
    if [[ "$OSTYPE" == "msys"* ]] || [[ "$OSTYPE" == "win32" ]]; then
        # Windows version
        wget "https://sdk.lunarg.com/sdk/download/$version/windows/VulkanSDK-$version-Installer.exe"
        ./VulkanSDK-$version-Installer.exe --root "$INSTALL_DIR" --accept-licenses --default-answer --confirm-command
    else
        # Linux version
        wget "https://sdk.lunarg.com/sdk/download/$version/linux/vulkansdk-linux-x86_64-$version.tar.gz"
        tar xzf "vulkansdk-linux-x86_64-$version.tar.gz"
        cp -r "$version"/* "$INSTALL_DIR/"
    fi
    
    # Export environment variables
    export VULKAN_SDK="$INSTALL_DIR"
    export VULKAN_CFLAGS="-I$INSTALL_DIR/include"
    export VULKAN_LIBS="-L$INSTALL_DIR/lib -lvulkan"
}

# Main function
main() {
    local component=$1
    local version=$2
    
    case $component in
        "sdl2")
            download_sdl2 "$version"
            ;;
        "vulkan")
            download_vulkan "$version"
            ;;
        *)
            echo "Unknown component: $component"
            exit 1
            ;;
    esac
}

# Execute main function
main "$@"