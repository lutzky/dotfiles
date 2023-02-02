#!/bin/bash
# Above comment for syntax highlighting

not_installed=

alias_or_warn() {
  actual_binary=$1
  shift
  alias_base=$1
  shift
  if hash $actual_binary > /dev/null 2>&1; then
    alias $alias_base="$actual_binary $@"
  else
    not_installed="$not_installed $alias_base($actual_binary)"
  fi
}

exists_or_warn() {
  hash $1 > /dev/null 2>&1 || not_installed="$not_installed $2($1)"
}

alias_or_warn batcat bat
alias_or_warn batcat cat
alias_or_warn btm top
alias_or_warn exa ls --icons
alias_or_warn fdfind fd
exists_or_warn delta git-delta
exists_or_warn dust dust
exists_or_warn rg ripgrep
exists_or_warn starship starship
exists_or_warn fzf fzf



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
else
  not_installed="$not_installed nala"
fi

if [[ -n $not_installed ]]; then
  echo "$BASH_SOURCE: The following things you like aren't installed:$not_installed"
fi
