#!/bin/bash
set -e

# Load proxy settings if config exists
if [ -f "../config.env" ]; then
    source ../config.env
fi

DEPS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="$DEPS_DIR/build"
INSTALL_DIR="$DEPS_DIR/install"

mkdir -p "$BUILD_DIR"
mkdir -p "$INSTALL_DIR"

# 下载函数，支持代理
download_file() {
    local url=$1
    local output_file=$2
    echo "Downloading $url to $output_file..."
    wget --no-check-certificate \
         --proxy=on \
         --proxy-user= \
         --proxy-password= \
         -O "$output_file" \
         "$url"
}

download_sdl2() {
    local version=$1
    echo "Downloading SDL2 version $version..."
    
    cd "$BUILD_DIR"
    local sdl2_url="https://github.com/libsdl-org/SDL/releases/download/release-$version/SDL2-$version.tar.gz"
    local sdl2_archive="SDL2-$version.tar.gz"
    
    download_file "$sdl2_url" "$sdl2_archive"
    tar xzf "$sdl2_archive"
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
        local vulkan_url="https://sdk.lunarg.com/sdk/download/$version/windows/VulkanSDK-$version-Installer.exe"
        local vulkan_installer="VulkanSDK-$version-Installer.exe"
        download_file "$vulkan_url" "$vulkan_installer"
        ./"$vulkan_installer" --root "$INSTALL_DIR" --accept-licenses --default-answer --confirm-command
    else
        # Linux version
        local vulkan_url="https://sdk.lunarg.com/sdk/download/$version/linux/vulkansdk-linux-x86_64-$version.tar.gz"
        local vulkan_archive="vulkansdk-linux-x86_64-$version.tar.gz"
        download_file "$vulkan_url" "$vulkan_archive"
        tar xzf "$vulkan_archive"
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