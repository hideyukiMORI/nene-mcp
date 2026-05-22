# Field Trial 265 — Catalog edge cases + Bearer bypass / empty token (L6)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.4`
- Runner: `tools/ft-individual.sh 265`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Catalog edge cases + Bearer bypass / empty token (L6)**.

## Steps Taken

### 1. Primary suite

```text
# FT security catalog probes
PASS duplicate names rejected
PASS invalid JSON rejected
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"bad\",\n    \"operationId\": \"x\",\n    \"statusCode\": 404,\n    \"requestId\": null,\n    \"body\": {\n       

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
| Security cadence (N % 3 == 0) | write-failclosed pass | N/A | N/A |

## Friction Summary

Adversarial L6 exercised — attacks blocked or deferred (NeNe #380). Whitespace bearer: #64.

## Recommendations

None.

## Security Review (required when N % 3 == 0)

N/A — security review scheduled for FT267.

## Follow-up Issues

None.

## Overall Impression

Automated FT265 (Catalog edge cases + Bearer bypass / empty token (L6)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT266
