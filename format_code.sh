#!/bin/bash
set -e

# Check if clang-format is installed
if ! command -v clang-format &> /dev/null; then
    echo "Error: clang-format is not installed"
    exit 1
fi

# Format all C++ source files
find src tests \( -name "*.cpp" -o -name "*.h" \) -exec clang-format -i {} +

echo "Code formatting complete!" 