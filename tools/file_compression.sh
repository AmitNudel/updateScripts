#!/bin/bash

source ./utils/execute_command.sh

set -o errexit

readonly DEFAULT_COMPRESSION_FORMAT="tar.gz"
readonly -A COMPRESSION_OPTIONS=(
  ["tar.gz"]="tar czf"
  ["tgz"]="tar czf"
  ["tar.bz2"]="tar cjf"
  ["tbz2"]="tar cjf"
  ["tar.xz"]="tar cJf"
  ["txz"]="tar cJf"
  ["zip"]="zip -r"
  ["gz"]="gzip -c"
  ["bz2"]="bzip2 -c"
  ["xz"]="xz -c"
  ["7z"]="7z a"
)

compress_files() {
  local path="$1"
  local output_file="$2"
  local compression_format="$3"

  if [ ! -e "$path" ]; then
    echo "Error: Path '$path' not found."
    exit 1
  fi

  if [ -z "$compression_format" ]; then
    compression_format="$DEFAULT_COMPRESSION_FORMAT"
  fi

  if [[ ! "${COMPRESSION_OPTIONS[$compression_format]+isset}" ]]; then
    echo "Error: Unsupported compression format '$compression_format'. Supported formats are: ${!COMPRESSION_OPTIONS[@]}"
    exit 1
  fi

  if [[ "$output_file" != *."${compression_format}" ]]; then
    output_file="${output_file}.${compression_format}"
  fi

  echo "Compressing '$path' to '$output_file'..."

  local command="${COMPRESSION_OPTIONS[$compression_format]}"
  if [ "$compression_format" == "zip" ]; then
    execute_command "$command" "$output_file" "$path"
  else
    if [ -d "$path" ]; then
      execute_command "$command" "$output_file" -C "$path" .
    elif [ -f "$path" ]; then
      execute_command "$command" "$output_file" -C "$(dirname "$path")" "$(basename "$path")"
    fi
  fi

  echo "Compression complete."
}

main() {
  if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <path> <output_file> [<compression_format>]"
    exit 1
  fi

  local path_to_compress="$1"
  local output_file="$2"
  local compression_format="$3"

  compress_files "$path_to_compress" "$output_file" "$compression_format"
}

main "$@"