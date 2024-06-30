#!/bin/bash

create_dummy_file() {
  local file_path="$1"
  local content="$2"

  touch "$file_path"

  if [ -n "$content" ]; then
    echo -n "$content" > "$file_path"
  fi
}

create_multiple_dummy_files() {
  local directory="$1"
  local num_files="$2"
  local prefix="$3"
  local content="$4"
  local extension="$5"

  mkdir -p "$directory"

  for ((i = 1; i <= num_files; i++)); do
    local file_path="$directory/${prefix}_${i}.${extension}"
    create_dummy_file "$file_path" "$content"
  done
}

main() {
  if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <directory> <num_files> [--prefix=<prefix>] [--content=<content>] [--extension=<extension>]"
    exit 1
  fi

  local directory="$1"
  local num_files="$2"
  local prefix="dummy"
  local content=""
  local extension="txt"

  shift 2

  for arg in "$@"; do
    case $arg in
      --prefix=*)
        prefix="${arg#*=}"
        ;;
      --content=*)
        content="${arg#*=}"
        ;;
      --extension=*)
        extension="${arg#*=}"
        ;;
    esac
  done

  create_multiple_dummy_files "$directory" "$num_files" "$prefix" "$content" "$extension"
  echo "Created $num_files dummy files in $directory."
}

main "$@"
