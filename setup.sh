#!/bin/sh

set_permissions() {
    find . -type f -name "*.sh" | while read -r script; do
        chmod +x "$script" && echo "Set execute permission for $script"
    done
}

if [ "$(id -u)" -ne 0 ]; then
    echo "This script requires elevated permissions. Please run it with sudo."
    exit 1
fi

set_permissions

echo "All .sh scripts in the current directory and subdirectories are now executable."
