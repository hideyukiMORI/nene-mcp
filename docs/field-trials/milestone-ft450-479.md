# Milestone batch — FT450–FT479 (regression summary)

> **Not FT completion records.** Each FT has an individual report under `docs/field-trials/2026-05-field-trial-{N}.md`. This file aggregates pass/fail counts only.

## Date

2026-05-22

## Summary

| Metric | Count |
| --- | --- |
| Total | 30 |
| Pass | 30 |
| Fail | 0 |

## FT450 gate

NeNe Bearer E2E **confirmed** — FT450 PASS after [NeNe #395](https://github.com/hideyukiMORI/NeNe/issues/395) merge ([report](2026-05-field-trial-450.md)).

## L8 probes (FT451+)

Six variants (`N % 6`): newline/tab Bearer, trailing-space base URL, truncated catalog JSON, duplicate tool names, empty base URL, invalid JSON-RPC version.

Runs **in addition to** L7 + L6 adversarial probes.

## Failures

None.

## Related

- [`index-ft450-479.md`](index-ft450-479.md)
- [`nene-380-confirmation-gate.md`](nene-380-confirmation-gate.md)
- [`quality-strategy.md`](quality-strategy.md)
