#!/bin/bash

if [[ $1 == -v ]]; then
  verbose=true
fi

apt_packages_to_install=

dpkg_is_installed() {
  dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -q 'install ok installed'
}

found_something() {
  if [[ -z "$verbose" ]]; then
    echo "Some software missing; for more info, run: $0 -v"
    exit
  fi
}

check_apt() {
  dpkg_is_installed $1 && return
  found_something
  apt_packages_to_install="$apt_packages_to_install $1"
}

check_custom() {
  name="$1"
  binary="$2"
  installation="$3"

  hash $binary > /dev/null 2>&1 && return

  found_something

  [[ -n "$verbose" ]] && echo "$name not found: $installation"
}

check_apt bidiv
check_apt exa
check_apt fd-find
check_apt fzf
check_apt ripgrep

if [[ -f ~/.other_software.work.sh ]]; then
  # At work, use apt version of bat
  check_apt bat
else
  check_apt keychain

  # not-at-work, use latest version of bat
  check_custom bat bat "https://github.com/sharkdp/bat/releases"

  check_custom bottom btm "https://github.com/ClementTsang/bottom/releases/latest"
  check_custom delta delta "https://dandavison.github.io/delta/installation.html"
  check_custom lazydocker lazydocker "https://github.com/jesseduffield/lazydocker"
  check_custom starship starship "https://starship.rs/guide"
fi

if [[ -n "$apt_packages_to_install" ]]; then
  echo "Missing apt packages:"
  echo "sudo apt install ${apt_packages_to_install# }"
fi

[[ -f ~/.other_software.work.sh ]] && ~/.other_software.work.sh