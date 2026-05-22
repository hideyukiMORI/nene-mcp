# Field Trial Automation

Regression harness for repeatable MCP smoke and security probes. **Not a substitute for individual field trial reports** — see [`quality-strategy.md`](quality-strategy.md).

## Tools

| Script | Purpose |
| --- | --- |
| [`tools/ft-runner.sh`](../../tools/ft-runner.sh) | Single-suite MCP smoke / security probes |
| [`tools/ft-individual.sh`](../../tools/ft-individual.sh) | **One FT → one report file** (quality-first) |
| [`tools/ft-range.sh`](../../tools/ft-range.sh) | Batch FT{N}–FT{M} with individual reports |
| [`tools/ft-milestone.sh`](../../tools/ft-milestone.sh) | Aggregate pass/fail from range summary (log only) |
| [`tools/ft-cycle.sh`](../../tools/ft-cycle.sh) | Batch regression log without reports |

## Environment

```bash
export NENE_MCP_API_BASE_URL=http://localhost:8080
export FT5_CATALOG=/path/to/docs/mcp/tools.json
```

When developing nene-mcp itself, `ft-runner.sh` prefers `$ROOT/bin/nene-mcp`. Set `NENE_MCP_BIN` only for Packagist install tests inside the `packagist` suite.

## Individual FT (preferred)

```bash
tools/ft-individual.sh 42
tools/ft-range.sh 10 200
```

Reports: `docs/field-trials/2026-05-field-trial-{N}.md`

## Suites (ft-runner)

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
tools/ft-cycle.sh 19 200
```

## CI

GitHub Actions runs `composer test` then `write-failclosed` and `security-catalog` (`.github/workflows/ci.yml`).

## Index

FT10–FT200: [`index-ft10-200.md`](index-ft10-200.md)
