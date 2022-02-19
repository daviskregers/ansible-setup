#!/bin/bash
set -xe

LOGFILE="/var/log/clamav/clamav-$(date +'%Y-%m-%d').log";
DIRTOSCAN="{{ clamav_dirs_to_scan }}";
URL="{{ clamav_slack_hook }}";
CHANNEL="{{ clamav_slack_channel }}";
HOST="{{ ansible_hostname }}";
for S in ${DIRTOSCAN}; do
    DIRSIZE=$(du -sh "$S" 2>/dev/null | cut -f1);
    echo "Starting a daily scan of "$S" directory.Amount of data to be scanned is "$DIRSIZE".";
    clamscan -ri --exclude='\.(jpg|jpeg|png|gif|log|xml)$' "$S" >> "$LOGFILE";
    if [ "$MALWARE" -ne "0" ];then
        content="\"attachments\": [ { \"mrkdwn_in\": [\"text\", \"fallback\"], \"fallback\": \"CLAMAV on \`$host\`\", \"text\": \"CLAMAV scan on \`$HOST\` found \`$MALWARE\` malwares\", \"fields\": [{\"title\": \"Dir size\",\"value\": \"$DIRSIZE\", \"short\": true},{ \"title\": \"Scanned dir\", \"value\": \"$DIRTOSCAN\", \"short\": true } ], \"color\": \"#F35A00\" } ]"
         curl -X POST --data-urlencode "payload={\"channel\": \"$CHANNEL\", \"mrkdwn\": true, \"username\": \"ssh-bot\", $content, \"icon_emoji\": \":computer:\"}" $URL
    fi
done
curl -X POST --data-urlencode "payload={\"channel\": \"$CHANNEL\", \"mrkdwn\": true, \"username\": \"ssh-bot\", \"text\": \"CLAMAV scan on \`$HOST\` finished.\", \"icon_emoji\": \":computer:\"}" $URL
exit 0
