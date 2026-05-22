# Field Trial 493 — Misconfiguration adversarial + oversized Bearer token (L9)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.6`
- Runner: `tools/ft-individual.sh 493`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Misconfiguration adversarial + oversized Bearer token (L9)**.

## Steps Taken

### 1. Primary suite

```text
# FT493 misconfig probe
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"MCP tool catalog could not be read from \"/nonexistent/tools.json\"."}}
PASS invalid catalog path fails loud

# Adversarial probe (FT255+ L6, variant 5)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"sessionLogin\",\n    \"operationId\": \"login\",\n    \"statusCode\": 401,\n    \"requestId\": null,\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"failure\",\n            \"errorCode\": \"LOGIN-FAILED\",\n            \"errorMessage\": \"Wrong user ID or user PASS\"\n        }\n    }\n}"}],"structuredContent":{"tool":"sessionLogin","operationId":"login","statusCode":401,"requestId":null,"body":{"Result":true,"Data":{"status":"failure","errorCode":"LOGIN-FAILED","errorMessage":"Wrong user ID or user PASS"}}},"isError":true}}
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"createTodo\",\n    \"operationId\": \"createTodo\",\n    \"statusCode\": 401,\n    \"requestId\": null,\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"failure\",\n            \"errorCode\": \"SESSION-CLOSED\",\n            \"errorMessage\": \"Session timeout. Please log in again.\"\n        }\n    }\n}"}],"structuredContent":{"tool":"createTodo","operationId":"createTodo","statusCode":401,"requestId":null,"body":{"Result":true,"Data":{"status":"failure","errorCode":"SESSION-CLOSED","errorMessage":"Session timeout. Please log in again."}}},"isError":true}}
ADV-PASS NeNe write chain blocked (session/CSRF/Bearer — fix-in-host #380)

# L7 probe (FT420+, variant 1)
{"jsonrpc":"2.0","id":1,"result":{"tools":[{"name":"nene_mcp_about","title":"About nene-mcp","description":"Return package metadata and resolved environment (paths and base URLs only; no secrets).","inputSchema":{"type":"object","properties":{},"additionalProperties":false},"annotations":{"readOnlyH
ADV-PASS double JSON-RPC handled

# L8 probe (FT451+, variant 1)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getHealth\",\n    \"operationId\": \"health\",\n    \"statusCode\": 200,\n    \"requestId\": null,\n    \"body\": {\n        \"status\": \"ok\"\n    }\n}"}],"structuredContent":{"tool":"getHealth","operationId":"health","statusCode":200,"requestId":null,"body":{"status":"ok"}},"isError":false}}
ADV-PASS trailing-space base URL trimmed

# L9 probe (FT480+, variant 1)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getHealth\",\n    \"operationId\": \"health\",\n    \"statusCode\": 200,\n    \"requestId\": null,\n    \"body\":
ADV-PASS oversized bearer did not crash MCP
```

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Automated suite | PASS lines, no FAIL | See log above | Pass |
| Security cadence (N % 3 == 0) | write-failclosed pass | N/A | N/A |

## Friction Summary

L9 + L8 + L7 + L6 adversarial exercised — see probe log. FT450 reserved for NeNe merge.

## Recommendations

None.

## Security Review (required when N % 3 == 0)

N/A — security review scheduled for FT495.

## Follow-up Issues

None.

## Overall Impression

Automated FT493 (Misconfiguration adversarial + oversized Bearer token (L9)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT494
