if status is-interactive
    fish_add_path $HOME/.bin
    fish_add_path $HOME/.cargo/bin
    fish_add_path $HOME/.local/bin
    fish_add_path /usr/games # That's where fortune is installed 🤷

    type -q starship && starship init fish | source
end
