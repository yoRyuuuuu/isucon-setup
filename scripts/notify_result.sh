#!/bin/sh

set -eux

# TODO: SlackのWebhook URLを設定する
# export SLACK_WEBHOOK_URL=

# TODO: alpのオプションに、適切なURI matching groupsを設定する
# https://github.com/tkuchiki/alp/blob/main/README.ja.md#uri-matching-groups
# 例: -m '/@\w+,/image/*,/posts/[0-9]+'

# alpの統計結果をSlackに通知する
{
  echo "\`\`\`"
  sudo cat /var/log/nginx/access.log | alp json \
    --sort sum -r \
    -o count,method,1xx,2xx,3xx,4xx,5xx,uri,min,max,sum,avg
  echo "\`\`\`"
} > /tmp/alp
sml < /tmp/alp

# pt-query-digestの統計結果をSlackに通知する
{
  echo "\`\`\`"
  sudo pt-query-digest /var/log/mysql/mysql-slow.log | head -n 300
  echo "\`\`\`"
} > /tmp/pt-query-digest
sml < /tmp/pt-query-digest
