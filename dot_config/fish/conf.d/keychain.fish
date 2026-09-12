if status --is-interactive
    if not set -q SSH_CONNECTION && type -q keychain
        SHELL=fish keychain --eval --quiet -Q | source
    end
end
