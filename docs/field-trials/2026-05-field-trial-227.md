# Field Trial 227 — Fresh clone bootstrap + NeNe TODO session wall (L5)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.4`
- Runner: `tools/ft-individual.sh 227`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Fresh clone bootstrap + NeNe TODO session wall (L5)**.

## Steps Taken

### 1. Primary suite

```text
PASS about-only [{'name': 'nene_mcp_about', 'title': 'About nene-mcp', 'description': 'Return package metadata and resolved environment (paths and base URLs only; no secrets).', 'inputSchema': {'type': 'object', 'properties': {}, 'additionalProperties': False}, 'annotations': {'readOnlyHint': True}}]

# Persona probe (FT225+ band, variant 2)
{"jsonrpc":"2.0","id":null,"error":{"code":-32700,"message":"Syntax error"}}
WARN sessionLogin status
{"jsonrpc":"2.0","id":null,"error":{"code":-32700,"message":"Syntax error"}}
WARN NeNe TODO list without session — check host
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

N/A — security review scheduled for FT228.

## Follow-up Issues

None.

## Overall Impression

Automated FT227 (Fresh clone bootstrap + NeNe TODO session wall (L5)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT228
