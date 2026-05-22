# Field Trial 205 — Persona: fr/zh docs-only locale parity

## Date

2026-05-22

## Baseline

- nene-mcp ref: branch `docs/36-nene-auth-path-uri` (PR for #36 — not yet on live site)
- FT clone: `../nene-mcp-FT/ft204-persona-business-hard/` + shared NeNe `ft201-persona-business/nene-app/`
- Personas: **French-only** ([`/fr/`](https://hideyukimori.github.io/nene-mcp/fr/)) and **Chinese-only** ([`/zh/`](https://hideyukimori.github.io/nene-mcp/zh/)) integrators — docs site only, no repo source
- Scenario: Same as FT203 (ja) but for **fr** and **zh** — install, NeNe bootstrap, health catalog, MCP smoke; plus FT204 auth/path guidance in locale
- MCP client: stdio harness

## Goal

After #36 doc fixes, fr/zh personas can complete health MCP integration **without English fallback** and see honest NeNe session-cookie limitations.

## French persona (`/fr/`)

### 1. `/fr/tutorial/getting-started`

**Before #36:** No `^0.1` pin, no Packagist sync note (same class as FT203 F-1).

**After PR:** Pin + Packagist guidance present. **Pass.**

### 2. `/fr/howto/integrate-nene`

**Before #36:** Stale — no NeNe bootstrap, no session cookie callout, health sample pointed at repo file.

**After PR:** Bootstrap steps, session limitation info box, base URL section, link to [Motifs catalogue NeNe](/fr/howto/neene-catalog-patterns). **Pass.**

### 3. `/fr/howto/neene-catalog-patterns` (new)

Persona learns `id_{id}` paths, `URI_ROOT`, session vs Bearer. **Pass** — addresses FT204 F-1/F-2 in French.

### 4. `/fr/reference/catalog-format`

**Finding (F-1)**: **Before PR** — still had `getHealthIndex` and repo-only sample link (FT201-class drift). **Fixed in #36 PR** → `healthCheck` + link to `/fr/howto/health-catalog-example`. Severity was **medium**; now **resolved**.

### 5. MCP verify

Health `tools/call` → **200**. **Pass.**

## Chinese persona (`/zh/`)

Mirror of French — same stale → fixed trajectory:

| Page | Before | After PR |
| --- | --- | --- |
| getting-started | No version pin | **Pass** |
| integrate-nene | Stale bootstrap | **Pass** |
| neene-catalog-patterns | Missing | **Pass** (new) |
| health-catalog-example | Missing | **Pass** (new) |
| catalog-format | Repo link + wrong operationId | **Pass** |
| cursor-setup | Wrong `/howto/` links (English) | **Pass** — `/zh/` links + team note |

MCP health → **200**. **Pass.**

## Remaining friction

| ID | Location | Severity | Kind | Decision |
| --- | --- | --- | --- | --- |
| F-2 | `/fr/` `/zh/` `catalog-smoke-test` still English-only | low | docs-gap | defer — content accurate, not blocking |
| F-3 | `de` / `pt-br` not synced to #36 NeNe patterns depth | low | docs-gap | defer — FT205 scope was fr/zh |

**Post-#36 friction count: 2 low deferrals** — personas are no longer blocked on bootstrap or auth honesty.

## MCP Verification Results

| Scenario | FR persona | ZH persona | Status |
| --- | --- | --- | --- |
| Docs: install pin | OK | OK | Pass |
| Docs: NeNe bootstrap | OK | OK | Pass |
| Docs: session vs Bearer | OK | OK | Pass |
| Docs: health sample on site | OK | OK | Pass |
| `tools/call` getHealthCheck | 200 | 200 | Pass |

## Follow-up Issues

| Priority | Issue | Decision |
| --- | --- | --- |
| — | #36 (PR) | closes FT204 doc gate + fr/zh parity |

## Overall Impression

FT203 pattern repeated for fr/zh — **i18n lag was real friction**, not zero. Bundling #36 + fr/zh sync in one PR avoids a blocked FT205 on live site. Remaining English pages in fr/zh howto band are papercuts.

## Next FT gate

- [ ] #36 PR merged and Packagist/docs site deployed before FT206
- [ ] FT206 candidate: Bearer-native non-NeNe host **or** L4 partial-catalog / operator mistake scenarios
