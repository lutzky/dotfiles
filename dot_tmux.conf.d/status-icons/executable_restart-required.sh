#!/bin/bash
if [ -f /var/run/reboot-required ]; then
	echo -e "[#[fg=red]reboot#[fg=$TMUX_STATUS_FG]]"
fi
