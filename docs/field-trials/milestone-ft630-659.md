# Milestone batch — FT630–FT659 (regression summary)

> **Not FT completion records.** Each FT has an individual report under `docs/field-trials/2026-05-field-trial-{N}.md`. This file aggregates pass/fail counts only.

## Date

2026-05-23

## Summary

| Metric | Count |
| --- | --- |
| Total | 30 |
| Fail | 0 |
| Pass | 30 |

## L14 probes (FT630+)

Six variants (`N % 6`): Bearer listTodos regression, createTodo without CSRF, getTodoById (`id_{id}` path), about bearer flag without secret leak, stderr log stdout purity, invalid Bearer 401.

Requires NeNe on `:8080` with `NENE_AGENT_BEARER_TOKEN=demo-agent-token`.

Runs **in addition to** L13 + L12 + L11 + L10 + L9 + L8 + L7 + L6 adversarial probes.

## Failures

None (variant 2 initially used `id=1`; fixed to `id_1` for NeNe path convention).

## Related

- [`index-ft630-659.md`](index-ft630-659.md)
- [`nene-380-confirmation-gate.md`](nene-380-confirmation-gate.md)
