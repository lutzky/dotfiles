#!/bin/bash

# This is run_ rather than run_onchange so that it somewhat-repeatedly nags the
# user to install missing software.

apt_packages_to_install=

dpkg_is_installed() {
  dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -q 'install ok installed'
}

check_apt() {
  dpkg_is_installed $1 && return
  apt_packages_to_install="$apt_packages_to_install $1"
}

can_apt_install() {
  local PACKAGE="$1"
  local REQUIRED_VERSION="$2"
  local CANDIDATE_VERSION="$(apt-cache policy "$PACKAGE" | awk '/Candidate:/ {print $2}')"
  [[ -z $CANDIDATE_VERSION ]] && return 1
  [[ -z $REQUIRED_VERSION ]] && return 0
  dpkg --compare-versions "$CANDIDATE_VERSION" "ge" "$REQUIRED_VERSION"
  return $?
}

is_in_path() {
  hash "$1" > /dev/null 2>&1
  return $?
}

check_custom() {
  name="$1"
  binary="$2"
  installation="$3"

  is_in_path "$binary" && return

  echo "$name needs custom installation: $installation"
}

check_apt bidiv
check_apt btop
check_apt entr

if can_apt_install eza; then
  check_apt eza
else
  check_apt exa
fi
check_apt fd-find
check_apt fish
check_apt fortune-mod
check_apt fzf
check_apt ripgrep
check_apt tmux

check_custom nvim nvim "However is appropriate for the distro"

if [[ -d ~/.local/share/chezmoi.work ]]; then
  # At work, use apt version of bat
  check_apt bat
else
  check_apt keychain

  # not-at-work, use later version of bat
  if ! is_in_path bat && ! is_in_path batcat; then
    if can_apt_install bat "0.25.0"; then
      check_apt bat
    else
      check_custom bat bat "https://github.com/sharkdp/bat/releases"
    fi
  fi

  if ! is_in_path procs; then
    if can_apt_install procs; then
      check_apt procs
    else
      check_custom procs procs "cargo binstall procs"
    fi
  fi

  if ! is_in_path delta; then
    if can_apt_install git-delta; then
      check_apt git-delta
    else
      check_custom delta delta "https://dandavison.github.io/delta/installation.html"
    fi
  fi

  if is_in_path docker; then
    check_custom lazydocker lazydocker "https://github.com/jesseduffield/lazydocker"
  fi
fi

if [[ -n "$apt_packages_to_install" ]]; then
  echo "Missing apt packages:"
  echo "sudo apt install ${apt_packages_to_install# }"
fi
