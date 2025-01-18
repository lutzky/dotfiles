#!/bin/bash

[[ -z $MULTI_NOTIFY_TELEGRAM_API_KEY ]] && exit 0
[[ -z $MULTI_NOTIFY_TELEGRAM_CHAT_ID ]] && exit 0

curl -s \
	--data-urlencode "chat_id=${MULTI_NOTIFY_TELEGRAM_CHAT_ID}" \
	--data-urlencode "text=$1" \
	"https://api.telegram.org/bot${MULTI_NOTIFY_TELEGRAM_API_KEY}/sendMessage" > /dev/null
