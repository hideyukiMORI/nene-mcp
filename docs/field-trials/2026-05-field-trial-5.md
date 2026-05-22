# Field Trial 5 — NeNe multi-tool read catalog

## Date

2026-05-22

## Baseline

- nene-mcp ref: `v0.1.2` (Packagist)
- FT path: `../nene-mcp-FT/ft5-nene-multi-read/`
- Host: NeNe Docker MySQL (`http://localhost:8080`)
- Catalog: 3 tools (`getHealthCheck`, `listTodos`, `getHealthWrongId` probe)

## Goal

Verify multi-tool read catalog end to end; one deliberate wrong `operationId` probe.

## Results

| Tool | HTTP | Notes |
| --- | --- | --- |
| `getHealthCheck` | 200 | Health JSON |
| `listTodos` | 401 | Expected without session |
| `getHealthWrongId` | 200 | Path/method work; operationId mismatch undetected |

**Finding (F-1)**: Catalog schema does not validate `operationId` against OpenAPI—integrator responsibility; document clearly.

**Finding (F-2)**: Duplicate tool `name` values both appear in `tools/list` (see FT6).

## MCP Verification

All pass via `tools/ft-runner.sh multi-read`.

## Follow-up Issues

None (F-1 document trade-off; F-2 → #22).

## Security Review

N/A (FT6 scheduled for catalog security).

## Next FT gate

Close #22 or defer before FT6 merge batch.
