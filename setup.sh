#!/bin/sh

# Function to set execute permissions for .sh scripts
set_permissions() {
    find . -type f -name "*.sh" | while read -r script; do
        chmod +x "$script" && echo "Set execute permission for $script"
    done
}

# Function to set the path to the logger script
set_logger_path() {
}

# Check if script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script requires elevated permissions. Please run it with sudo."
    exit 1
fi

set_permissions
set_logger_path

echo "All .sh scripts in the current directory and subdirectories are now executable."
