#!/bin/bash

# Function to create a single dummy file
create_dummy_file() {
  local file_path=$1
  local content=$2

  touch "$file_path"

  if [ ! -z "$content" ]; then
    echo -n "$content" > "$file_path"
  fi
}

# Function to create multiple dummy files
create_multiple_dummy_files() {
  local directory=$1
  local num_files=$2
  local prefix=$3
  local content=$4
  local extension=$5

  mkdir -p "$directory"

  for ((i = 1; i <= num_files; i++)); do
    local file_path="$directory/${prefix}_${i}.${extension}"
    create_dummy_file "$file_path" "$content"
  done
}

# Main script
if [ "$#" -lt 3 ]; then
  echo "Usage: $0 <directory> <num_files> [--prefix=<prefix>] [--content=<content>] [--extension=<extension>]"
  exit 1
fi

DIRECTORY=$1
NUM_FILES=$2
PREFIX="dummy"
CONTENT=""
EXTENSION="txt"

# Parse optional arguments
for arg in "$@"; do
  case $arg in
    --prefix=*)
      PREFIX="${arg#*=}"
      shift
      ;;
    --content=*)
      CONTENT="${arg#*=}"
      shift
      ;;
    --extension=*)
      EXTENSION="${arg#*=}"
      shift
      ;;
  esac
done

create_multiple_dummy_files "$DIRECTORY" "$NUM_FILES" "$PREFIX" "$CONTENT" "$EXTENSION"

echo "Created $NUM_FILES dummy files in $DIRECTORY."
