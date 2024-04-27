if status is-interactive
    fish_add_path $HOME/.bin
    fish_add_path $HOME/.cargo/bin
    fish_add_path $HOME/.local/bin

    starship init fish | source
end
