#!/bin/bash
set -e

# Load proxy settings if config exists
if [ -f "./config.env" ]; then
    source ./config.env
fi

# Check for required tools
for tool in autoconf automake libtool pkg-config wget tar; do
    if ! command -v $tool >/dev/null 2>&1; then
        echo "Error: $tool is required but not installed."
        exit 1
    fi
done

# Clean previous autotools files
rm -rf autom4te.cache
rm -f config.log config.status
rm -f Makefile Makefile.in
rm -f src/Makefile src/Makefile.in
rm -f deps/Makefile deps/Makefile.in

# Generate autotools files
autoreconf --install --force

# Optional: Run configure
if [ "$1" != "--no-configure" ]; then
    ./configure "$@"
fi 