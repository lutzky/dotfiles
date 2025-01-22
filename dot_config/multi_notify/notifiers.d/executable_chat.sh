#!/bin/bash

[[ -z $MULTI_NOTIFY_CHAT_URL ]] && exit 0

curl -s "$MULTI_NOTIFY_CHAT_URL" \
	--json "{\"text\": \"$1\"}" > /dev/null
