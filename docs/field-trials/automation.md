# Field Trial Automation

Automated harness for recurring field trials (FT5–FT100). Human-written reports remain required for FT5–FT18; FT19+ use batch milestone summaries plus this runner.

## Tools

| Script | Purpose |
| --- | --- |
| [`tools/ft-runner.sh`](../../tools/ft-runner.sh) | Single-suite MCP smoke / security probes |
| [`tools/ft-cycle.sh`](../../tools/ft-cycle.sh) | Batch run FT{N}–FT{M} using rotation matrix |

## Environment

```bash
export NENE_MCP_BIN=/path/to/vendor/bin/nene-mcp
export NENE_MCP_API_BASE_URL=http://localhost:8080
export FT5_CATALOG=/path/to/docs/mcp/tools.json
```

NeNe Docker should be running for HTTP tool calls.

## Suites

```bash
tools/ft-runner.sh smoke "$FT5_CATALOG"
tools/ft-runner.sh multi-read "$FT5_CATALOG"
tools/ft-runner.sh security-catalog /tmp/ft6
tools/ft-runner.sh about-only
tools/ft-runner.sh packagist /tmp/ft8
tools/ft-runner.sh write-failclosed /tmp/ft9
```

## Batch cycle

```bash
tools/ft-cycle.sh 19 100   # log → /tmp/ft-cycle.log
```

Rotation: see [`schedule-ft5-100.md`](schedule-ft5-100.md).

## CI (future)

Wire `ft-runner.sh smoke` against fixture catalog in GitHub Actions when NeNe HTTP is mockable.
