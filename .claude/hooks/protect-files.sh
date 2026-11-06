#!/bin/bash
# Blocks the agent from changing the judge (tests, workflows, hooks, keys). Exit 2 = block, in every permission mode.
if [ "${ALLOW_TEST_EDITS:-0}" = "1" ]; then exit 0; fi   # only the evening spec session sets this
INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
PROTECTED='tests/acceptance/|tests/invariants/|tests/load/|tests/smoke/|\.git/|\.github/|\.claude/hooks/|\.claude/settings\.json'
is_protected() { local x="${1//.env.example/}"; echo "$x" | grep -Eq "$PROTECTED" || echo "$x" | grep -Eq '\.env'; }
if [ -n "$FILE" ] && is_protected "$FILE"; then
  echo "Blocked: $FILE is protected. Fix the source, not the judge." >&2; exit 2
fi
WRITERS='(^|[^A-Za-z0-9_-])(>|>>|tee|rm|mv|cp|sed -i|perl -i|touch|mkdir|chmod|truncate|git (rm|checkout|restore|clean)|node -e|python3? -c)([^A-Za-z0-9_-]|$)'
if [ -n "$CMD" ] && is_protected "$CMD" && echo "$CMD" | grep -Eq "$WRITERS"; then
  echo "Blocked: that command would change a protected path. Fix the source, not the judge." >&2; exit 2
fi
exit 0
