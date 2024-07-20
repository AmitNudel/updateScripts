#!/bin/sh
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Please use sudo."
    exit 1
fi

if command_exists apt; then
    sudo apt update
    sudo apt upgrade
elif command_exists dnf; then
    sudo dnf check-update
    sudo dnf upgrade
elif command_exists yum; then
    sudo yum check-update
    sudo yum update
else
    echo "No supported package manager found."
    exit 1
fi
