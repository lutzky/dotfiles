#!/bin/bash
# Above comment for syntax highlighting

alias ack=ack-grep

# sudo apt install bat
alias bat=batcat

# Stolen shamelessly from powgbg
_ssht() {
  if ! type -t _ssh > /dev/null; then
    . /usr/share/bash-completion/completions/ssh
  fi
  _ssh "$@"
}
function ssht() {
  ssh "$@" -t 'tmux -2 a || tmux -2 || /bin/bash'
}
complete -F _ssht ssht

# From https://perfectmediaserver.com/day-two/quality-of-life-tweaks/
alias docker-ips=$'docker inspect -f \'{{.Name}}-{{range  $k, $v := .NetworkSettings.Networks}}{{$k}}-{{.IPAddress}} {{end}}-{{range $k, $v := .NetworkSettings.Ports}}{{ if not $v }}{{$k}} {{end}}{{end}} -{{range $k, $v := .NetworkSettings.Ports}}{{ if $v }}{{$k}} => {{range . }}{{ .HostIp}}:{{.HostPort}}{{end}}{{end}} {{end}}\' $(docker ps -aq) | column -t -s-'

# And for just one container
alias dockerip="docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"

brightness() {
  ddcutil setvcp 10 "${1?:Usage: brightness [0-100]}"
}

pink() {
  echo -en "\e[95m"
  ping "$@"
  echo -en "\e[0m"
}

# From https://christitus.com/stop-using-apt/
if hash nala > /dev/null 2>&1; then
  apt() {
    command nala "$@"
  }
  sudo() {
    if [[ "$1" == "apt" ]]; then
      shift
      command sudo nala "$@"
    else
      command sudo "$@"
    fi
  }
fi
