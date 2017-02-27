#!/bin/bash

set -e

usage() {
  cat <<EOF
Usage: $0 [FLAGS]
  -n Dry-run
  -v Verbose
EOF
}

DRY_RUN=
VERBOSE=

while getopts "nv" arg; do
  case $arg in
    n)
      DRY_RUN=1
      ;;
    v)
      VERBOSE=1
      ;;
    h) # Display help.
      usage
      exit 0
      ;;
    *)
      usage
      exit 1
      ;;
  esac
done

IGNORE=(install.sh README.md)
NUM_ERRORS=0

cd "$(dirname $0)"

should_ignore() {
  [[ $(basename $1) =~ ^(README.md|install.sh)$ ]]
}

if [[ $DRY_RUN ]]; then
  link() {
    echo ln -sv $1 $2
  }
else
  link() {
    ln -sv $1 $2
  }
fi

if [[ $VERBOSE ]]; then
  info() {
    echo "$1"
  }
else
  info () { :; }
fi

error() {
  echo "ERROR: $1" >&2
  ((NUM_ERRORS++)) || :
}

sync() {
  local srcdir=$1
  local destdir=$2
  local use_dot=$3

  info "Syncing $destdir -> $srcdir"

  for dotfile in "$srcdir"/*; do
    should_ignore "$dotfile" && continue

    if [[ $use_dot ]]; then
      dest="$destdir/.$(basename "$dotfile")"
    else
      dest="$destdir/$(basename "$dotfile")"
    fi
    if [[ -L $dest ]]; then
      if [[ $(readlink -f "$dest") != $(readlink -f "$dotfile") ]]; then
	error "Conflicting symlink in $dest"
      else
	info "OK: $dest -> $dotfile"
      fi
    elif [[ -f $dest ]]; then
      error "Conflicting file in $dest"
    elif [[ ! -e $dest ]]; then
      link $dotfile $dest
    elif [[ -d $dest ]]; then
      sync "$srcdir/$(basename $dotfile)" $dest
    else
      error "Unexpected file type for $dest"
    fi
  done

  info "Done syncing $destdir -> $srcdir"
}

sync "$PWD" "$HOME" 1

if [[ $NUM_ERRORS -ne 0 ]]; then
  exit 1
fi
