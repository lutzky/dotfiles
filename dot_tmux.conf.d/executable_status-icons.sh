#!/bin/bash

output=

for s in ~/.tmux.conf.d/status-icons/*; do
	output="${output} $(echo -n $($s))"
done

if [[ -n ${output// /} ]]; then
	echo "$output ⚠ "
else
	echo "✓ "
fi
