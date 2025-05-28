#!/bin/bash

echo "Installing vim plugins"
vim --headless +'PlugInstall --sync' +qa
