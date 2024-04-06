complete -c t --no-files -a "(tmux has-session 2> /dev/null && tmux ls -F '#{session_name}')"
