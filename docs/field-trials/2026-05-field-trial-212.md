# Field Trial 212 — L5 operator mistakes (team `.cursor/mcp.json`)

## Date

2026-05-22

## Baseline

- FT clone: `../nene-mcp-FT/ft206-persona-bearer-native/`
- Persona: **Frontend team** ships repo-root `.cursor/mcp.json` copied from docs with **relative** `NENE_MCP_TOOLS_JSON=docs/mcp/tools.json`
- Docs reference: [Cursor setup](/tutorial/cursor-setup), [catalog smoke §2b](/howto/catalog-smoke-test)

## Scenarios

| # | Mistake | Result | Docs cover? |
| --- | --- | --- | --- |
| 1 | Relative catalog path, MCP cwd `/tmp` | JSON-RPC error: catalog not read | **Yes** (warning boxes since FT201) |
| 2 | Relative path, cwd = project root | **Works** — accidental pass if Cursor cwd matches | **Gap (F-1)** |
| 3 | Partial catalog (health only) while README promises inventory | `tools/list` missing tools | **Yes** (§2b since #39) |
| 4 | Bearer-protected list, no env token | HTTP 401 | **Yes** (bearer-native howto) |

## Finding (F-1)

**medium** — Relative `NENE_MCP_TOOLS_JSON` **sometimes works** when MCP host cwd equals project root, reinforcing a bad team habit. Docs say “use absolute” but do not explain **silent success vs silent failure** depending on Cursor launch context. **Decision: document** — optional cursor-setup callout (#46).

## MCP Verification

- Wrong cwd + relative path → **Fail loud** (Pass)
- Project root cwd + relative path → **Pass** (misleading for teams)

## Follow-up

| Issue | Decision |
| --- | --- |
| #46 | document — relative path cwd nuance |

## Next gate

Close #46 before FT213.
