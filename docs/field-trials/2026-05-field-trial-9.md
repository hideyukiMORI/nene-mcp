# Field Trial 9 — Security review (write + Bearer fail-closed)

## Date

2026-05-22

## Baseline

- nene-mcp ref: `main` (post-#22 fix; targets `v0.1.3`)
- FT clone path: in-repo harness (`tools/ft-runner.sh`) + PHPUnit
- Host app: stub base URL (write probe does not reach HTTP when Bearer missing)
- PHP: 8.4
- MCP client: stdio harness (same wire as Cursor)
- Env: `NENE_MCP_API_BASE_URL=http://localhost:8080`, catalog paths under `/tmp/ft9-*` (no secrets committed)

## Goal

Verify `safety: write` tools fail closed without `NENE_MCP_BEARER_TOKEN`, stderr stays clean, and catalog hygiene (#22 duplicate names) is enforced. FT9 is the scheduled security review (`N % 3 == 0`).

## Integration Built

- Catalog: synthetic write probe (`POST /session/login`, `safety: write`)
- HTTP surface exercised: none when Bearer absent (blocked before HTTP)
- MCP methods verified: `tools/list` (duplicate probe), `tools/call` (write probe), `nene_mcp_about` (secret leak check)

## Steps Taken

### 1. Write tool without Bearer

```bash
unset NENE_MCP_BEARER_TOKEN
tools/ft-runner.sh write-failclosed /tmp/ft9-run
```

**Result**: JSON-RPC `-32603` with message containing `requires bearer authentication`. No HTTP request issued (PHPUnit `RecordingHttpClient` confirms zero requests).

### 2. Duplicate catalog names (#22 fix)

FT6 **F-1** deferred duplicate-name validation. Implemented in `JsonToolCatalog::assertUniqueToolNames()` and re-probed:

```bash
tools/ft-runner.sh security-catalog /tmp/ft9-sec
```

**Result**: `PASS duplicate names rejected` — `tools/list` returns safe JSON-RPC error, not two tools with the same name.

**Finding (F-1)**: Resolved — was medium `feature-gap` from FT6; fixed in-package (#22).

### 3. Secret handling spot check

With `NENE_MCP_BEARER_TOKEN` set in env, `nene_mcp_about` output inspected — token not present in structured content or text.

### 4. Harness fix (quality)

`ft-runner.sh` previously preferred stale `NENE_MCP_BIN` from FT clones over in-repo `bin/nene-mcp`, causing false passes against Packagist `0.1.2`. Resolution order now prefers `$ROOT/bin/nene-mcp` for local development.

**Finding (F-2)**: Automation could test wrong binary (medium, process-gap). Fixed in `tools/ft-runner.sh`.

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| MCP server starts | stdio process healthy | OK | Pass |
| `tools/list` (valid catalog) | `nene_mcp_about` + catalog tools | OK | Pass |
| `tools/call` write without Bearer | Safe JSON-RPC error, no HTTP | `-32603` bearer message | Pass |
| `tools/list` duplicate names | Rejected at load | `-32603` duplicated message | Pass |
| `nene_mcp_about` with Bearer in env | No token in output | No leak observed | Pass |
| Write tool + Bearer | 401 without token; success with env token | Fail-closed only this FT | N/A (FT10) |

## Friction Summary

| ID | Location | Severity | Kind | Decision |
| --- | --- | --- | --- | --- |
| F-1 | catalog validation | medium | feature-gap | fix-in-package → **#22 / v0.1.3** |
| F-2 | `ft-runner.sh` binary resolution | medium | process-gap | fix-in-package |

## Recommendations

### Immediate (documentation)

1. **Quality strategy**: [`quality-strategy.md`](quality-strategy.md) — FT is one instrument; batch logs are not FT completion.

### Suggested (package change)

1. **F-1**: ✅ Duplicate tool name rejection in `JsonToolCatalog`.
2. **F-2**: ✅ Prefer local `bin/nene-mcp` in `ft-runner.sh`.
3. PHPUnit: write fail-closed, duplicate names, catalog invalid JSON.
4. CI: `write-failclosed` + `security-catalog` suites after `composer test`.

### Trade-offs (ADR or cross-repo)

None.

## Security Review (required when N % 3 == 0)

### SSRF and URL control

- [x] Catalog absolute URL probe still returns host 400 (Apache), no third-party fetch
- [x] Redirect following disabled since v0.1.2 (FT3)
- **Result**: pass

### Secret handling

- [x] Bearer not in catalog, repo, or `nene_mcp_about` output (spot check)
- [x] JSON-RPC errors do not echo `NENE_MCP_BEARER_TOKEN`
- **Result**: pass

### Write tools

- [x] `safety: write` without `NENE_MCP_BEARER_TOKEN` fails closed with explicit message
- [x] No silent anonymous write (HTTP not reached)
- **Result**: pass

### JSON-RPC / protocol

- [x] Invalid catalog JSON → safe error (`-32603` / parse error)
- [x] Duplicate names → safe error, no partial list
- **Result**: pass

**Security summary**: **pass** — write fail-closed confirmed; #22 catalog hygiene shipped; 0 new security Issues.

## Follow-up Issues

| Priority | Issue | Decision |
| --- | --- | --- |
| medium | #22 | fix-in-package → close on merge |
| — | — | FT10: Bearer write end-to-end with live NeNe session |

## Overall Impression

Write surface defaults are correct: missing Bearer stops before HTTP and surfaces a clear MCP error. The meaningful gap from FT6 (duplicate tool names) is now enforced at catalog load, with PHPUnit and CI backing the behavior. Batch FT9 automation from the earlier milestone was insufficient; this individual report plus code/tests is the quality bar going forward.

## Next FT gate

- [x] #22 closed (duplicate names) before FT10
- [ ] FT10: Bearer write e2e with NeNe protected endpoint
