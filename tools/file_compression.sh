#!/bin/bash

compress_files() {
  local path="$1"
  local output_file="$2"
  local compression_format="$3"

  if [ ! -e "$path" ]; then
    echo "Error: Path '$path' not found."
    exit 1
  fi

  if [ -z "$compression_format" ]; then
    compression_format="tar.gz"
  elif ! [[ "$compression_format" =~ ^(tar\.gz|tgz|tar\.bz2|tbz2|tar\.xz|txz)$ ]]; then
    echo "Error: Unsupported compression format '$compression_format'. Supported formats are: tar.gz, tgz, tar.bz2, tbz2, tar.xz, txz"
    exit 1
  fi

  if ! [[ "$output_file" == *."$compression_format" ]]; then
    output_file="${output_file}.${compression_format}"
  fi

  echo "Compressing '$path' to '$output_file'..."
  if [ -d "$path" ]; then
    tar -czf "$output_file" -C "$path" .
  elif [ -f "$path" ]; then
    tar -czf "$output_file" -C "$(dirname "$path")" "$(basename "$path")"
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
