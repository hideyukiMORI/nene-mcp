# Milestone batch — FT480–FT509 (regression summary)

> **Not FT completion records.** Each FT has an individual report under `docs/field-trials/2026-05-field-trial-{N}.md`. This file aggregates pass/fail counts only.

## Date

2026-05-22

## Summary

| Metric | Count |
| --- | --- |
| Total | 30 |
| Fail | 0 |
| Pass | 30 |

## L9 probes (FT480+)

Six variants (`N % 6`): missing inputSchema, oversized Bearer, JSON-RPC params array, DELETE write safety, base URL without scheme, null tools/call arguments.

Runs **in addition to** L8 + L7 + L6 adversarial probes.

## Harness fix

`ft-individual.sh` / `ft-range.sh` now reset `NENE_MCP_API_BASE_URL` and Bearer env each FT so probe side-effects do not leak across runs.

## Failures

None.

## Related

- [`index-ft480-509.md`](index-ft480-509.md)
- [`quality-strategy.md`](quality-strategy.md)
