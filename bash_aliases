#!/bin/bash
# Above comment for syntax highlighting

alias ack=ack-grep

# Stolen shamelessly from powgbg
function ssht() {
  ssh "$@" -t 'tmux a || tmux || /bin/bash'
}
