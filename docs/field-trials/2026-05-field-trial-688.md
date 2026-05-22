# Field Trial 688 — Combined smoke milestone + Bearer + stderr log write (L15)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.8`
- Runner: `tools/ft-individual.sh 688`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Combined smoke milestone + Bearer + stderr log write (L15)**.

## Steps Taken

### 1. Primary suite

```text
PASS about-only [{'name': 'nene_mcp_about', 'title': 'About nene-mcp', 'description': 'Return package metadata and resolved environment (paths and base URLs only; no secrets).', 'inputSchema': {'type': 'object', 'properties': {}, 'additionalProperties': False}, 'annotations': {'readOnlyHint': True}}]
# FT smoke: /home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json
PASS initialize
PASS tools/list about
tools: ['nene_mcp_about', 'getHealthCheck', 'listTodos', 'getHealthWrongId']
PASS tools/call getHealthCheck (HTTP response returned)
PASS tools/call listTodos (HTTP response returned)

# Adversarial probe (FT255+ L6, variant 0)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"ssrfAbs\",\n    \"operationId\": \"x\",\n    \"statusCode\": 404,\n    \"requestId\": null,\n    \"body\": {\n        \"error\": \"not_found\"\n    }\n}"}],"structuredContent":{"tool":"ssrfAbs","operationId":"x","statusCode":404,"requestId":null,"body":{"error":"not_found"}},"isError":true}}
ADV-PASS SSRF ssrfAbs stayed on configured base
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"ssrfProto\",\n    \"operationId\": \"y\",\n    \"statusCode\": 200,\n    \"requestId\": null,\n    \"body\": {\n        \"status\": \"ok\"\n    }\n}"}],"structuredContent":{"tool":"ssrfProto","operationId":"y","statusCode":200,"requestId":null,"body":{"status":"ok"}},"isError":false}}
ADV-PASS SSRF ssrfProto stayed on configured base

# L7 probe (FT420+, variant 4)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getTodoById\",\n    \"operationId\": \"getTodo\",\n    \"statusCode\": 401,\n    \"requestId\": \"4ada122682a2cbc5916fc7cc9b6875b9\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"failure\",\n            \"errorCode\": \"SESSION-CLOSED\",\n            \"errorMessage\": \"Session timeout. Please log in again.\"\n        }\n    }\n}"}],"structuredContent":{"tool":"getTodoById","operationId":"getTodo","statusCode":401,"requestId":"4ada122682a2cbc5916fc7cc9b6875b9","body":{"Result":true,"Data":{"status":"failure","errorCode":"SESSION-CLOSED","errorMessage":"Session timeout. Please log in again."}}},"isError":true}}
ADV-PASS unicode/null id encoded in path

# L8 probe (FT451+, variant 4)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getHealth\",\n    \"operationId\": \"health\",\n    \"statusCode\": 200,\n    \"requestId\": \"b1eccd6c8bec79f3e73555800fedd9e5\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"healthStatus\": \"ok\",\n            \"api\": true,\n            \"database\": true,\n            \"schema\": true,\n            \"environment\": \"development\",\n            \"databaseType\": \"MySQL\"\n        }\n    }\n}"}],"structuredContent":{"tool":"getHealth","operationId":"health","statusCode":200,"requestId":"b1eccd6c8bec79f3e73555800fedd9e5","body":{"Result":true,"Data":{"status":"success","errorCode":"","healthStatus":"ok","api":true,"database":true,"schema":true,"environment":"development","databaseType":"MySQL"}}},"isError":false}}
ADV-PASS empty base URL fails safe

# L9 probe (FT480+, variant 4)
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"HTTP request failed for \"127.0.0.1:9090/health\"."}}
ADV-PASS scheme-less base URL fails safe

# L10 probe (FT510+, v0.1.8 SMB, variant 4)
{"jsonrpc":"2.0","id":1,"result":{"tools":[{"name":"nene_mcp_about","title":"About nene-mcp","description":"Return package metadata and resolved environment (paths and base URLs only; no secrets).","inputSchema":{"type":"object","properties":{},"additionalProperties":false},"annotations":{"readOnlyHint":true}},{"name":"getHealth","title":"Health","description":"only health deployed","inputSchema":{"type":"object","properties":{},"additionalProperties":false},"annotations":{"readOnlyHint":true}}]}}
ADV-PASS TLS CA env ignored for http base URL

# L11 probe (FT540+, operator boundaries, variant 4)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"nene_mcp_about\",\n    \"packageName\": \"hideyukiMORI/nene-mcp\",\n    \"packageVersion\": \"0.1.8\",\n    \"phpVersion\": \"8.4.21\",\n    \"runtime\": {\n        \"catalogPath\": null,\n        \"apiBaseUrl\": \"http://127.0.0.1:9090\",\n        \"hasBearerTokenConfigured\": false,\n        \"httpTimeoutSec\": 10,\n        \"tlsCaFileConfigured\": false,\n        \"httpLogStderr\": false\n    }\n}"}],"structuredContent":{"tool":"nene_mcp_about","packageName":"hideyukiMORI/nene-mcp","packageVersion":"0.1.8","phpVersion":"8.4.21","runtime":{"catalogPath":null,"apiBaseUrl":"http://127.0.0.1:9090","hasBearerTokenConfigured":false,"httpTimeoutSec":10,"tlsCaFileConfigured":false,"httpLogStderr":false}},"isError":false}}
ADV-PASS whitespace TLS CA treated as unset

# L12 probe (FT570+, NENE2 alias compatibility, variant 4)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"nene_mcp_about\",\n    \"packageName\": \"hideyukiMORI/nene-mcp\",\n    \"packageVersion\": \"0.1.8\",\n    \"phpVersion\": \"8.4.21\",\n    \"runtime\": {\n        \"catalogPath\": null,\n        \"apiBaseUrl\": \"https://127.0.0.1:9090\",\n        \"hasBearerTokenConfigured\": false,\n        \"httpTimeoutSec\": 10,\n        \"tlsCaFileConfigured\": true,\n        \"httpLogStderr\": false\n    }\n}"}],"structuredContent":{"tool":"nene_mcp_about","packageName":"hideyukiMORI/nene-mcp","packageVersion":"0.1.8","phpVersion":"8.4.21","runtime":{"catalogPath":null,"apiBaseUrl":"https://127.0.0.1:9090","hasBearerTokenConfigured":false,"httpTimeoutSec":10,"tlsCaFileConfigured":true,"httpLogStderr":false}},"isError":false}}
ADV-PASS TLS CA flag set for https base

# L13 probe (FT600+, HTTP diagnostics, variant 4)
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"Write tool \"w\" requires bearer authentication. Set NENE_MCP_BEARER_TOKEN in the MCP server environment."}}
ADV-PASS write fail-closed holds with custom timeout

# L14 probe (FT630+, Bearer E2E regression, variant 4)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getHealthCheck\",\n    \"operationId\": \"healthCheck\",\n    \"statusCode\": 200,\n    \"requestId\": \"8af883ae2d41e9697d397108e33c0a84\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"healthStatus\": \"ok\",\n            \"api\": true,\n            \"database\": true,\n            \"schema\": true,\n            \"environment\": \"development\",\n            \"databaseType\": \"MySQL\"\n        }\n    }\n}"}],"structuredContent":{"tool":"getHealthCheck","operationId":"healthCheck","statusCode":200,"requestId":"8af883ae2d41e9697d397108e33c0a84","body":{"Result":true,"Data":{"status":"success","errorCode":"","healthStatus":"ok","api":true,"database":true,"schema":true,"environment":"development","databaseType":"MySQL"}}},"isError":false}}
--- stderr ---
[nene-mcp] GET /health/index status=200 duration_ms=5
ADV-PASS stderr log on stderr only; stdout is JSON-RPC

# L15 probe (FT660+, Bearer+operator composite, variant 4)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"createTodo\",\n    \"operationId\": \"createTodo\",\n    \"statusCode\": 200,\n    \"requestId\": \"5a91edaa53d99421dda05ae4c41ff1ee\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"todo\": {\n                \"id\": 82,\n                \"user_id\": 1,\n                \"title\": \"L15 stderr write\",\n                \"is_completed\": false,\n                \"created_at\": \"2026-05-22 15:59:03\",\n                \"updated_at\": \"2026-05-22 15:59:03\"\n            }\n        }\n    }\n}"}],"structuredContent":{"tool":"createTodo","operationId":"createTodo","statusCode":200,"requestId":"5a91edaa53d99421dda05ae4c41ff1ee","body":{"Result":true,"Data":{"status":"success","errorCode":"","todo":{"id":82,"user_id":1,"title":"L15 stderr write","is_completed":false,"created_at":"2026-05-22 15:59:03","updated_at":"2026-05-22 15:59:03"}}}},"isError":false}}
[nene-mcp] POST /todo/index status=200 duration_ms=6
ADV-PASS Bearer write with stderr log; stdout clean
```

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Automated suite | PASS lines, no FAIL | See log above | Pass |
| Security cadence (N % 3 == 0) | write-failclosed pass | N/A | N/A |

## Friction Summary

L15 + L14 … L6 adversarial exercised — Bearer+operator composite probes.

## Recommendations

None.

## Security Review (required when N % 3 == 0)

N/A — security review scheduled for FT690.

## Follow-up Issues

None.

## Overall Impression

Automated FT688 (Combined smoke milestone + Bearer + stderr log write (L15)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT689
