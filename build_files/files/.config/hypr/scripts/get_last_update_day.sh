#!/usr/bin/env bash
last_update=$(rpm-ostree status -b | grep Version | sed 's/^ *//g' | cut -d ' ' -f 3 | tr -d '[()]')
last_update_epoch=$(date -d $last_update +"%s")
today_epoch=$(date +%s)
epoch_diff=$((today_epoch - last_update_epoch))
if (( epoch_diff > 0 )); then
    echo "{\"text\": \"$(( epoch_diff / 86400 ))\"}"
else
    echo "{\"text\": \"Err\"}"
    exit 1
fi
