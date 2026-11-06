#!/bin/bash
set -u
cd "$(dirname "$0")/.." || exit 1
mkdir -p logs
pkill -f "next dev|next-server" 2>/dev/null || true   # a leftover dev server holding port 3000 makes every verify time out
MAX_ITER=${1:-12}
RUNS=0
TOPIC=$(grep -s '^NTFY_TOPIC=' .env.local | tail -n 1 | cut -d= -f2-)   # optional phone alert: a line NTFY_TOPIC=<your topic> in .env.local, never in git
for i in $(seq 1 "$MAX_ITER"); do
  if [ "$(jq '[.userStories[] | select(.passes == false)] | length' prd.json)" = "0" ]; then echo "all stories pass"; break; fi
  if [ -f BLOCKED.md ]; then echo "agent is blocked, see BLOCKED.md"; break; fi
  claude -p "/next-feature" --dangerously-skip-permissions --max-turns 60 --max-budget-usd 25 --output-format json > "logs/run-$i.json"
  RUNS=$i
  sleep 5
done
DONE=$(jq '[.userStories[] | select(.passes == true)] | length' prd.json)
MSG="night.sh stopped after $RUNS runs. $DONE stories pass."
echo "$MSG"
if [ -n "$TOPIC" ]; then curl -s -d "$MSG" "ntfy.sh/$TOPIC" >/dev/null; fi
