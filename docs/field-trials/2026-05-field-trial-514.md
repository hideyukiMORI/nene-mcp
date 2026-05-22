# Field Trial 514 — Write fail-closed regression + TLS CA on http base (L10)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.8`
- Runner: `tools/ft-individual.sh 514`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Write fail-closed regression + TLS CA on http base (L10)**.

## Steps Taken

### 1. Primary suite

```text
PASS write fail-closed

# Adversarial probe (FT255+ L6, variant 2)
{"jsonrpc":"2.0","id":null,"error":{"code":-32700,"message":"Syntax error"}}
ADV-PASS malformed JSON-RPC rejected
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"MCP tool \"nonexistent_tool_xyz\" was not found."}}
ADV-PASS unknown tool rejected
{"jsonrpc":"2.0","id":1,"result":{"tools":[{"name":"nene_mcp_about","title":"About nene-mcp","description":"Return package metadata and resolved environment (paths and base URLs only; no secrets).","i
ADV-PASS oversized line handled

# L7 probe (FT420+, variant 4)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getTodoById\",\n    \"operationId\": \"getTodo\",\n    \"statusCode\": 405,\n    \"requestId\": null,\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"failure\",\n            \"errorCode\": \"METHOD-NOT-ALLOWED\",\n            \"errorMessage\": \"The HTTP method is not allowed for this endpoint.\"\n        }\n    }\n}"}],"structuredContent":{"tool":"getTodoById","operationId":"getTodo","statusCode":405,"requestId":null,"body":{"Result":true,"Data":{"status":"failure","errorCode":"METHOD-NOT-ALLOWED","errorMessage":"The HTTP method is not allowed for this endpoint."}}},"isError":true}}
ADV-PASS unicode/null id encoded in path

# L8 probe (FT451+, variant 4)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getHealth\",\n    \"operationId\": \"health\",\n    \"statusCode\": 200,\n    \"requestId\": null,\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"healthStatus\": \"ok\",\n            \"api\": true,\n            \"database\": true,\n            \"schema\": true,\n            \"environment\": \"development\",\n            \"databaseType\": \"MySQL\"\n        }\n    }\n}"}],"structuredContent":{"tool":"getHealth","operationId":"health","statusCode":200,"requestId":null,"body":{"Result":true,"Data":{"status":"success","errorCode":"","healthStatus":"ok","api":true,"database":true,"schema":true,"environment":"development","databaseType":"MySQL"}}},"isError":false}}
ADV-PASS empty base URL fails safe

# L9 probe (FT480+, variant 4)
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"HTTP request failed for \"127.0.0.1:9090/health\"."}}
ADV-PASS scheme-less base URL fails safe

# L10 probe (FT510+, v0.1.8 SMB, variant 4)
{"jsonrpc":"2.0","id":1,"result":{"tools":[{"name":"nene_mcp_about","title":"About nene-mcp","description":"Return package metadata and resolved environment (paths and base URLs only; no secrets).","inputSchema":{"type":"object","properties":{},"additionalProperties":false},"annotations":{"readOnlyHint":true}},{"name":"getHealth","title":"Health","description":"only health deployed","inputSchema":{"type":"object","properties":{},"additionalProperties":false},"annotations":{"readOnlyHint":true}}]}}
ADV-PASS TLS CA env ignored for http base URL
```

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Automated suite | PASS lines, no FAIL | See log above | Pass |
| Security cadence (N % 3 == 0) | write-failclosed pass | N/A | N/A |

## Friction Summary

L10 + L9 + L8 + L7 + L6 adversarial exercised — v0.1.8 SMB probes. FT450 on hold for NeNe #395.

## Recommendations

None.

## Security Review (required when N % 3 == 0)

N/A — security review scheduled for FT516.

## Follow-up Issues

None.

## Overall Impression

Automated FT514 (Write fail-closed regression + TLS CA on http base (L10)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT515
