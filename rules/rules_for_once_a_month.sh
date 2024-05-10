#!/bin/bash

# name of script
. ../tools/*check.sh

# pre scripts
. ../basic_updates/*pre*.sh

if [ $? -eq 1 ]; then
  exit 1
fi

for script in ../basic_updates/*/*.sh; do
  if [[ -f "$script" ]]; then
    . "$script"
    echo "Sourced: $script"
  fi
done
