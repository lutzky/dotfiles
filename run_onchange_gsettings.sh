#!/bin/bash

# Don't set -e, let things fail loudly but continue if there's an issue.

set_or_warn() {
  if gsettings list-keys $1 > /dev/null 2>&1; then
    gsettings set $1 $2 $3
  else
    echo "WARN: Skipping due to missing schema: gsettings set $1 $2 $3"
  fi
}

echo "INFO: Running gsettings commands"

# https://askubuntu.com/a/1297664
set_or_warn org.gnome.evolution-data-server.calendar notify-with-tray true
