if status --is-interactive
  if [ -z "$SSH_CONNECTION" ] && type -q keychain
    SHELL=fish keychain --eval --quiet -Q | source
  end
end
