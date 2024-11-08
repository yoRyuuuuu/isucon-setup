#!/bin/sh

set -e

# TODO: Slack Webhook URLを設定する
SLACK_WEBHOOK_URL="dummy"

sudo cat /var/log/nginx/access.log | alp json \
  --sort sum -r \
  -m '/@\w+,/image/*,/posts/[0-9]+' \
  -o count,uri,min,max,sum,avg \
  >> /tmp/alp

ALP_RESULT=$(cat /tmp/alp)

curl -X POST $SLACK_WEBHOOK_URL \
  -H 'Content-type: application/json' \
  --data '{
    "text": "```'"$ALP_RESULT"'```",
  }'
