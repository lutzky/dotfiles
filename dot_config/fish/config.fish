if status is-interactive
    fish_add_path $HOME/.bin
    fish_add_path $HOME/.cargo/bin
    fish_add_path $HOME/.local/bin
    fish_add_path /usr/games # That's where fortune is installed 🤷
end

set -g show_duration_threshold_ms 3000
set -g alert_duration_threshold_ms 30000
set -g alert_ignore_regex "\
^cargo watch |\
^chezmoi cd|\
^man |\
^mutt |\
^n?vim|\
^nano |\
^ncdu|\
^ssh |\
^t |\
^tmux|\
^top |\
^\$"

# cSpell: ignore ncdu chezmoi
