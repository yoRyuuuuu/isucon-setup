#!/bin/sh

set -eux

REPO="yoRyuuuuu/private-isu-002"
TITLE="$(date '+%Y-%m-%d %H:%M:%S')の計測結果"
ISSUE_URL=$(gh issue create --repo $REPO --title "$TITLE" --body "")

{
  echo "alp:"
  echo "\`\`\`"
  sudo cat /var/log/nginx/access.log | alp json \
    --sort sum -r \
    -m '/@\w+,/image/*,/posts/[0-9]+' \
    -o count,method,1xx,2xx,3xx,4xx,5xx,uri,min,max,sum,avg
  echo "\`\`\`"
} > /tmp/alp
gh issue comment "$ISSUE_URL" --body-file /tmp/alp

{
  echo "pt-query-digest:"
  echo "\`\`\`"
  sudo pt-query-digest /var/log/mysql/mysql-slow.log | head -n 200
  echo "\`\`\`"
} > /tmp/pt-query-digest
gh issue comment "$ISSUE_URL" --body-file /tmp/pt-query-digest
