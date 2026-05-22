# Milestone batch — FT600–FT629 (regression summary)

> **Not FT completion records.** Each FT has an individual report under `docs/field-trials/2026-05-field-trial-{N}.md`. This file aggregates pass/fail counts only.

## Date

2026-05-23

## Summary

| Metric | Count |
| --- | --- |
| Total | 30 |
| Fail | 0 |
| Pass | 30 |

## L13 probes (FT600+)

Six variants (`N % 6`): stderr HTTP log line (no secret leak), float timeout fallback, negative timeout fallback, catalog env precedence, write fail-closed with custom timeout, HTTPS TLS CA fail-fast.

Runs **in addition to** L12 + L11 + L10 + L9 + L8 + L7 + L6 adversarial probes.

## Failures

None.

## Related

- [`index-ft600-629.md`](index-ft600-629.md)
- [`quality-strategy.md`](quality-strategy.md)
