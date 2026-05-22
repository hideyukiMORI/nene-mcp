# Field Trial 201 — Persona: docs-only AI, business inventory app

## Date

2026-05-22

## Baseline

- nene-mcp ref: Packagist `v0.1.1` (docs site advertises `v0.1.3`)
- FT clone: `../nene-mcp-FT/ft201-persona-business/nene-app/`
- Persona: **Fresh AI integrator** — may use **only** [hideyukimori.github.io/nene-mcp](https://hideyukimori.github.io/nene-mcp/) (no repo source, no prior FT tribal knowledge)
- Scenario: Business team adding MCP to NeNe-backed inventory/orders API for Cursor agents
- MCP client: stdio harness (simulates Cursor spawn)
- NeNe HTTP: `http://localhost:8080` (pre-existing FT2 Docker — persona would not discover this from nene-mcp docs alone)

## Goal

From public docs alone: install nene-mcp on NeNe, author `tools.json`, expose health + business read tools via MCP without reading nene-mcp or NeNe source.

## Persona journey (docs-only)

### 1. Install pin from Getting started

Docs: `composer require hideyukimori/nene-mcp:0.1.3`

**Finding (F-1)**: **Composer fails** — Packagist has only `v0.1.0`, `v0.1.1`. GitHub has `v0.1.2` tag but Packagist not updated. `0.1.3` unreleased. **Severity: high** — docs-only integrator blocked at step 1.

Workaround: `composer require hideyukimori/nene-mcp:0.1.1` (not documented on site).

### 2. Bootstrap NeNe host

[Integrate with NeNe](https://hideyukimori.github.io/nene-mcp/howto/integrate-nene) lists prerequisites (“NeNe app running locally”) but **no clone, Docker, or composer install steps** on the nene-mcp site. Ecosystem page links NeNe GitHub only.

**Finding (F-2)**: **high** — docs-only persona cannot bootstrap NeNe from nene-mcp docs alone. **Decision: document** — add NeNe quick-start link on integrate-nene (NeNe bootstrap remains NeNe repo).

### 3. Author tools.json from Reference

Persona copies [catalog-format](https://hideyukimori.github.io/nene-mcp/reference/catalog-format) example (`operationId: getHealthIndex`). NeNe OpenAPI uses `healthCheck`.

**Finding (F-3)**: **medium** — misleading `operationId` in docs example; HTTP still works but agent metadata wrong. **Decision: fix-in-package** (docs site).

Health sample points to repo file `docs/example-ne-health-catalog.md` — **not on docs site**.

**Finding (F-4)**: **medium** — persona cannot copy health sample without GitHub. **Decision: fix-in-package** — publish howto page.

### 4. Business tool + MCP verify

Added `listOrders` → `/orders/index` (not implemented). MCP returns HTTP 404 with `isError: true` — acceptable.

Health `tools/call`: **Pass** (200).

### 5. Relative catalog path (persona mistake)

`NENE_MCP_TOOLS_JSON=docs/mcp/tools.json` with MCP cwd `/tmp`:

**Finding (F-5)**: **low** — fails loud (good). Cursor setup already says absolute paths; persona error recoverable. **Decision: document** — optional callout on integrate-nene.

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| `composer require :0.1.3` | Install | Not found | **Fail** |
| `composer require :0.1.1` | Install | OK | Pass (workaround) |
| `tools/list` with absolute catalog | about + tools | OK | Pass |
| `tools/call` getHealthCheck | HTTP 200 | 200 | Pass |
| `tools/call` listOrders (missing API) | HTTP error | 404, isError | Pass |
| Relative TOOLS_JSON wrong cwd | Fail loud | JSON-RPC error | Pass |

## Friction Summary

| ID | Location | Severity | Kind | Decision |
| --- | --- | --- | --- | --- |
| F-1 | docs site version pin | high | docs-gap | fix-in-package (#29) + release tag |
| F-2 | integrate-nene NeNe bootstrap | high | docs-gap | fix-in-package (#29) |
| F-3 | catalog-format operationId | medium | docs-gap | fix-in-package (#29) |
| F-4 | health sample not on site | medium | docs-gap | fix-in-package (#29) |
| F-5 | relative catalog path | low | docs-gap | document (#29) |

## Follow-up Issues

| Priority | Issue | Repo |
| --- | --- | --- |
| high | #29 | nene-mcp — FT201 docs + release alignment |
| medium | NeNe MCP bootstrap discoverability | NeNe (link from nene-mcp docs; optional NeNe doc cross-link) |

## Overall Impression

Docs site is polished but **version pin and NeNe bootstrap gap** stop a docs-only AI cold. Catalog reference example diverges from NeNe OpenAPI. After workaround install (`0.1.1`), MCP wire behaves correctly for business read + missing-endpoint paths.

## Next FT gate

- [ ] #29 closed (nene-mcp fixes merged + tag) before FT202
