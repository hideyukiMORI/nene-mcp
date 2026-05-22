# Field Trial 417 — Fresh clone bootstrap + Bearer bypass / empty token (L6)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.6`
- Runner: `tools/ft-individual.sh 417`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Fresh clone bootstrap + Bearer bypass / empty token (L6)**.

## Steps Taken

### 1. Primary suite

```text
PASS about-only [{'name': 'nene_mcp_about', 'title': 'About nene-mcp', 'description': 'Return package metadata and resolved environment (paths and base URLs only; no secrets).', 'inputSchema': {'type': 'object', 'properties': {}, 'additionalProperties': False}, 'annotations': {'readOnlyHint': True}}]

# Adversarial probe (FT255+ L6, variant 1)
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"Write tool \"writeBypass\" requires bearer authentication. Set NENE_MCP_BEARER_TOKEN in the MCP server environment."}}
ADV-PASS write blocked without token
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"Write tool \"writeBypass\" requires bearer authentication. Set NENE_MCP_BEARER_TOKEN in the MCP server environment."}}
ADV-PASS whitespace-only bearer rejected (#64)
```

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Automated suite | PASS lines, no FAIL | See log above | Pass |
| Security cadence (N % 3 == 0) | write-failclosed pass | Pass | Pass |

## Friction Summary

Adversarial L6 exercised — attacks blocked or deferred (NeNe #380). Whitespace bearer: #64.

## Recommendations

None.

## Security Review (required when N % 3 == 0)

### SSRF and URL control

- [x] Catalog probes exercised this cycle
- [x] Redirect following disabled (v0.1.2+)
- **Result**: pass (automated probes)

### Secret handling

- [x] Write fail-closed re-checked on security cadence
- **Result**: pass

### Write tools

- [x] `safety: write` without Bearer fails closed
- **Result**: pass

### JSON-RPC / protocol

- [x] Invalid catalog paths / JSON return safe errors
- **Result**: pass

**Security summary**: pass — automated probes; no new Issues.

```text
PASS write fail-closed
```

## Follow-up Issues

None.

## Overall Impression

Automated FT417 (Fresh clone bootstrap + Bearer bypass / empty token (L6)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT418
