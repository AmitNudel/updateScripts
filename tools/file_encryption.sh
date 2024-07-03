#!/bin/bash

source ./utils/verify.sh

set -o errexit

encrypt_file() {
    local input_file="$1"
    local output_file="$2"
    local password="$3"

    verify "$input_file" "$output_file" "$password"

    echo "Encrypting '$input_file' to '$output_file'..."

    openssl enc -aes-256-cbc -salt -pbkdf2 -iter 100000 -in "$input_file" -out "$output_file" -k "$password"

    echo "Encryption complete."
}

main() {
    if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <input_file> <output_file> <password>"
    exit 1
    fi

    local input_file="$1"
    local output_file="$2"
    local password="$3"

    encrypt_file "$input_file" "$output_file" "$password"
}

main "$@"
