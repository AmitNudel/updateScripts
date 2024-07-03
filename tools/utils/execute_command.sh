execute_command() {
  local command="$1"
  shift
  if ! $command "$@"; then
    echo "Error: Failed to execute '$command'"
    exit 1
  fi
}
