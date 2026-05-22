# Field Trial 439 — Security review — catalog probes + double JSON-RPC stdin (L7)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.6`
- Runner: `tools/ft-individual.sh 439`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Security review — catalog probes + double JSON-RPC stdin (L7)**.

## Steps Taken

### 1. Primary suite

```text
# FT security catalog probes
PASS duplicate names rejected
PASS invalid JSON rejected
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"bad\",\n    \"operationId\": \"x\",\n    \"statusCode\": 404,\n    \"requestId\": null,\n    \"body\": {\n       

# Adversarial probe (FT255+ L6, variant 7)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"listInventoryItems\",\n    \"operationId\": \"listItems\",\n    \"statusCode\": 200,\n    \"requestId\": null,\n    \"body\": {\n        \"items\": []\n    }\n}"}],"structuredContent":{"tool":"listInventoryItems","operationId":"listItems","statusCode":200,"requestId":null,"body":{"items":[]}},"isError":false}}
ADV-PASS query injection attempt logged (http_build_query encoding)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getHealth\",\n    \"operationId\": \"health\",\n    \"statusCode\": 404,\n    \"requestId\": null,\n    \"body\": {\n        \"error\": \"not_found\"\n    }\n}"}],"structuredContent":{"tool":"getHealth","operationId":"health","statusCode":404,"requestId":null,"body":{"error":"not_found"}},"isError":true}}
ADV-PASS wrong URI prefix yields 404 not SSRF

# L7 probe (FT420+, variant 1)
{"jsonrpc":"2.0","id":1,"result":{"tools":[{"name":"nene_mcp_about","title":"About nene-mcp","description":"Return package metadata and resolved environment (paths and base URLs only; no secrets).","inputSchema":{"type":"object","properties":{},"additionalProperties":false},"annotations":{"readOnlyH
ADV-PASS double JSON-RPC handled
```

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Automated suite | PASS lines, no FAIL | See log above | Pass |
| Security cadence (N % 3 == 0) | write-failclosed pass | N/A | N/A |

## Friction Summary

L7 + L6 adversarial exercised — see probe log. NeNe Bearer gate: FT450 after #380/#395.

## Recommendations

None.

## Security Review (required when N % 3 == 0)

N/A — security review scheduled for FT441.

## Follow-up Issues

None.

## Overall Impression

Automated FT439 (Security review — catalog probes + double JSON-RPC stdin (L7)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT440
