# Milestone batch — FT750–FT779 (regression summary)

> **Not FT completion records.** Each FT has an individual report under `docs/field-trials/2026-05-field-trial-{N}.md`. This file aggregates pass/fail counts only.

## Date

2026-05-23

## Summary

| Metric | Count |
| --- | --- |
| Total | 30 |
| Fail | 0 |
| Pass | 30 |

## L18 probes (FT750+)

Six variants (`N % 6`): getTodoById without Bearer (401), createTodo invalid Bearer (401), getTodoById not found (404), createTodo missing title (400), Bearer health then listTodos chain, NENE2 catalog alias + getTodoById.

Requires NeNe on `:8080` with `NENE_AGENT_BEARER_TOKEN=demo-agent-token`.

Runs **in addition to** L17 + L16 + L15 + L14 + L13 + L12 + L11 + L10 + L9 + L8 + L7 + L6 adversarial probes.

## Failures

None.

## Related

- [`index-ft750-779.md`](index-ft750-779.md)
