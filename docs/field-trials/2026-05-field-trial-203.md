# Field Trial 203 — Persona: Japanese-only frontend (Cursor MCP)

## Date

2026-05-22

## Baseline

- nene-mcp ref: `v0.1.3` (Packagist)
- FT clone: `../nene-mcp-FT/ft203-persona-ja-frontend/` + shared NeNe app `ft201-persona-business/nene-app`
- Persona: **Frontend / Cursor 担当** — **日本語ドキュメントのみ** ([`/ja/`](https://hideyukimori.github.io/nene-mcp/ja/))
- Scenario: 業務アプリ repo に `.cursor/mcp.json` を追加し、チームが MCP ツールを使う

## Goal

`/ja/` だけから NeNe + nene-mcp + Cursor 設定を完了し、health ツールまで MCP 検証。

## Steps & findings

### 1. `/ja/tutorial/getting-started`

Persona runs `composer require hideyukimori/nene-mcp:0.1.3` as shown on **live site** (stale).

**Finding (F-1)**: 日本語 getting-started が FT201 英語修正（`^0.1` + Packagist 注記）と **未同期**。Severity: **medium**. fix-in-package (#34).

### 2. `/ja/howto/integrate-nene`

Live `/ja/` lacks NeNe clone/Docker bootstrap (English gained this in #30).

**Finding (F-2)**: 日本語 integrate-nene **翻訳 lag** — docs-only 日本語ペルソナは NeNe 起動手順に到達できない。Severity: **high**. fix-in-package (#34).

### 3. `/ja/tutorial/cursor-setup`

Abbreviated vs English: missing catalog-free JSON block, verify checklist, team `.cursor/mcp.json` note.

**Finding (F-3)**: **medium** — フロント担当向けの具体性不足。fix-in-package (#34).

### 4. MCP verify (after tribal knowledge path)

Using absolute paths from ja cursor-setup pattern:

- `.cursor/mcp.json` written under `ft203-persona-ja-frontend/`
- `tools/list`: `nene_mcp_about` + catalog tools — **Pass**
- `tools/call` getHealthCheck: HTTP 200 — **Pass**

### 5. Relative path (team mistake)

Simulated cwd `/tmp` with relative `docs/mcp/tools.json` — fails loud. Ja docs now warn (fix #34).

## MCP Verification Results

| Scenario | Status |
| --- | --- |
| Ja docs-only bootstrap (strict) | **Fail** (F-2 until #34) |
| Cursor mcp.json + absolute paths | Pass |
| Health tools/call | Pass |

## Friction Summary

| ID | Severity | Decision |
| --- | --- | --- |
| F-1 | medium | fix-in-package #34 — sync ja getting-started |
| F-2 | high | fix-in-package #34 — sync ja integrate-nene |
| F-3 | medium | fix-in-package #34 — expand ja cursor-setup |

## Follow-up Issues

- nene-mcp **#34** — ja integrator doc parity with en (FT201 fixes)

## Overall Impression

English docs improved in FT201 but **/i18n parity was not enforced** — Japanese-only personas hit the same walls English personas hit before #30. Runtime MCP behavior is sound once paths are correct.

## Next FT gate

- [ ] #34 closed before FT204
