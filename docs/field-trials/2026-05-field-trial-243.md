# Field Trial 243 — Misconfiguration adversarial + partial catalog (L4)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.4`
- Runner: `tools/ft-individual.sh 243`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Misconfiguration adversarial + partial catalog (L4)**.

## Steps Taken

### 1. Primary suite

```text
# FT243 misconfig probe
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"MCP tool catalog could not be read from \"/nonexistent/tools.json\"."}}
PASS invalid catalog path fails loud

# Persona probe (FT225+ band, variant 3)
# FT smoke: /home/xi/docker/nene-mcp-FT/ft206-persona-bearer-native/docs/mcp/tools-partial.json
PASS initialize
PASS tools/list about
tools: ['nene_mcp_about', 'getHealth']
```

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Automated suite | PASS lines, no FAIL | See log above | Pass |
| Security cadence (N % 3 == 0) | write-failclosed pass | Pass | Pass |

## Friction Summary

None this cycle.

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

Automated FT243 (Misconfiguration adversarial + partial catalog (L4)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT244
