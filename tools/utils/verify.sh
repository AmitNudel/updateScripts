verify() {
  local input_file="$1"
  local output_file="$2"
  local password="$3"

  if [ ! -e "$input_file" ]; then
    echo "Error: Input file '$input_file' not found."
    exit 1
  fi

  if [ -z "$output_file" ]; then
    echo "Error: Output file not specified."
    exit 1
  fi

  if [ -z "$password" ]; then
    echo "Error: Password not specified."
    exit 1
  fi
}
