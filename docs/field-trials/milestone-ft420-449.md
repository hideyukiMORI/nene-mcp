# Milestone batch — FT420–FT449 (regression summary)

> **Not FT completion records.** Each FT has an individual report under `docs/field-trials/2026-05-field-trial-{N}.md`. This file aggregates pass/fail counts only.

## Date

2026-05-22

## Summary

| Metric | Count |
| --- | --- |
| Total | 30 |
| Pass | 30 |
| Fail | 0 |

## L7 probes (FT420+)

Six variants (`N % 6`): wrong Bearer env typo, double JSON-RPC stdin, base URL credential embed, oversized GET query, unicode path param, empty-string Bearer.

Runs **in addition to** L6 adversarial probes (FT255+).

## Failures

None.

## Related

- [`index-ft420-449.md`](index-ft420-449.md)
- [`nene-380-confirmation-gate.md`](nene-380-confirmation-gate.md)
- [`quality-strategy.md`](quality-strategy.md)
