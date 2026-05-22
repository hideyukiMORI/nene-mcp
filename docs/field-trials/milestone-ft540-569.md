# Milestone batch — FT540–FT569 (regression summary)

> **Not FT completion records.** Each FT has an individual report under `docs/field-trials/2026-05-field-trial-{N}.md`. This file aggregates pass/fail counts only.

## Date

2026-05-23

## Summary

| Metric | Count |
| --- | --- |
| Total | 30 |
| Fail | 0 |
| Pass | 30 |

## L11 probes (FT540+)

Six variants (`N % 6`): timeout min (1), max (120), out-of-range clamp, invalid log value, empty TLS CA path, combined operator flags.

Runs **in addition to** L10 + L9 + L8 + L7 + L6 adversarial probes.

## Harness

`ft-individual.sh` / `ft-range.sh` now also reset `NENE_MCP_HTTP_TIMEOUT_SEC`, `NENE_MCP_TLS_CA_FILE`, and `NENE_MCP_LOG` each FT.

## Failures

None.

## Related

- [`index-ft540-569.md`](index-ft540-569.md)
- [`quality-strategy.md`](quality-strategy.md)
