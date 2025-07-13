#!/bin/bash

set -e

max_fortunes_age=$((3600 * 24 * 30))

fortunes_file=~/.fortunes/fortunes

if ! [[ -f $fortunes_file ]]; then
    echo "$fortunes_file missing; run ~/.fortunes/update_fortunes.sh"
    exit 0
fi

file_mod=$(stat -c %Y $fortunes_file)
age=$(( $(date +%s) - $file_mod))

if [[ $age -gt $max_fortunes_age ]]; then
    echo "~/.fortunes stale; run ~/.fortunes/update_fortunes.sh"
fi
