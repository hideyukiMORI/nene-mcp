# Field Trial 2 — NeNe Docker + Cursor config

## Date

2026-05-22

## Baseline

- nene-mcp ref: `v0.1.0` (Packagist not yet live — VCS install)
- FT clone path: `../nene-mcp-FT/ft2-nene-cursor-docker/`
- Host app: NeNe (`docker compose up --build`)
- PHP: 8.4.21 (host MCP process); PHP 8.4.21 in Docker app container
- MCP client: `.cursor/mcp.json` in FT clone; stdio smoke from host (Cursor UI not exercised in this automation run)
- Env:
  - `NENE_MCP_API_BASE_URL=http://localhost:8080`
  - `NENE_MCP_TOOLS_JSON=/home/xi/docker/nene-mcp-FT/ft2-nene-cursor-docker/docs/mcp/tools.json`

## Goal

Validate the documented golden path: NeNe via Docker Compose, host-side `vendor/bin/nene-mcp`, health catalog, and project-level Cursor MCP config.

## Integration Built

- Catalog: `docs/mcp/tools.json` (1 tool: `getHealthCheck`)
- HTTP surface: `GET /health/index` via Docker MySQL stack
- MCP config: `.cursor/mcp.json` with absolute paths
- MCP methods verified: `initialize`, `tools/list`, `tools/call`

## Steps Taken

### 1. Fresh NeNe clone + Docker Compose

```bash
git clone --depth 1 https://github.com/hideyukiMORI/NeNe.git ../nene-mcp-FT/ft2-nene-cursor-docker
cd ../nene-mcp-FT/ft2-nene-cursor-docker
docker compose up --build -d
```

First `curl http://localhost:8080/health/index` returned SQLite data — a stale FT1 `php -S` process still bound port 8080.

**Finding (F-1)**: A previous local PHP built-in server on `:8080` blocks Docker port publish silently (connection refused until the process is stopped and compose restarted). Integrators switching from FT1 SQLite shortcut to Docker can hit this.

After stopping the stale process and `docker compose down && docker compose up -d`, health returned `databaseType: MySQL` as expected.

### 2. Packagist install (G1)

```bash
composer require hideyukimori/nene-mcp:^0.1   # no VCS stanza
```

Failed — package not on Packagist yet.

**Finding (F-2)**: G1 (Packagist publication) still pending. Tracked in nene-mcp Issue #16. FT2 used VCS install on the host:

```bash
composer config repositories.nene-mcp vcs https://github.com/hideyukiMORI/nene-mcp
composer require hideyukimori/nene-mcp:0.1.0
```

### 3. Host Composer vs Docker vendor volume

NeNe Compose mounts application code but stores `vendor/` in a **named Docker volume**. `vendor/bin/nene-mcp` exists inside the container but not on the host bind mount until `composer install` runs on the host.

**Finding (F-3)**: Cursor MCP on the **host** requires a host-side `composer install` (including `hideyukimori/nene-mcp`) even when the app runs in Docker. Integration docs should state this split explicitly.

Host install succeeded after `ext-intl` was available (NeNe PR #310).

### 4. Tool catalog and Cursor config

Added `docs/mcp/tools.json` and `.cursor/mcp.json` per `docs/integration/nene.md`. No schema friction.

### 5. MCP stdio verification (host → Docker API)

Host `vendor/bin/nene-mcp` with env vars:

- `initialize` → nene-mcp `0.1.0`
- `tools/list` → `nene_mcp_about` + `getHealthCheck`
- `tools/call getHealthCheck` → HTTP 200, `databaseType: MySQL`

Golden path confirmed once port 8080 is free and host vendor exists.

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Docker NeNe health | MySQL stack, HTTP 200 | `healthStatus: ok`, `databaseType: MySQL` | Pass |
| MCP server starts | stdio healthy | Exit 0, three JSON-RPC responses | Pass |
| `tools/list` | about + catalog | Both tools, `readOnlyHint` | Pass |
| `tools/call getHealthCheck` | HTTP 2xx + JSON | 200, full health envelope | Pass |
| Packagist install | `composer require` only | Package not found | Fail (G1 pending) |
| Cursor UI | Server green in Cursor | Not automated this run; config file matches README | Partial |

## Friction Summary

| ID | Location | Severity | Kind | Decision |
| --- | --- | --- | --- | --- |
| F-1 | Port 8080 conflict | medium | docs-gap | document |
| F-2 | Packagist (G1) | medium | process-gap | document (#16) |
| F-3 | Docker vendor vs host MCP | medium | docs-gap | document |

## Recommendations

### Immediate (documentation)

1. **F-1 — Port conflict**: Note in `docs/integration/nene.md` — stop other `:8080` listeners before `docker compose up`.
2. **F-3 — Host MCP + Docker app**: Document that Cursor runs `nene-mcp` on the host; run host `composer require hideyukimori/nene-mcp` even when NeNe is containerized.
3. **F-2 — Packagist**: Complete [`packagist-setup.md`](../development/packagist-setup.md) (Issue #16).

### Suggested (package change)

None.

### Trade-offs

None.

## Security Review (required when N % 3 == 0)

N/A — scheduled for FT3.

## Follow-up Issues

| Priority | Issue | Decision |
| --- | --- | --- |
| medium | #16 | process (Packagist G1) |

Integration doc updates for F-1 and F-3 land in the FT2 PR (no separate Issue).

## Overall Impression

Docker + host MCP is the right golden path for NeNe integrators. The flow works cleanly once Packagist is live and docs clarify host-side Composer for MCP versus containerized app runtime. Port conflicts are an easy papercut worth one paragraph in integration docs.

## Next FT gate

- [ ] Close #16 (Packagist) before FT3
