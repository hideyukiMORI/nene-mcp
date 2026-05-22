# Field Trial 1 — NeNe health catalog

## Date

2026-05-22

## Baseline

- nene-mcp ref: `v0.1.0` (commit `cd29c98`)
- FT clone path: `../nene-mcp-FT/ft1-nene-health/`
- Host app: NeNe (shallow clone of `hideyukiMORI/NeNe`)
- PHP: 8.4.21 (MCP server process and NeNe runtime)
- MCP client: stdio smoke via piped JSON-RPC (Cursor config validated against README pattern; UI not exercised in this FT)
- Env:
  - `NENE_MCP_API_BASE_URL=http://localhost:8080`
  - `NENE_MCP_TOOLS_JSON=/home/xi/docker/nene-mcp-FT/ft1-nene-health/docs/mcp/tools.json`

## Goal

Verify NeNe + health catalog end to end from `composer require hideyukimori/nene-mcp@0.1.0` through MCP `tools/list` and `tools/call` against a live `GET /health/index`.

## Integration Built

- Catalog: `docs/mcp/tools.json` in FT clone (1 tool: `getHealthCheck`)
- HTTP surface exercised: `GET /health/index` (`operationId: healthCheck`)
- MCP methods verified: `initialize`, `tools/list`, `tools/call` (`getHealthCheck`, `nene_mcp_about`)

## Steps Taken

### 1. Clone NeNe into FT directory

```bash
mkdir -p ../nene-mcp-FT
git clone --depth 1 https://github.com/hideyukiMORI/NeNe.git ../nene-mcp-FT/ft1-nene-health
```

Succeeded without friction.

### 2. Bootstrap host dependencies (`composer install`)

Fresh clone on PHP 8.4.21 without the `intl` extension failed during Symfony String autoload:

```
Fatal error: Uncaught RuntimeException: The "intl" PHP extension is not available...
  in vendor/symfony/string/AbstractUnicodeString.php
```

**Finding (F-1)**: NeNe's Composer tree pulls Symfony components that require `ext-intl`. A new integrator on a minimal PHP install stalls before reaching nene-mcp. Workaround: copy `vendor/` from an existing NeNe tree or install `php-intl`.

### 3. Start local API (Docker unavailable)

`docker` was not available in the WSL environment used for this FT.

**Finding (F-2)**: Integration docs assume `docker compose up`. Without Docker, the integrator must discover SQLite + built-in server setup from NeNe CLI docs.

Workaround applied:

```bash
cp .env.example .env
# NENE_DB_TYPE=SQLite3 in .env
php cli/initSQLite.php --yes
cd htdocs && php -S localhost:8080
```

Direct `curl http://localhost:8080/health/index` returned HTTP 200 with expected NeNe health JSON.

### 4. Add nene-mcp via Composer (pre-Packagist)

`composer require hideyukimori/nene-mcp:0.1.0` failed until a VCS repository was configured:

```bash
composer config repositories.nene-mcp vcs https://github.com/hideyukiMORI/nene-mcp
composer require hideyukimori/nene-mcp:0.1.0
```

A path repository to the local checkout also failed version resolution (`dev-main` does not match `0.1.0`).

**Finding (F-3)**: Until Packagist publication, integrators need an explicit VCS (or tagged path) repository stanza. The integration guide currently shows only `composer require hideyukimori/nene-mcp`.

### 5. Create tool catalog

Added `docs/mcp/tools.json` using the sample from `docs/example-ne-health-catalog.md`. No friction.

### 6. MCP stdio verification

Set env vars and piped JSON-RPC to `vendor/bin/nene-mcp`:

- `initialize` → protocol `2024-11-05`, server `nene-mcp` `0.1.0`
- `tools/list` → `nene_mcp_about` + `getHealthCheck`
- `tools/call getHealthCheck` → HTTP 200, NeNe health body (`healthStatus: ok`, `databaseType: SQLite3`)
- `tools/call nene_mcp_about` → catalog path and base URL resolved (no secrets)
- Unknown tool → JSON-RPC error `-32603`
- Malformed stdin → JSON-RPC error `-32700`

No friction on MCP wire behavior for this read-only health path.

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| MCP server starts | stdio process healthy | Four JSON-RPC responses, exit 0 | Pass |
| `tools/list` | `nene_mcp_about` + catalog tools | Both tools present with `readOnlyHint` | Pass |
| `tools/call` (read) | HTTP 2xx + JSON body | 200, full NeNe health envelope | Pass |
| `tools/call` (error path) | Safe JSON-RPC error, no leak | `-32603` for unknown tool; `-32700` for bad JSON | Pass |
| Write tool + Bearer | 401 without token; success with env token | N/A (health tool is `safety: read`) | N/A |

## Friction Summary

| ID | Location | Severity | Kind | Decision |
| --- | --- | --- | --- | --- |
| F-1 | NeNe host bootstrap | high | docs-gap | fix-in-host → [NeNe #309](https://github.com/hideyukiMORI/NeNe/issues/309) / [PR #310](https://github.com/hideyukiMORI/NeNe/pull/310) |
| F-2 | NeNe local API startup | medium | docs-gap | document |
| F-3 | Composer install (pre-Packagist) | medium | docs-gap | document |

## Recommendations

### Immediate (documentation)

1. **F-3 — Pre-Packagist install**: Add VCS repository snippet to `docs/integration/nene.md` and README until Packagist is live.
2. **F-1 — PHP intl**: Routed to NeNe — [PR #310](https://github.com/hideyukiMORI/NeNe/pull/310) documents `ext-intl` and adds `intl` to the Docker dev image. nene-mcp integration docs link prerequisites.
3. **F-2 — Non-Docker path**: Document SQLite + `php -S` as a valid FT/local-dev alternative when Docker is unavailable.

### Suggested (package change)

None for FT1 read-only health path—the MCP bridge behaved as documented once env and catalog were in place.

### Trade-offs (ADR or cross-repo)

None.

## Security Review (required when N % 3 == 0)

N/A — security review scheduled for FT3.

## Follow-up Issues

| Priority | Issue / PR | Repo | Decision |
| --- | --- | --- | --- |
| high | #10 | nene-mcp | document |
| medium | #11 | nene-mcp | document |
| medium | #12 | nene-mcp | document |
| high | [#309](https://github.com/hideyukiMORI/NeNe/issues/309) / [PR #310](https://github.com/hideyukiMORI/NeNe/pull/310) | NeNe | fix-in-host |

## Overall Impression

Once the host app runs and the catalog path is set, nene-mcp `v0.1.0` delivers a straightforward stdio MCP bridge to NeNe's health endpoint. The dominant friction was **host bootstrap** (PHP extensions, Docker absence, pre-Packagist Composer)—not MCP protocol or catalog schema. Packagist publication and clearer prerequisite docs should reduce FT2 setup time.

## Next FT gate

- [ ] All actionable Issues from this FT closed before starting FT2
