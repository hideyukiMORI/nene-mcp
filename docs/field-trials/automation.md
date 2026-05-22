# Field Trial Automation

Regression harness for repeatable MCP smoke and security probes. **Not a substitute for individual field trial reports** — see [`quality-strategy.md`](quality-strategy.md).

## Tools

| Script | Purpose |
| --- | --- |
| [`tools/ft-runner.sh`](../../tools/ft-runner.sh) | Single-suite MCP smoke / security probes |
| [`tools/ft-cycle.sh`](../../tools/ft-cycle.sh) | Batch regression using rotation matrix (log only) |

## Environment

```bash
export NENE_MCP_API_BASE_URL=http://localhost:8080
export FT5_CATALOG=/path/to/docs/mcp/tools.json
```

When developing nene-mcp itself, `ft-runner.sh` prefers `$ROOT/bin/nene-mcp` so local changes are exercised. Set `NENE_MCP_BIN` explicitly only when testing a Packagist install (e.g. `packagist` suite).

NeNe Docker should be running for HTTP tool calls in `smoke` / `multi-read` suites.

## Suites

```bash
tools/ft-runner.sh smoke "$FT5_CATALOG"
tools/ft-runner.sh multi-read "$FT5_CATALOG"
tools/ft-runner.sh security-catalog /tmp/ft6
tools/ft-runner.sh about-only
tools/ft-runner.sh packagist /tmp/ft8
tools/ft-runner.sh write-failclosed /tmp/ft9
```

## Batch cycle (regression log only)

```bash
tools/ft-cycle.sh 19 100   # log → /tmp/ft-cycle.log
```

Rotation: see [`schedule-ft5-100.md`](schedule-ft5-100.md). Milestone batch files under `milestones/` are **not** FT completion records.

## CI

GitHub Actions runs `composer test` then `write-failclosed` and `security-catalog` via `ft-runner.sh` (see `.github/workflows/ci.yml`).
