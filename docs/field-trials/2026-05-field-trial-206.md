# Field Trial 206 — Persona: Bearer-native inventory bridge (L4)

## Date

2026-05-22

## Baseline

- nene-mcp ref: `main` @ #37 merged
- FT clone: `../nene-mcp-FT/ft206-persona-bearer-native/`
- Persona: **Integration engineer** — public docs only; building inventory MCP on a **Bearer-native** HTTP API (not NeNe)
- Host: Mock inventory API on `http://127.0.0.1:9090` (client-credentials token, Bearer on `/api/inventory/items`)
- MCP: stdio harness; catalog 4 tools (health, issueAgentToken, listInventoryItems, createInventoryItem)

## Goal

Contrast FT204 (NeNe session cookie failure): complete **list + create** inventory workflow when the API honors Bearer and env token is configured.

## Persona journey

### 1. other-platforms Pattern B

Persona finds bridge repo layout. **Pass** — structure clear.

**Finding (F-1)**: No end-to-end Bearer inventory walkthrough — only NeNe-focused paths elsewhere. **Severity: high** — persona stalls on “where to put token for protected GET”. **Decision: fix-in-package** (#38 — bearer-native-bridge-example).

### 2. Protected read without Bearer env

`listInventoryItems` (`safety: read`), no `NENE_MCP_BEARER_TOKEN`:

HTTP **401**, `isError: true`. nene-mcp did not fail-closed (by design).

**Finding (F-2)**: **medium** — [write-tools-bearer](/howto/write-tools-bearer) says read tools don’t require Bearer; API-enforced Bearer GET is easy to miss. **Decision: document** (#38).

### 3. With Bearer env

`NENE_MCP_BEARER_TOKEN=demo-agent-token`:

| Tool | HTTP | Result |
| --- | --- | --- |
| getHealth | 200 | Pass |
| listInventoryItems | 200 | Pass |
| createInventoryItem | 201 | Pass |
| createInventoryItem (no sku) | 400 | Pass (API validation) |
| wrong Bearer | 401 | Pass |

**Multi-step business flow works** — contrasts FT204 NeNe TODO failure.

### 4. Token issuance as write tool

`issueAgentToken` without env Bearer → fail-closed JSON-RPC error. With placeholder Bearer → HTTP 200 + token body.

**Finding (F-3)**: **low** — same bootstrap pattern as FT204 F-5; covered in new howto. **Decision: document** (#38).

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Health public read | 200 | 200 | Pass |
| List without Bearer | 401 from API | 401 | Pass (persona must read docs) |
| List with Bearer | 200 + items | 200 | Pass |
| Write fail-closed | No HTTP | JSON-RPC error | Pass |
| Create with Bearer | 201 | 201 | Pass |
| vs NeNe TODO (FT204) | Cookie blocked | N/A here | Bearer-native **succeeds** |

## Friction Summary

| ID | Location | Severity | Kind | Decision |
| --- | --- | --- | --- | --- |
| F-1 | Missing Bearer-native howto | high | docs-gap | fix-in-package (#38) |
| F-2 | Protected GET + read safety | medium | docs-gap | fix-in-package (#38) |
| F-3 | Token endpoint write bootstrap | low | docs-gap | fix-in-package (#38) |

## Follow-up Issues

| Priority | Issue | Decision |
| --- | --- | --- |
| high | #38 | fix-in-package — bearer-native howto + smoke checklist |

## Overall Impression

L4 tier achieved: real business read/write on Bearer-native API. Friction is **documentation placement**, not bridge bugs. NeNe vs Bearer-native split should stay explicit in docs.

## Next FT gate

- [ ] #38 closed before FT207 report merge (bundled same PR)
