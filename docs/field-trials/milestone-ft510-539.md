# Milestone batch — FT510–FT539 (regression summary)

> **Not FT completion records.** Each FT has an individual report under `docs/field-trials/2026-05-field-trial-{N}.md`. This file aggregates pass/fail counts only.

## Date

2026-05-23

## Summary

| Metric | Count |
| --- | --- |
| Total | 30 |
| Fail | 0 |
| Pass | 30 |

## L10 probes (FT510+)

Six variants (`N % 6`): HTTP timeout env, invalid timeout fallback, invalid safety value, stderr log flag, TLS CA on http base, v0.1.8 baseline / Packagist pin.

Runs **in addition to** L9 + L8 + L7 + L6 adversarial probes.

## Context

- Package baseline: **v0.1.8** (SMB adoption tier — timeout, TLS CA, stderr log)
- **FT450** deferred: NeNe [#395](https://github.com/hideyukiMORI/NeNe/issues/395) assigned; re-run when Bearer E2E lands

## Failures

None.

## Related

- [`index-ft510-539.md`](index-ft510-539.md)
- [`quality-strategy.md`](quality-strategy.md)
