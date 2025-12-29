#!/bin/bash

echo "open_as_url $1" >> ~/open_as_url.log

if [[ $OSTYPE == "darwin"* ]]; then
	OPEN_CMD="open"
else
	OPEN_CMD="xdg-open"
fi

echo "opening" >> ~/open_as_url.log

$OPEN_CMD "http://$1" >> ~/open_as_url.log 2>&1
