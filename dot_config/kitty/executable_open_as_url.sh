#!/bin/bash

if [[ $OSTYPE == "darwin"* ]]; then
	OPEN_CMD="open"
else
	OPEN_CMD="xdg-open"
fi

$OPEN_CMD "http://$1"
