if status is-interactive
    fish_add_path $HOME/.bin
    fish_add_path $HOME/.cargo/bin
    fish_add_path $HOME/.local/bin
    fish_add_path /usr/games # That's where fortune is installed 🤷
    fish_add_path $HOME/.opencode/bin
end

# We set our own VIRTUAL_ENV prompt in fish_prompt, as setting the prompt
# isn't supported with direnv and fish.
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1

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
