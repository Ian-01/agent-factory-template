#!/bin/bash
set -u
cd "$(dirname "$0")/.."
mkdir -p logs
MAX_ITER=${1:-12}
RUNS=0
TOPIC="your-secret-topic-name"   # the ntfy topic on your phone
for i in $(seq 1 "$MAX_ITER"); do
  if [ "$(jq '[.userStories[] | select(.passes == false)] | length' prd.json)" = "0" ]; then echo "all stories pass"; break; fi
  if [ -f BLOCKED.md ]; then echo "agent is blocked, see BLOCKED.md"; break; fi
  claude -p "/next-feature" \
    --permission-mode auto --permission-prompts none \
    --max-turns 60 --max-budget-usd 5 \
    --output-format json > "logs/run-$i.json"
  RUNS=$i
  sleep 5
done
DONE=$(jq '[.userStories[] | select(.passes == true)] | length' prd.json)
curl -s -d "night.sh stopped after $RUNS runs. $DONE stories pass." "ntfy.sh/$TOPIC"
