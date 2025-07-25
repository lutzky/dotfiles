#!/bin/bash

set -e

max_fortunes_age=$((3600 * 24 * 30))

fortunes_file=~/.fortunes/fortunes

if ! [[ -f $fortunes_file ]]; then
    echo "$fortunes_file missing; run ~/.fortunes/update_fortunes.sh"
    exit 0
fi

echo -n "Updating fortunes... "
~/.fortunes/update_fortunes.sh
echo "OK"
