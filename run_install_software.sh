#!/bin/bash

# This is run_ rather than run_onchange so that it somewhat-repeatedly nags the
# user to install missing software.

apt_packages_to_install=

dpkg_is_installed() {
  dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -q 'install ok installed'
}

check_apt() {
  for alternate in "$@"; do
    dpkg_is_installed $alternate && return
  done
  apt_packages_to_install="$apt_packages_to_install $(echo $* | sed 's/ /|/g')"
}

check_custom() {
  name="$1"
  binary="$2"
  installation="$3"

  hash $binary > /dev/null 2>&1 && return

  echo "$name not found: $installation"
}

check_apt bidiv
check_apt entr
check_apt exa eza
check_apt fd-find
check_apt fish
check_apt fzf
check_apt ripgrep
check_apt tmux

if [[ -d ~/.local/share/chezmoi.work ]]; then
  # At work, use apt version of bat
  check_apt bat
else
  check_apt keychain

  # not-at-work, use latest version of bat
  check_custom bat bat "https://github.com/sharkdp/bat/releases"

  check_custom bottom btm "https://github.com/ClementTsang/bottom/releases/latest"
  check_custom delta delta "https://dandavison.github.io/delta/installation.html"
  check_custom lazydocker lazydocker "https://github.com/jesseduffield/lazydocker"
fi

if [[ -n "$apt_packages_to_install" ]]; then
  echo "Missing apt packages:"
  echo "sudo apt install ${apt_packages_to_install# }"
fi
