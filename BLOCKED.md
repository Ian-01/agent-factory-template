# Blocked: the browser tests can't run inside this assistant session

## What I was doing
Syncing the project's setup files (hooks, CI workflows, settings, scripts) to match
the reference copy you pasted in, then running `npm run verify` and `npm run smoke`
to prove everything still works.

## What's actually wrong
It isn't the website. Three of the four checks in `npm run verify` pass cleanly:
- Code formatting and lint (Biome): pass
- TypeScript type-checking: pass
- Unit tests (Jest), with full line coverage: pass

The fourth part — the Playwright browser tests (and `npm run smoke`, which is the
same kind of test) — has to start the real website and open a browser against it.
Starting the website fails every time, with the same error:

```
reading file ".claude/scheduled_tasks.json"
Permission denied (os error 13)
```

`.claude/scheduled_tasks.json` is one of this AI assistant's own internal files,
not part of the website. The assistant's sandbox (a safety restriction on this
chat session, unrelated to your code) hides that file from anything running inside
it. When the website starts up, its styling tool (Tailwind) scans the whole
project folder and stumbles on that hidden file, which crashes the page every
single time — in this sandboxed session only.

I confirmed this directly: I started the website by hand and requested the home
page, and got the identical error and crash, with no test framework involved at
all. So this is not a bug in any file I changed; it's a limitation of the
environment I'm running in right now.

## What needs to happen
Someone needs to run `npm run verify` and `npm run smoke` from a normal terminal
(not through this assistant's sandboxed session) — either on your own machine, or
let the GitHub Actions `ci` workflow run it, which doesn't have this restriction.
That will give a true pass/fail for the browser-based tests.

## What I did not do
I did not commit anything, and I did not touch, weaken, or skip any test to make
this pass.
