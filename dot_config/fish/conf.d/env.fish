# This file exists because fish_variables contains machine-specific stuff

if type -q nvim;
	set -xU EDITOR nvim
else if type -q vim;
	set -xU EDITOR vim
end
