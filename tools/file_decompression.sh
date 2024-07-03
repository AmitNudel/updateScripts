#!/bin/bash

source ./utils/execute_command.sh

set -o errexit

readonly -A DECOMPRESSION_OPTIONS=(
  ["tar.gz"]="tar xzf"
  ["tgz"]="tar xzf"
  ["tar.bz2"]="tar xjf"
  ["tbz2"]="tar xjf"
  ["tar.xz"]="tar xJf"
  ["txz"]="tar xJf"
  ["zip"]="unzip"
  ["gz"]="gunzip -c"
  ["bz2"]="bunzip2 -c"
  ["xz"]="unxz -c"
  ["7z"]="7z x"
)

decompress_files() {
  local archive_file="$1"
  local output_path="$2"
  local file_extension="${archive_file##*.}"

  if [ ! -e "$archive_file" ]; then
    echo "Error: Archive file '$archive_file' not found."
    exit 1
  fi

  if [ -z "$output_path" ]; then
    output_path="."
  fi

  if [[ ! "${DECOMPRESSION_OPTIONS[$file_extension]+isset}" ]]; then
    echo "Error: Unsupported decompression format '$file_extension'. Supported formats are: ${!DECOMPRESSION_OPTIONS[@]}"
    exit 1
  fi

  echo "Decompressing '$archive_file' to '$output_path'..."

  local command="${DECOMPRESSION_OPTIONS[$file_extension]}"
  if [ "$file_extension" == "zip" ]; then
    execute_command "$command" "$archive_file" -d "$output_path"
  else
    execute_command "$command" "$archive_file" -C "$output_path"
  fi

  echo "Decompression complete."
}

main() {
  if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <archive_file> [<output_path>]"
    exit 1
  fi

  local archive_file="$1"
  local output_path="$2"

  decompress_files "$archive_file" "$output_path"
}

main "$@"