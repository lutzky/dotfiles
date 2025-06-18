#!/bin/bash

if ! which nvim > /dev/null 2>&1; then
	echo "nvim not installed, not installing plugins"
	exit 0
fi

echo "Installing nvim plugins"
nvim --headless +'PlugInstall --sync' +qa
