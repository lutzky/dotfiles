#!/bin/bash
# Above comment for syntax highlighting

alias ack=ack-grep

# Stolen shamelessly from powgbg
_ssht() {
  if ! type -t _ssh > /dev/null; then
    . /usr/share/bash-completion/completions/ssh
  fi
  _ssh "$@"
}
function ssht() {
  ssh "$@" -t 'tmux a || tmux || /bin/bash'
}
complete -F _ssht ssht
