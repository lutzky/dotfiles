#!/bin/bash

BAT_EXEC=
if hash bat >& /dev/null; then
  BAT_EXEC=bat
elif hash batcat >& /dev/null; then
  BAT_EXEC=batcat
fi

if [[ -n $BAT_EXEC ]]; then
  echo "Regenrating bat cache"
  $BAT_EXEC cache --build
else
  echo "bat not installed, skipping cache regeneration"
fi
