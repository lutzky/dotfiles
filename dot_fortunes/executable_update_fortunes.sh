#!/bin/bash

set -e

cd $(dirname $0)

if [[ ! -e fortunes_url ]]; then
  url_file="$(readlink -f fortunes_url)"

  echo "$url_file missing. To create it:"
  echo "bw get notes fortunes_url > \"$url_file\""

  # For the fortunes_url link in Sheets: Go to "File -> Publish to the web",
  # Change the type to "comma-separate values" (and publish the doc)

  exit 1
else
  URL="$(cat fortunes_url)"
fi

curl -sS -L "$URL" | awk '{print;print "%"}' > fortunes
strfile -s fortunes
