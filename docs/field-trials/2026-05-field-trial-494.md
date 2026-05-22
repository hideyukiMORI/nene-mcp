# Field Trial 494 — Write fail-closed regression + JSON-RPC params array (L9)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.6`
- Runner: `tools/ft-individual.sh 494`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Write fail-closed regression + JSON-RPC params array (L9)**.

## Steps Taken

### 1. Primary suite

```text
PASS write fail-closed

# Adversarial probe (FT255+ L6, variant 6)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"mislabeledWrite\",\n    \"operationId\": \"c\",\n    \"statusCode\": 401,\n    \"requestId\": null,\n    \"body\": {\n        \"error\": \"unauthorized\"\n    }\n}"}],"structuredContent":{"tool":"mislabeledWrite","operationId":"c","statusCode":401,"requestId":null,"body":{"error":"unauthorized"}},"isError":true}}
ADV-PASS F-7 documented: safety:read on protected POST returns API 401 (see write-tools-bearer)

# L7 probe (FT420+, variant 2)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getHealth\",\n    \"operationId\": \"health\",\n    \"statusCode\": 200,\n    \"requestId\": null,\n    \"body\": {\n        \"status\": \"ok\"\n    }\n}"}],"structuredContent":{"tool":"getHealth","operationId":"health","statusCode":200,"requestId":null,"body":{"status":"ok"}},"isError":false}}
ADV-PASS embedded creds URL still hit local mock

# L8 probe (FT451+, variant 2)
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"MCP tool catalog could not be read from \"/tmp/ft-l8-494/bad.json}\"."}}
ADV-PASS truncated catalog JSON rejected

# L9 probe (FT480+, variant 2)
{"jsonrpc":"2.0","id":1,"result":{"tools":[{"name":"nene_mcp_about","title":"About nene-mcp","description":"Return package metadata and resolved environment (paths and base URLs only; no secrets).","inputSchema":{"type":"object","properties":{},"additionalProperties":false},"annotations":{"readOnlyHint":true}},{"name":"getHealth","title":"Health","description":"only health deployed","inputSchema":{"type":"object","properties":{},"additionalProperties":false},"annotations":{"readOnlyHint":true}}]}}
WARN params array response logged
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

Automated FT494 (Write fail-closed regression + JSON-RPC params array (L9)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT495
