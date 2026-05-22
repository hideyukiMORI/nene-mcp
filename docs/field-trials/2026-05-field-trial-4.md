# Field Trial 4 — Catalog-free minimal install

## Date

2026-05-22

## Baseline

- nene-mcp ref: `v0.1.2` (Packagist)
- FT clone path: `../nene-mcp-FT/ft4-about-only/`
- Host app: none (standalone MCP bridge directory — no NeNe, no HTTP API required for this FT)
- PHP: 8.4.21
- MCP client: `.cursor/mcp.json` without `NENE_MCP_TOOLS_JSON`; stdio smoke
- Env: `NENE_MCP_API_BASE_URL=http://localhost:8080` only (optional; defaults apply when omitted)

## Goal

Verify the smallest integrator story: Packagist install, no `tools.json`, MCP starts with only `nene_mcp_about`.

## Integration Built

- Directory: `composer require hideyukimori/nene-mcp:^0.1.2` only (no VCS stanza)
- Catalog: **none** — `NENE_MCP_TOOLS_JSON` omitted from MCP config
- Cursor config: `.cursor/mcp.json` with `command` + `args` + base URL env only

## Steps Taken

### 1. Fresh Packagist-only bridge

```bash
mkdir ../nene-mcp-FT/ft4-about-only && cd $_
composer init --name=ft4/about-only-bridge --no-interaction
composer require hideyukimori/nene-mcp:^0.1.2
```

No friction — G1 Packagist path works without repository stanza.

### 2. MCP with zero env vars

```bash
env -i PATH=... php vendor/bin/nene-mcp  # piped JSON-RPC
```

- `initialize` → nene-mcp `0.1.2`
- `tools/list` → **only** `nene_mcp_about`
- `tools/call nene_mcp_about` → `catalogPath: null`, default `apiBaseUrl: http://localhost:8080`
- `tools/call getHealthCheck` → `-32603` tool not found

No crash; stderr empty. Catalog-free path is viable for smoke-testing MCP wiring before OpenAPI tools exist.

### 3. Minimal Cursor config

Created `.cursor/mcp.json` without `NENE_MCP_TOOLS_JSON`. Matches README intent but README example still shows catalog path only.

**Finding (F-1)**: Docs emphasize catalog + base URL; catalog-free `.cursor/mcp.json` example is not prominent in README / integration guides.

### 4. Misconfiguration probes

| Scenario | Result |
| --- | --- |
| `NENE_MCP_TOOLS_JSON=""` (empty) | Treated as unset — `tools/list` shows about only |
| `NENE_MCP_TOOLS_JSON=/nonexistent/tools.json` | `tools/list` fails: catalog could not be read |
| Unset `TOOLS_JSON` + base URL set | about works; `catalogPath: null` |

**Finding (F-2)**: A wrong catalog path disables the entire MCP surface (including `nene_mcp_about`) on `tools/list`. Fail-loud is defensible for security/clarity, but integrators wiring Cursor before creating `tools.json` may stall if they set a placeholder path. **Decision:** document — omit env var until the file exists.

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Packagist install | No VCS stanza | v0.1.2 installed | Pass |
| MCP server starts (no env) | stdio healthy | Pass | Pass |
| `tools/list` | about only | Single tool | Pass |
| `tools/call nene_mcp_about` | metadata, no secrets | Pass | Pass |
| Call missing catalog tool | Safe error | `-32603` | Pass |
| Invalid catalog path | — | Hard fail on list | Pass (fail-loud) |

## Friction Summary

| ID | Location | Severity | Kind | Decision |
| --- | --- | --- | --- | --- |
| F-1 | README / integration Cursor examples | low | docs-gap | document |
| F-2 | Invalid `TOOLS_JSON` path | medium | design-trade-off | document |

## Recommendations

### Immediate (documentation)

1. **F-1**: Add catalog-free `.cursor/mcp.json` example to README and `docs/integration/README.md`.
2. **F-2**: Document that `NENE_MCP_TOOLS_JSON` must be **omitted** until the file exists—empty/wrong paths fail `tools/list`.

### Suggested (package change)

None for FT4 — about-only wire behaves as designed.

### Trade-offs

**F-2**: Graceful degradation to about-only on bad catalog path would help DX but could hide misconfiguration; keep fail-loud; document clearly.

## Security Review (required when N % 3 == 0)

N/A — scheduled for FT6.

## Follow-up Issues

None — documentation updates land in this FT PR.

## Overall Impression

The catalog-free path is a useful **Day 0** story: install from Packagist, point Cursor at `vendor/bin/nene-mcp`, confirm MCP health via `nene_mcp_about` before investing in OpenAPI catalog work. Documentation should lead with this smaller example alongside the full NeNe health catalog flow.

## Next FT gate

- [ ] Merge FT4 report + doc updates before FT5
