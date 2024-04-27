function alert -d "Show an alert after a command"
    set message "terminal alert"
    if [ $status = 0 ]
        set message "$message: OK"
    else
        set message "$message: ERROR ($status)"
    end
    hterm-notify.sh "$message" "$(status current-commandline | string replace -r ";.*" "")"
    tput bel
end
