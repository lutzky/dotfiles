function alert -d "Show an alert after a command"
    __alert_impl "alert requested" $status (status current-commandline | string replace -r ";\s*alert" "")
end
