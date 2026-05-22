# Milestone batch — FT690–FT719 (regression summary)

> **Not FT completion records.** Each FT has an individual report under `docs/field-trials/2026-05-field-trial-{N}.md`. This file aggregates pass/fail counts only.

## Date

2026-05-23

## Summary

| Metric | Count |
| --- | --- |
| Total | 30 |
| Fail | 0 |
| Pass | 30 |

## L16 probes (FT690+)

Six variants (`N % 6`): NeNe requestId on Bearer read, empty title rejected, public health without Bearer, Bearer+min timeout, sequential list/create, long title write.

Requires NeNe on `:8080` with `NENE_AGENT_BEARER_TOKEN=demo-agent-token`.

Runs **in addition to** L15 + L14 + L13 + L12 + L11 + L10 + L9 + L8 + L7 + L6 adversarial probes.

## Failures

None.

## Related

- [`index-ft690-719.md`](index-ft690-719.md)
