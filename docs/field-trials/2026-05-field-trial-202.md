# Field Trial 202 — Persona: security DevOps (docs-only)

## Date

2026-05-22

## Baseline

- nene-mcp ref: `v0.1.3` (Composer source install; Packagist API lag noted)
- FT clone: `../nene-mcp-FT/ft201-persona-business/nene-app/`
- Persona: **Security-minded DevOps** — docs only from [write-tools-bearer](https://hideyukimori.github.io/nene-mcp/howto/write-tools-bearer) and [security-model](https://hideyukimori.github.io/nene-mcp/explanation/security-model)
- Scenario: Business app enabling MCP write tools (session login) for agents

## Goal

Verify fail-closed write, duplicate catalog rejection, secret non-leakage, and misconfigured base URL — without reading source.

## Steps & findings

### 1. Write tool without Bearer

Added `sessionLogin` `safety: write` per docs. `tools/call` without `NENE_MCP_BEARER_TOKEN`:

**Result**: JSON-RPC `-32603` with documented message. **No HTTP sent.** Pass.

### 2. Duplicate tool names

Catalog with two `name: dup` entries:

**Result**: `tools/list` error `duplicated` (v0.1.3). Matches security-model doc. Pass.

### 3. Bearer in about output

`NENE_MCP_BEARER_TOKEN` set; `nene_mcp_about` called:

**Result**: Token not in output. Pass.

### 4. Wrong base URL

`NENE_MCP_API_BASE_URL=http://127.0.0.1:59999` (nothing listening):

**Finding (F-1)**: Returns JSON-RPC **error** (`HTTP request failed for "…"`) — not `result` with `isError: true` as HTTP 4xx/5xx paths return. Docs-only persona expecting uniform structured errors may be surprised. **Severity: low**. **Decision: document** in MCP protocol reference.

### 5. Packagist availability (carry-over)

After `v0.1.3` GitHub release, Packagist JSON API still listed only `v0.1.0`/`v0.1.1` during FT window. Composer installed `v0.1.3` from source/dist after tag.

**Finding (F-2)**: **medium** — integrators pinning dist tags may not see latest. **Decision: process** — verify Packagist webhook (#31).

## MCP Verification Results

| Scenario | Status |
| --- | --- |
| Write fail-closed | Pass |
| Duplicate names | Pass |
| Secret leak about | Pass |
| Dead base URL | Pass (safe error; doc gap F-1) |

## Friction Summary

| ID | Severity | Decision |
| --- | --- | --- |
| F-1 | low | document — connection failure vs HTTP isError |
| F-2 | medium | process — Packagist sync (#31) |

## Follow-up Issues

- nene-mcp #31 — Packagist sync for v0.1.2/v0.1.3
- NeNe: none this FT

## Next FT gate

- [ ] F-1 doc fix merged before FT203
- [ ] #31 tracked (may proceed FT203 if process-only)
