---
name: next-product
description: Take the next ready brief from backlog/, write its spec and stories, and mark it done when everything has shipped.
disable-model-invocation: true
---
1. Read backlog/. Take the lowest-numbered file whose Status is ready; set it to in-progress.
2. Write docs/SPEC.md from the brief, keeping every heading, including Invariants and Scale target.
3. Run /prd then /ralph to produce prd.json with 6-10 stories the size of "add a filter dropdown".
4. Write tests/acceptance/ and tests/invariants/ from the spec (this is the only session allowed to;
   it runs with ALLOW_TEST_EDITS=1), then ask the reviewer subagent to confirm each test matches the spec.
5. Commit on branch claude/<slug>. Stop; the night loop takes it from here.
6. When every story passes and the release workflow is green, set Status: done and stop.
   Anything needing an account, payment, domain, store submission or legal page: BLOCKED.md.
