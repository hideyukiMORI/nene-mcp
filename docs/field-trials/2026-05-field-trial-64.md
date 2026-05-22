# Field Trial 64 — Write fail-closed regression

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.3`
- Runner: `tools/ft-individual.sh 64`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Write fail-closed regression**.

## Steps Taken

### 1. Primary suite

```text
PASS write fail-closed
```

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Automated suite | PASS lines, no FAIL | See log above | Pass |
| Security cadence (N % 3 == 0) | write-failclosed pass | N/A | N/A |

## Friction Summary

None this cycle.

## Recommendations

None.

## Security Review (required when N % 3 == 0)

N/A — security review scheduled for FT66.

## Follow-up Issues

None.

## Overall Impression

Automated FT64 (Write fail-closed regression): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT65
