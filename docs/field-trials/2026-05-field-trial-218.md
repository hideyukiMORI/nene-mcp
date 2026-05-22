# Field Trial 218 — OpenAPI `servers.url` vs base URL

## Date

2026-05-22

## Scenario

Persona copies OpenAPI `servers: [{ url: http://localhost:8080/mybiz }]` into `NENE_MCP_API_BASE_URL` **and** keeps catalog paths as `/health/index` (correct). Alternative mistake: base `http://localhost:8080` + path `/mybiz/health/index` when NeNe expects prefix on base only.

## Result

FT204 F-4 covered URI_ROOT alignment; catalog-format + neene-catalog-patterns now document base-url prefix rule. **No new friction** — defer code.

## Status

Documented — close without Issue.
