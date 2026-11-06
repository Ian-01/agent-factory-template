# <product>

## Who it is for and what it does
## Scale target
10,000 concurrent users; assume one request per user every 5–10 seconds.
## Features (P1 first)
## Invariants (plain English; each becomes a test in tests/invariants/)
- A signed-out visitor can never read or change user data.
- A user can never see or change another user's data.
- Every write endpoint rejects more than N requests per minute from one user.
## Non-goals
## Done when
- Every story in prd.json passes and has merged.
- The release workflow is green and the full load test (tests/load/full.js) passes twice.
