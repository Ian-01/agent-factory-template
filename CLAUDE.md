# <product name>

## Commands
- Install: npm ci
- Verify (must be green before every commit): npm run verify
- Dev server: npm run dev  (http://localhost:3000)

## Stack
Next.js (App Router), TypeScript strict, Tailwind, Supabase (Postgres + Auth), Vercel, Sentry.

## Architecture rules (non-negotiable; the CI reviewer blocks violations)
- Stateless app: no in-memory sessions, counters or caches.
- Database only through the pooled connection string; an index for every query; no N+1 queries.
- Supabase Auth for users; row-level security on every table; every invariant in docs/SPEC.md has a test.
- Cache headers on static responses; rate limits on every write endpoint; background work in a queue or cron, never inside a request.
- Secrets only from environment variables; never commit a key; never touch production.
- /api/health returns 200 and is never behind auth.

## Loop rules
- Work on ONE story from prd.json per session. Never start a second.
- tests/acceptance/, tests/invariants/, tests/load/ and tests/smoke/ are read-only. If a test seems wrong, write BLOCKED.md and stop.
- Never weaken, skip or delete a test. Fix the source instead.
- Commit only when `npm run verify` is green. Message: feat: US-001 <title>
- The human does not read code. Explain everything in plain English in progress.txt and in BLOCKED.md.
- Anything that needs an account, a payment, a domain, a store submission or a legal page: write BLOCKED.md and stop.

## Taste
Follow docs/DESIGN.md. Reference screenshots are in docs/design/.

## Spec
@docs/SPEC.md
- BLOCKED.md is git-ignored on purpose: never git add -f it, never commit it.
