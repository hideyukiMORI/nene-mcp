# Field Trial 217 — GET query parameters (business search)

## Date

2026-05-22

## Baseline

- nene-mcp ref: `main` + #51 branch
- Mock API `127.0.0.1:9090` with `GET /api/inventory/items?sku=`
- Catalog: single read tool `searchInventory`, arg `sku`

## Goal

Verify GET **query string** mapping (remaining args after path interpolation) for business list/filter tools; document for personas.

## Steps

### 1. Docs-only persona

[catalog-format](/reference/catalog-format) had path params but **no query section**.

**Finding (F-1)**: **medium** — integrators may not know GET args become query string. **Decision: document** (#51 — catalog-format §Query).

### 2. MCP verify

| Call | HTTP effect | Result |
| --- | --- | --- |
| `{ "sku": "WIDGET-1" }` | `?sku=WIDGET-1` | 1 item **Pass** |
| `{ "sku": "MISSING" }` | filtered empty | **Pass** |

POST body args unchanged (FT206 createTodo).

## Friction Summary

| ID | Severity | Decision |
| --- | --- | --- |
| F-1 | medium | document (#51) |

## Follow-up

Bundled in #51 PR.

## Next gate

FT218 — OpenAPI `servers.url` vs base URL mismatch theme
