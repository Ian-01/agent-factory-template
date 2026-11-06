#!/bin/bash
# Stop hook: the agent may not end its turn while verify is red. BLOCKED.md is the honest way out.
# Claude Code itself overrides the block after eight refusals in a row with no work in between.
cat >/dev/null
if [ -n "${GITHUB_ACTIONS:-}" ]; then exit 0; fi   # the CI reviewer has its own verify job
cd "$CLAUDE_PROJECT_DIR" || exit 0
if [ -f BLOCKED.md ]; then exit 0; fi
if npm run verify 1>&2; then exit 0; fi
echo "npm run verify failed. Fix the failures before stopping, or write BLOCKED.md if the story cannot be finished honestly. Do not edit tests to make them pass." >&2
exit 2
