if status --is-interactive
  SHELL=fish keychain --eval --quiet -Q id_rsa | source
end
