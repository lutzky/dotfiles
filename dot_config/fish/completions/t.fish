complete -c t -d 'Session name' -xa "(tmux has-session 2> /dev/null && tmux ls -F '#{session_name}')" -n '__fish_is_first_token'
complete -c t -xa ''
