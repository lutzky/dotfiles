#!/bin/bash

set -e

cd $(dirname $0)

# For the fortunes_url link in Sheets: Go to "File -> Publish to the web",
# Change the type to "comma-separate values" (and publish the doc)
URL="$(cat fortunes_url)"

curl -sS -L "$URL" | awk '{print;print "%"}' > fortunes
strfile -s fortunes
