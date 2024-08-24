#!/bin/bash

CONFIG_FILE=~/.config/teletextrc

[[ -f $CONFIG_FILE ]] && exit 0

echo "WARNING: teletext will do nothing because $CONFIG_FILE doesn't exist"
