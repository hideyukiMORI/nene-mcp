# Milestone batch — FT720–FT749 (regression summary)

> **Not FT completion records.** Each FT has an individual report under `docs/field-trials/2026-05-field-trial-{N}.md`. This file aggregates pass/fail counts only.

## Date

2026-05-23

## Summary

| Metric | Count |
| --- | --- |
| Total | 30 |
| Fail | 0 |
| Pass | 30 |

## L17 probes (FT720+)

Six variants (`N % 6`): FT450 micro-gate listTodos, listTodos without Bearer (401), createTodo fail-closed, Bearer absent from response body, whitespace title rejected, requestId on Bearer write.

Requires NeNe on `:8080` with `NENE_AGENT_BEARER_TOKEN=demo-agent-token`.

Runs **in addition to** L16 + L15 + L14 + L13 + L12 + L11 + L10 + L9 + L8 + L7 + L6 adversarial probes.

## Failures

None.

## Related

- [`index-ft720-749.md`](index-ft720-749.md)
