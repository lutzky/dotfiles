#!/bin/bash

set -e

cd $(dirname $0)

URL="$(cat fortunes_url)"

curl -sS -L "$URL" | awk '{print;print "%"}' > fortunes
strfile -s fortunes
