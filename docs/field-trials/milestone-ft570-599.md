# Milestone batch — FT570–FT599 (regression summary)

> **Not FT completion records.** Each FT has an individual report under `docs/field-trials/2026-05-field-trial-{N}.md`. This file aggregates pass/fail counts only.

## Date

2026-05-23

## Summary

| Metric | Count |
| --- | --- |
| Total | 30 |
| Fail | 0 |
| Pass | 30 |

## L12 probes (FT570+)

Six variants (`N % 6`): NENE2 base URL alias, NENE2 catalog alias, env precedence, leading-zero timeout, HTTPS TLS CA flag, bearer trim with operator flags.

Runs **in addition to** L11 + L10 + L9 + L8 + L7 + L6 adversarial probes.

## Harness

`ft-individual.sh` / `ft-range.sh` now also reset `NENE2_LOCAL_API_BASE_URL` and `NENE2_LOCAL_TOOLS_JSON` each FT.

## Failures

None.

## Related

- [`index-ft570-599.md`](index-ft570-599.md)
- [`quality-strategy.md`](quality-strategy.md)
