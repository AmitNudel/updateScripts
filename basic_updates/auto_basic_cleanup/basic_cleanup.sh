#!/bin/sh

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Please use sudo."
    exit 1
fi

if command_exists apt-get; then
    sudo apt-get autoclean
    sudo apt-get clean
    sudo apt-get autoremove
elif command_exists dnf; then
    sudo dnf clean all
    sudo dnf autoremove
elif command_exists yum; then
    sudo yum clean all
    sudo yum autoremove
else
    echo "No supported package manager found."
    exit 1
fi

# Swap memory cleanup
sudo swapoff -a
sudo swapon -a

# Clean up journal logs (for systemd-based systems)
if command_exists journalctl; then
    sudo journalctl --vacuum-time=2weeks
fi

# Remove old kernels (for systems that support it)
if command_exists apt-get; then
    sudo apt-get autoremove --purge
elif command_exists dnf; then
    sudo dnf remove --oldinstallonly --setopt installonly_limit=2 kernel
elif command_exists package-cleanup; then
    sudo package-cleanup --oldkernels --count=2
fi

# Remove orphaned packages
if command_exists deborphan; then
    sudo deborphan | xargs sudo apt-get -y remove --purge
elif command_exists dnf; then
    sudo dnf autoremove
elif command_exists package-cleanup; then
    sudo package-cleanup --leaves
fi

# Cache cleanup
sudo rm -rf ~/.cache/thumbnails/*
sudo rm -rf /var/cache/apt/archives/*.deb
sudo rm -rf /var/cache/dnf
sudo rm -rf /var/cache/yum 
