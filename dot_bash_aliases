#!/bin/bash
# Above comment for syntax highlighting

not_installed=

alias_or_warn() {
  actual_binary=$1
  shift
  alias_base=$1
  shift
  where_to_get=$1
  shift
  if type -P $actual_binary > /dev/null 2>&1; then
    alias $alias_base="$actual_binary $@"
  else
    not_installed="$not_installed"$'\n'"$alias_base ($where_to_get)"
  fi
}

exists_or_warn() {
  executable=$1
  shift
  where_to_get=$1
  shift
  type -P $executable > /dev/null 2>&1 || not_installed="$not_installed"$'\n'"$executable ($where_to_get)"
}

alias_or_warn ~/.local/bin/lazydocker lazydocker https://github.com/jesseduffield/lazydocker
alias_or_warn /usr/bin/bat bat "https://github.com/sharkdp/bat/releases"
alias_or_warn /usr/bin/bat cat "https://github.com/sharkdp/bat/releases"
alias_or_warn /usr/bin/bat less "https://github.com/sharkdp/bat/releases"
alias_or_warn btm top "https://github.com/ClementTsang/bottom/releases/latest"
alias_or_warn exa ls "apt install exa"
alias_or_warn fdfind fd "apt install fdfind"
exists_or_warn delta "https://dandavison.github.io/delta/installation.html"
exists_or_warn rg "apt install ripgrep"
exists_or_warn starship "https://starship.rs/guide"
exists_or_warn fzf "apt install fzf"
exists_or_warn keychain "apt install keychain"



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

# nala is no longer used, because it sometimes locks up when dialogs should be shown.

if [[ -n $not_installed && -z $TMUX ]]; then
  echo "$BASH_SOURCE: The following things you like aren't installed:$not_installed"
fi
