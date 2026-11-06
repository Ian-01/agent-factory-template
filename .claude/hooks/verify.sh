#!/bin/bash
INPUT=$(cat)
if [ "$(echo "$INPUT" | jq -r '.stop_hook_active')" = "true" ]; then exit 0; fi
if [ -f "$CLAUDE_PROJECT_DIR/BLOCKED.md" ]; then exit 0; fi
cd "$CLAUDE_PROJECT_DIR" || exit 0
if npm run verify 1>&2; then exit 0; fi
echo "npm run verify failed. Fix the failures before stopping. Do not edit tests to make them pass." >&2
exit 2
