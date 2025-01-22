#!/bin/bash

SECRETS_FILE=~/.config/multi_notify/secrets

[[ -e $SECRETS_FILE ]] && exit 0

echo "WARNING: multi_notify will not send to external notifiers, configure $SECRETS_FILE"
