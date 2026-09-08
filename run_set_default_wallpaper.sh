#!/bin/bash

set -e

wallpaper=~/.wallpaper

if [ ! -e "$wallpaper" ] && [ ! -L "$wallpaper" ]; then
    ln -s .config/wallpapers/haifa.webp "$wallpaper"
fi
