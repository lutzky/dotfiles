if not status is-interactive
    exit
end

function long_command_notify --on-event fish_postexec
    set -l prev_duration $CMD_DURATION
    set -l cmd_status $status
    set -l human_duration (__human_duration $CMD_DURATION)
    set -l prev_cmd $argv

    if set -q alert_duration_threshold_ms
        if test $prev_duration -gt $alert_duration_threshold_ms &&
            not string match -qr $alert_ignore_regex $prev_cmd
            __alert_impl "Long-running command ($human_duration)" \
                $cmd_status $prev_cmd
        end
    end
end
