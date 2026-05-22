# Milestone batch — FT660–FT689 (regression summary)

> **Not FT completion records.** Each FT has an individual report under `docs/field-trials/2026-05-field-trial-{N}.md`. This file aggregates pass/fail counts only.

## Date

2026-05-23

## Summary

| Metric | Count |
| --- | --- |
| Total | 30 |
| Fail | 0 |
| Pass | 30 |

## L15 probes (FT660+)

Six variants (`N % 6`): unicode Bearer write, create/read round-trip, Bearer+timeout, NENE2 base+Bearer, Bearer+stderr log write, sessionLogin fail-closed.

Requires NeNe on `:8080` with `NENE_AGENT_BEARER_TOKEN=demo-agent-token`.

Runs **in addition to** L14 + L13 + L12 + L11 + L10 + L9 + L8 + L7 + L6 adversarial probes.

## Failures

None.

## Related

- [`index-ft660-689.md`](index-ft660-689.md)
