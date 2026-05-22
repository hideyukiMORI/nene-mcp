# Field Trial 210 — Regression band + security cadence (post FT201–209)

## Date

2026-05-22

## Baseline

- nene-mcp ref: `main` @ #43 merged (FT201–209 persona band complete)
- Harness: `tools/ft-runner.sh`, `tools/packagist-verify.sh`
- Mock Bearer API: `127.0.0.1:9090` (FT206 sandbox, still running)

## Goal

Confirm no regressions after doc-heavy persona FTs; security review for `210 % 3 == 0`.

## Harness results

| Suite | Result |
| --- | --- |
| `packagist-verify.sh` | **Pass** — install `0.1.3`, tools/list smoke |
| `write-failclosed` | **Pass** |
| `security-catalog` (dup names, bad JSON) | **Pass** |
| `about-only` | **Pass** |
| `smoke` sample-catalog.json | **Pass** |
| `smoke` FT206 bearer-native catalog | **Pass** (4 HTTP tools + about) |

## Persona band summary (FT201–209)

| FT | Tier | Topic | Open Issues at end |
| --- | --- | --- | --- |
| 201 | L1 | Business health + fake order | #29–30 (closed) |
| 202 | L2 | Security DevOps docs | #33 (closed) |
| 203 | L2 | ja-only Cursor | #35 (closed) |
| 204 | L3 | NeNe TODO auth wall | #36 (closed) |
| 205 | L2 | fr/zh parity | #34 (closed via #37) |
| 206 | L4 | Bearer-native inventory | #38 (closed) |
| 207 | L4 | Partial catalog / security | #38 (closed) |
| 208 | L2 | de parity | #40 (closed) |
| 209 | L2 | pt-br + ja smoke | #42 (closed) |

**Zero open nene-mcp Issues** at FT210 start — gate satisfied.

## Security Review (210 % 3 == 0)

### SSRF and URL control

- [x] `security-catalog` absolute path in catalog → HTTP to configured base only (404, no redirect)
- [x] FT207 `//evil.com` probe — stayed on configured host
- **Result**: Pass

### Secret handling

- [x] `nene_mcp_about` — no Bearer in output (about-only suite)
- [x] packagist smoke — no secrets in stdout
- **Result**: Pass

### Write tools

- [x] write-failclosed suite
- **Result**: Pass

### JSON-RPC / protocol

- [x] duplicate / invalid catalog — safe errors
- **Result**: Pass

**Security summary**: **pass** — no new Issues.

## Friction Summary

| ID | Location | Severity | Kind | Decision |
| --- | --- | --- | --- | --- |
| F-1 | fr/zh catalog-smoke missing §2b | low | docs-gap | defer — FT211 candidate |
| F-2 | Long-form howto pages (bearer-native, neene-patterns) still English in de/pt-br | low | docs-gap | defer |

## Follow-up Issues

None — deferrals only.

## Overall Impression

Persona band FT201–209 produced **real friction** (auth models, i18n lag, protected GET, partial catalog). Harness green on `main` — docs changes did not break runtime.

## Next FT gate

- [ ] FT211: fr/zh catalog-smoke §2b **or** L5 multi-host matrix
- [ ] Index: [`index-ft201-210.md`](index-ft201-210.md)
