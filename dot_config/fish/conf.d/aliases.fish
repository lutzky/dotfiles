status is-interactive; or exit 0

# When running bat as cat, use -p to hide line numbers, as I often want to
# mouse-copy-and-paste from cat output. When running as 'less' though, use all
# the bells and whistles.
if type -q /usr/bin/bat
	alias cat='/usr/bin/bat -p'
	alias less=/usr/bin/bat
else if type -q /usr/bin/batcat
	alias cat='/usr/bin/batcat -p'
	alias less=/usr/bin/batcat
end

type -q btop && alias top=btop
type -q fdfind && alias fd=fdfind
type -q exa && alias ls=exa
type -q eza && alias ls=eza

alias embiggen='tmux detach -a'  # Detach all other tmuxen
