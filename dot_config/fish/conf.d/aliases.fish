status is-interactive; or exit 0
if type -q /usr/bin/bat
	alias cat=/usr/bin/bat
	alias less=/usr/bin/bat
else if type -q /usr/bin/batcat
	alias cat=/usr/bin/batcat
	alias less=/usr/bin/batcat
end
type -q btop && alias top=btop
type -q fdfind && alias fd=fdfind
type -q exa && alias ls=exa
type -q eza && alias ls=eza
