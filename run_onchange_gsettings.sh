#!/bin/bash

# Don't set -e, let things fail loudly but continue if there's an issue.

# https://askubuntu.com/a/1297664
gsettings set org.gnome.evolution-data-server.calendar notify-with-tray true
