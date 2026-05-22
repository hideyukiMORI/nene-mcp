# Field Trial 554 — Write fail-closed regression + timeout out-of-range clamp (L11)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.8`
- Runner: `tools/ft-individual.sh 554`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Write fail-closed regression + timeout out-of-range clamp (L11)**.

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

# L7 probe (FT420+, variant 2)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getHealth\",\n    \"operationId\": \"health\",\n    \"statusCode\": 200,\n    \"requestId\": null,\n    \"body\": {\n        \"status\": \"ok\"\n    }\n}"}],"structuredContent":{"tool":"getHealth","operationId":"health","statusCode":200,"requestId":null,"body":{"status":"ok"}},"isError":false}}
ADV-PASS embedded creds URL still hit local mock

# L8 probe (FT451+, variant 2)
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"MCP tool catalog could not be read from \"/tmp/ft-l8-554/bad.json}\"."}}
ADV-PASS truncated catalog JSON rejected

# L9 probe (FT480+, variant 2)
{"jsonrpc":"2.0","id":1,"result":{"tools":[{"name":"nene_mcp_about","title":"About nene-mcp","description":"Return package metadata and resolved environment (paths and base URLs only; no secrets).","inputSchema":{"type":"object","properties":{},"additionalProperties":false},"annotations":{"readOnlyHint":true}},{"name":"getHealth","title":"Health","description":"only health deployed","inputSchema":{"type":"object","properties":{},"additionalProperties":false},"annotations":{"readOnlyHint":true}}]}}
WARN params array response logged

# L10 probe (FT510+, v0.1.8 SMB, variant 2)
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"MCP catalog field \"safety\" must be \"read\" or \"write\", got \"admin\"."}}
ADV-PASS invalid safety rejected (#85)

# L11 probe (FT540+, operator boundaries, variant 2)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"nene_mcp_about\",\n    \"packageName\": \"hideyukiMORI/nene-mcp\",\n    \"packageVersion\": \"0.1.8\",\n    \"phpVersion\": \"8.4.21\",\n    \"runtime\": {\n        \"catalogPath\": null,\n        \"apiBaseUrl\": \"http://127.0.0.1:9090\",\n        \"hasBearerTokenConfigured\": false,\n        \"httpTimeoutSec\": 10,\n        \"tlsCaFileConfigured\": false,\n        \"httpLogStderr\": false\n    }\n}"}],"structuredContent":{"tool":"nene_mcp_about","packageName":"hideyukiMORI/nene-mcp","packageVersion":"0.1.8","phpVersion":"8.4.21","runtime":{"catalogPath":null,"apiBaseUrl":"http://127.0.0.1:9090","hasBearerTokenConfigured":false,"httpTimeoutSec":10,"tlsCaFileConfigured":false,"httpLogStderr":false}},"isError":false}}
ADV-PASS out-of-range timeout falls back to 10
```

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Automated suite | PASS lines, no FAIL | See log above | Pass |
| Security cadence (N % 3 == 0) | write-failclosed pass | N/A | N/A |

## Friction Summary

L11 + L10 + L9 + L8 + L7 + L6 adversarial exercised — operator boundaries. FT450 on hold for NeNe #395.

## Recommendations

None.

## Security Review (required when N % 3 == 0)

N/A — security review scheduled for FT555.

## Follow-up Issues

None.

## Overall Impression

Automated FT554 (Write fail-closed regression + timeout out-of-range clamp (L11)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT555
