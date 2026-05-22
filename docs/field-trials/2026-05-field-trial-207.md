# Field Trial 207 — Security: partial catalog, validation, SSRF paths

## Date

2026-05-22

## Baseline

- nene-mcp ref: `main` @ #37 + #38 branch
- FT clone: `../nene-mcp-FT/ft206-persona-bearer-native/` (reuse mock API)
- Scenario: **L4 operator mistakes** + security cadence (`207 % 3 == 0`)
- MCP: stdio harness

## Goal

Adversarial catalog deployment mistakes and MCP security checks; document team process gaps.

## Exercises

### 1. Partial catalog drift

Deployed `tools.json` with **health only** while team docs promise inventory tools.

`tools/list` → only `getHealth` + `nene_mcp_about`. Agents cannot invoke missing tools — silent capability gap, not HTTP error.

**Finding (F-1)**: **medium** — no docs checklist to compare expected tool names vs `tools/list`. **Decision: document** (#38 — catalog-smoke-test §2b).

### 2. Duplicate tool names

Catalog with two `getHealth` entries → `tools/list` JSON-RPC error, safe message. **Pass.**

### 3. Invalid JSON catalog

Malformed file → `tools/list` syntax error. **Pass** (fail loud).

### 4. SSRF path probe

Catalog path `//evil.com/health` with base `http://127.0.0.1:9090` → request stayed on **127.0.0.1:9090** (no external host). **Pass.**

### 5. Write fail-closed + wrong Bearer

From FT206 matrix — no regression. **Pass.**

## Security Review (required when N % 3 == 0)

FT207 — `207 % 3 == 0`.

### SSRF and URL control

- [x] Paths append to configured base; no off-host redirect (`follow_location: 0`)
- [x] `//evil.com/...` did not escape to external host in harness
- **Result**: Pass

### Secret handling

- [x] Bearer not in catalog; wrong Bearer returns API 401 without token leak in JSON-RPC
- **Result**: Pass

### Write tools

- [x] Fail-closed without env Bearer
- **Result**: Pass

### JSON-RPC / protocol

- [x] Duplicate names / invalid JSON → safe errors, process survives
- **Result**: Pass

**Security summary**: **pass** — 1 process doc gap (F-1), no new code Issues.

## Friction Summary

| ID | Location | Severity | Kind | Decision |
| --- | --- | --- | --- | --- |
| F-1 | Partial catalog / tool count | medium | process-gap | document (#38) |

## Follow-up Issues

| Priority | Issue | Decision |
| --- | --- | --- |
| high | #38 | document — smoke checklist |

## Overall Impression

Security behavior holds; main L4 risk is **operational** (wrong catalog shipped). Pair with Bearer-native howto team checklist.

## Next FT gate

- [ ] #38 merged before FT208
