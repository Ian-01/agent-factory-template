---
name: next-feature
description: Build the next unfinished story in prd.json, verify it, open a PR that auto-merges, stop.
disable-model-invocation: true
---
You are one session in an overnight loop and remember nothing from earlier sessions.

1. Run `git status` and `git log --oneline -15`. Read progress.txt.
2. Read prd.json. Pick the story with the lowest priority number whose
   "passes" is false. If there is none, print DONE and stop.
3. Search the codebase before writing anything. Do not re-implement what exists.
4. Implement only that story, following the architecture rules in CLAUDE.md.
   Add unit tests next to the code. Never edit the read-only test folders.
5. Run `npm run verify`. Fix until green. Never weaken, skip or delete a test.
6. Use the Playwright MCP to open the affected screens and save screenshots
   to docs/evidence/<story-id>/ for the reviewer.
7. If the story cannot be finished honestly (a test contradicts the spec, a
   credential or account is missing, the design is unclear), write BLOCKED.md
   in plain English for a non-programmer, commit it, and stop. Do not fake a pass.
8. When green: set that story's "passes" to true in prd.json, append 3-5 plain
   English lines to progress.txt, commit `feat: US-001 <title>`, push, then
   `gh pr create --fill` and `gh pr merge --auto --squash`. The PR merges by
   itself when every check is green; a human never reads the diff.
