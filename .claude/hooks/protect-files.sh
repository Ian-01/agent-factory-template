#!/bin/bash
if [ "${ALLOW_TEST_EDITS:-0}" = "1" ]; then exit 0; fi   # only the evening spec session sets this
INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
for p in "tests/acceptance/" "tests/invariants/" "tests/load/" "tests/smoke/" ".env" ".git/" ".github/" ".claude/hooks/" ".claude/settings.json"; do
  case "$FILE" in
    *"$p"*) echo "Blocked: $FILE is protected. Fix the source, not the judge." >&2; exit 2 ;;
  esac
done
exit 0
