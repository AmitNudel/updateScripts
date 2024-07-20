#!/bin/sh

LOGFILE="./logs/results.log"

log() {
    local message="$1"
    local timestamp
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "$timestamp - $message" >> "$LOGFILE"
}

mkdir -p "$(dirname "$LOGFILE")"

touch "$LOGFILE"
if [ ! -w "$LOGFILE" ]; then
    echo "Log file $LOGFILE is not writable."
    exit 1
fi
