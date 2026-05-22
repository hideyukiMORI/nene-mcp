# Field Trial 208 — Persona: German-only locale parity (`/de/`)

## Date

2026-05-22

## Baseline

- nene-mcp ref: `main` @ #39 merged
- Persona: **German-only integrator** — [`/de/`](https://hideyukimori.github.io/nene-mcp/de/) docs only
- Scenario: Same gate as FT205 (fr/zh) — install, NeNe bootstrap, Bearer/session honesty, health MCP smoke
- MCP: stdio harness + NeNe Docker `:8080` (health)

## Goal

`/de/` persona reaches health MCP integration without English fallback after #37/#39 content landed on en/fr/zh/ja but **de lagged**.

## Findings (before this PR)

| ID | Page | Severity | Issue |
| --- | --- | --- | --- |
| F-1 | getting-started | medium | No `^0.1` pin / Packagist note |
| F-2 | integrate-nene | high | Stale — no bootstrap, session cookie callout, repo-only health sample |
| F-3 | write-tools-bearer | high | Wrong “NeNe session Bearer” bullet |
| F-4 | health-catalog-example | high | Page missing on `/de/` |
| F-5 | catalog-format | medium | Repo-only sample link, wrong operationId |
| F-6 | catalog-smoke-test | low | Missing §2b tool-count / 401 read row |

## After PR (`docs/40-de-locale-ft208`)

All above pages synced with en mainline (German prose, `/de/` links). **Pass** for health-path persona.

MCP `getHealthCheck` → **200**.

## Remaining deferrals

| ID | Item | Severity | Decision |
| --- | --- | --- | --- |
| F-7 | pt-br same lag as pre-fix de | medium | defer — FT209 candidate |
| F-8 | de bearer-native / neene-catalog pages still English body | low | defer — sidebar + integrate links sufficient for FT208 |

## MCP Verification Results

| Scenario | Status |
| --- | --- |
| `/de/` bootstrap path documented | Pass (post-PR) |
| `/de/` session vs Bearer honest | Pass |
| Health tools/call | Pass (200) |

## Follow-up Issues

| Issue | Decision |
| --- | --- |
| #40 | fix-in-package — de locale sync (this PR) |

## Next FT gate

- [ ] #40 merged before FT209 (pt-br parity)
