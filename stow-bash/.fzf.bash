# https://github.com/junegunn/fzf

# Install Ctrl-R (history search), Ctrl-T (file search), Alt-C (cd)
source /usr/share/doc/fzf/examples/key-bindings.bash

# Fuzzy-find when using ** and tab
# (Should be auto-installed, but doesn't seem to work 🤷)
if [[ -e /usr/share/bash-completion/completions/fzf ]]; then
	source /usr/share/bash-completion/completions/fzf
elif [[ -e /usr/share/doc/fzf/examples/completion.bash ]]; then
	source /usr/share/doc/fzf/examples/completion.bash;
else
	echo "WARNING: $BASH_SOURCE:$LINENO: Could not load fzf completions"
fi
