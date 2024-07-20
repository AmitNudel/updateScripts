#!/bin/bash

# Check if any snaps are running
snap list | grep running > /dev/null 2>&1

# Check the exit code of the previous command
if [ $? -eq 0 ]; then
  echo "Error: Snaps are running. Please close them before running the cleanup script."
  exit 1
fi

# No running snaps detected, proceed with the main script
echo "Snaps are not running. Safe to proceed with cleanup."