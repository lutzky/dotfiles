# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

__if_error() {
	if [[ $? != 0 ]]; then
		echo "$1"
	fi
}

PS1='\[\e[1;32m\]\u@\h\[\e[0;0m\]:\[\e[1;34m\]\w\[\e[0;0m$(__if_error "\e[1;31m")\]\$\[\e[1;35m\]$(__git_ps1)\[\e[0;0m\] '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  elif [ -f /usr/local/git/contrib/completion/git-prompt.sh ]; then
    . /usr/local/git/contrib/completion/git-prompt.sh
  else
    __git_ps1() { :; }
  fi
fi

export PATH=$HOME/.bin:$PATH
export EDITOR=vim

# Environments tend to mess $LESS up more than do something useful with it.
unset LESS

export NOSE_REDNOSE=1

alias watchnose="watch -c nosetests --force-color"

if [[ $TERM == "xterm" ]]; then
	export TERM=xterm-256color
fi

if : \
  && [[ "$TERM" != screen* ]] \
  && [[ -d /proc ]] \
  && grep -qE '(guake|gnome-terminal|ssh|/init)' /proc/$PPID/cmdline \
  ; then
	read -n 1 -p "Run tmux? [Y/n/a] " response
	case $response in
		n)
			echo # Newline
			;;
		a)
			exit
			;;
		*)
			if tmux has-session 2>/dev/null; then
				exec tmux attach
			else
				exec tmux
			fi
			;;
	esac
fi

DEBEMAIL=ohad@lutzky.net
DEBFULLNAME="Ohad Lutzky"

export GOPATH=$HOME/src/go
export PATH=$PATH:${GOPATH}/bin

export CLICOLOR=1  # Color ls output for mac
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export LSCOLORS=ExGxcxdxCxegedabagacad
export LC_ALL=en_US.UTF-8

[ -f /google/devshell/bashrc.google ] && source /google/devshell/bashrc.google

if [[ -z $SSH_CONNECTION ]] && hash keychain > /dev/null 2>&1; then
  eval `keychain --eval --agents ssh id_rsa`
fi
