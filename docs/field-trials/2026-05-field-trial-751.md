# Field Trial 751 — Multi-tool read catalog + createTodo invalid Bearer (L18)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.8`
- Runner: `tools/ft-individual.sh 751`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Multi-tool read catalog + createTodo invalid Bearer (L18)**.

## Steps Taken

### 1. Primary suite

```text
# FT smoke: /home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json
PASS initialize
PASS tools/list about
tools: ['nene_mcp_about', 'getHealthCheck', 'listTodos', 'getHealthWrongId']
PASS tools/call getHealthCheck (HTTP response returned)
PASS tools/call listTodos (HTTP response returned)

# Adversarial probe (FT255+ L6, variant 7)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"listInventoryItems\",\n    \"operationId\": \"listItems\",\n    \"statusCode\": 200,\n    \"requestId\": null,\n    \"body\": {\n        \"items\": []\n    }\n}"}],"structuredContent":{"tool":"listInventoryItems","operationId":"listItems","statusCode":200,"requestId":null,"body":{"items":[]}},"isError":false}}
ADV-PASS query injection attempt logged (http_build_query encoding)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getHealth\",\n    \"operationId\": \"health\",\n    \"statusCode\": 404,\n    \"requestId\": null,\n    \"body\": {\n        \"error\": \"not_found\"\n    }\n}"}],"structuredContent":{"tool":"getHealth","operationId":"health","statusCode":404,"requestId":null,"body":{"error":"not_found"}},"isError":true}}
ADV-PASS wrong URI prefix yields 404 not SSRF

# L7 probe (FT420+, variant 1)
{"jsonrpc":"2.0","id":1,"result":{"tools":[{"name":"nene_mcp_about","title":"About nene-mcp","description":"Return package metadata and resolved environment (paths and base URLs only; no secrets).","inputSchema":{"type":"object","properties":{},"additionalProperties":false},"annotations":{"readOnlyH
ADV-PASS double JSON-RPC handled

# L8 probe (FT451+, variant 1)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getHealth\",\n    \"operationId\": \"health\",\n    \"statusCode\": 200,\n    \"requestId\": null,\n    \"body\": {\n        \"status\": \"ok\"\n    }\n}"}],"structuredContent":{"tool":"getHealth","operationId":"health","statusCode":200,"requestId":null,"body":{"status":"ok"}},"isError":false}}
ADV-PASS trailing-space base URL trimmed

# L9 probe (FT480+, variant 1)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getHealth\",\n    \"operationId\": \"health\",\n    \"statusCode\": 200,\n    \"requestId\": null,\n    \"body\":
ADV-PASS oversized bearer did not crash MCP

# L10 probe (FT510+, v0.1.8 SMB, variant 1)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"nene_mcp_about\",\n    \"packageName\": \"hideyukiMORI/nene-mcp\",\n    \"packageVersion\": \"0.1.8\",\n    \"phpVersion\": \"8.4.21\",\n    \"runtime\": {\n        \"catalogPath\": null,\n        \"apiBaseUrl\": \"http://127.0.0.1:9090\",\n        \"hasBearerTokenConfigured\": false,\n        \"httpTimeoutSec\": 10,\n        \"tlsCaFileConfigured\": false,\n        \"httpLogStderr\": false\n    }\n}"}],"structuredContent":{"tool":"nene_mcp_about","packageName":"hideyukiMORI/nene-mcp","packageVersion":"0.1.8","phpVersion":"8.4.21","runtime":{"catalogPath":null,"apiBaseUrl":"http://127.0.0.1:9090","hasBearerTokenConfigured":false,"httpTimeoutSec":10,"tlsCaFileConfigured":false,"httpLogStderr":false}},"isError":false}}
ADV-PASS invalid timeout falls back to 10

# L11 probe (FT540+, operator boundaries, variant 1)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"nene_mcp_about\",\n    \"packageName\": \"hideyukiMORI/nene-mcp\",\n    \"packageVersion\": \"0.1.8\",\n    \"phpVersion\": \"8.4.21\",\n    \"runtime\": {\n        \"catalogPath\": null,\n        \"apiBaseUrl\": \"http://127.0.0.1:9090\",\n        \"hasBearerTokenConfigured\": false,\n        \"httpTimeoutSec\": 120,\n        \"tlsCaFileConfigured\": false,\n        \"httpLogStderr\": false\n    }\n}"}],"structuredContent":{"tool":"nene_mcp_about","packageName":"hideyukiMORI/nene-mcp","packageVersion":"0.1.8","phpVersion":"8.4.21","runtime":{"catalogPath":null,"apiBaseUrl":"http://127.0.0.1:9090","hasBearerTokenConfigured":false,"httpTimeoutSec":120,"tlsCaFileConfigured":false,"httpLogStderr":false}},"isError":false}}
ADV-PASS timeout max=120 accepted

# L12 probe (FT570+, NENE2 alias compatibility, variant 1)
{"jsonrpc":"2.0","id":1,"result":{"tools":[{"name":"nene_mcp_about","title":"About nene-mcp","description":"Return package metadata and resolved environment (paths and base URLs only; no secrets).","inputSchema":{"type":"object","properties":{},"additionalProperties":false},"annotations":{"readOnlyHint":true}},{"name":"getHealthCheck","title":"Health Check","description":"GET /health/index (operationId healthCheck).","inputSchema":{"type":"object","properties":{},"additionalProperties":false},"annotations":{"readOnlyHint":true}},{"name":"listTodos","title":"List TODOs","description":"GET /todo/index (operationId listTodos). Requires session; expect 401 without auth.","inputSchema":{"type":"object","properties":{},"additionalProperties":false},"annotations":{"readOnlyHint":true}},{"name":"getHealthWrongId","title":"Wrong operationId probe","description":"Misaligned operationId on purpose (FT5 adversarial).","inputSchema":{"type":"object","properties":{},"additionalProperties":false},"annotations":{"readOnlyHint":true}}]}}
ADV-PASS NENE2_LOCAL_TOOLS_JSON catalog alias

# L13 probe (FT600+, HTTP diagnostics, variant 1)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"nene_mcp_about\",\n    \"packageName\": \"hideyukiMORI/nene-mcp\",\n    \"packageVersion\": \"0.1.8\",\n    \"phpVersion\": \"8.4.21\",\n    \"runtime\": {\n        \"catalogPath\": null,\n        \"apiBaseUrl\": \"http://127.0.0.1:9090\",\n        \"hasBearerTokenConfigured\": false,\n        \"httpTimeoutSec\": 10,\n        \"tlsCaFileConfigured\": false,\n        \"httpLogStderr\": false\n    }\n}"}],"structuredContent":{"tool":"nene_mcp_about","packageName":"hideyukiMORI/nene-mcp","packageVersion":"0.1.8","phpVersion":"8.4.21","runtime":{"catalogPath":null,"apiBaseUrl":"http://127.0.0.1:9090","hasBearerTokenConfigured":false,"httpTimeoutSec":10,"tlsCaFileConfigured":false,"httpLogStderr":false}},"isError":false}}
ADV-PASS float timeout falls back to 10

# L14 probe (FT630+, Bearer E2E regression, variant 1)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"createTodo\",\n    \"operationId\": \"createTodo\",\n    \"statusCode\": 200,\n    \"requestId\": \"1b1366f2f6a5f8bbdeb3541251e85fd6\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"todo\": {\n                \"id\": 151,\n                \"user_id\": 1,\n                \"title\": \"FT630 L14 write\",\n                \"is_completed\": false,\n                \"created_at\": \"2026-05-22 16:15:47\",\n                \"updated_at\": \"2026-05-22 16:15:47\"\n            }\n        }\n    }\n}"}],"structuredContent":{"tool":"createTodo","operationId":"createTodo","statusCode":200,"requestId":"1b1366f2f6a5f8bbdeb3541251e85fd6","body":{"Result":true,"Data":{"status":"success","errorCode":"","todo":{"id":151,"user_id":1,"title":"FT630 L14 write","is_completed":false,"created_at":"2026-05-22 16:15:47","updated_at":"2026-05-22 16:15:47"}}}},"isError":false}}
ADV-PASS Bearer createTodo without CSRF

# L15 probe (FT660+, Bearer+operator composite, variant 1)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"createTodo\",\n    \"operationId\": \"createTodo\",\n    \"statusCode\": 200,\n    \"requestId\": \"bb91da6ec6b1f21ce70dd64fe5f84bbc\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"todo\": {\n                \"id\": 152,\n                \"user_id\": 1,\n                \"title\": \"L15 roundtrip\",\n                \"is_completed\": false,\n                \"created_at\": \"2026-05-22 16:15:47\",\n                \"updated_at\": \"2026-05-22 16:15:47\"\n            }\n        }\n    }\n}"}],"structuredContent":{"tool":"createTodo","operationId":"createTodo","statusCode":200,"requestId":"bb91da6ec6b1f21ce70dd64fe5f84bbc","body":{"Result":true,"Data":{"status":"success","errorCode":"","todo":{"id":152,"user_id":1,"title":"L15 roundtrip","is_completed":false,"created_at":"2026-05-22 16:15:47","updated_at":"2026-05-22 16:15:47"}}}},"isError":false}}
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getTodoById\",\n    \"operationId\": \"getTodo\",\n    \"statusCode\": 200,\n    \"requestId\": \"8294ce5c2be9c4078758233786fa44d6\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"todo\": {\n                \"id\": 152,\n                \"user_id\": 1,\n                \"title\": \"L15 roundtrip\",\n                \"is_completed\": false,\n                \"created_at\": \"2026-05-22 16:15:47\",\n                \"updated_at\": \"2026-05-22 16:15:47\"\n            }\n        }\n    }\n}"}],"structuredContent":{"tool":"getTodoById","operationId":"getTodo","statusCode":200,"requestId":"8294ce5c2be9c4078758233786fa44d6","body":{"Result":true,"Data":{"status":"success","errorCode":"","todo":{"id":152,"user_id":1,"title":"L15 roundtrip","is_completed":false,"created_at":"2026-05-22 16:15:47","updated_at":"2026-05-22 16:15:47"}}}},"isError":false}}
ADV-PASS create/read round-trip id_152

# L16 probe (FT690+, NeNe observability, variant 1)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"createTodo\",\n    \"operationId\": \"createTodo\",\n    \"statusCode\": 400,\n    \"requestId\": \"32219322000e3453f968f08a02657e16\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"failure\",\n            \"errorCode\": \"TODO-TITLE-REQUIRED\",\n            \"errorMessage\": \"TODO title is required.\"\n        }\n    }\n}"}],"structuredContent":{"tool":"createTodo","operationId":"createTodo","statusCode":400,"requestId":"32219322000e3453f968f08a02657e16","body":{"Result":true,"Data":{"status":"failure","errorCode":"TODO-TITLE-REQUIRED","errorMessage":"TODO title is required."}}},"isError":true}}
ADV-PASS empty title rejected with 400

# L17 probe (FT720+, Bearer gate sustain, variant 1)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"listTodos\",\n    \"operationId\": \"listTodos\",\n    \"statusCode\": 401,\n    \"requestId\": \"06530420e6ec2cf1ead3e4cc767a4297\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"failure\",\n            \"errorCode\": \"SESSION-CLOSED\",\n            \"errorMessage\": \"Session timeout. Please log in again.\"\n        }\n    }\n}"}],"structuredContent":{"tool":"listTodos","operationId":"listTodos","statusCode":401,"requestId":"06530420e6ec2cf1ead3e4cc767a4297","body":{"Result":true,"Data":{"status":"failure","errorCode":"SESSION-CLOSED","errorMessage":"Session timeout. Please log in again."}}},"isError":true}}
ADV-PASS listTodos without Bearer returns 401

# L18 probe (FT750+, Bearer read-path hardening, variant 1)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"createTodo\",\n    \"operationId\": \"createTodo\",\n    \"statusCode\": 401,\n    \"requestId\": \"c109a8cd51cd0d1545e83fba5cc04a13\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"failure\",\n            \"errorCode\": \"SESSION-CLOSED\",\n            \"errorMessage\": \"Session timeout. Please log in again.\"\n        }\n    }\n}"}],"structuredContent":{"tool":"createTodo","operationId":"createTodo","statusCode":401,"requestId":"c109a8cd51cd0d1545e83fba5cc04a13","body":{"Result":true,"Data":{"status":"failure","errorCode":"SESSION-CLOSED","errorMessage":"Session timeout. Please log in again."}}},"isError":true}}
ADV-PASS createTodo invalid Bearer returns 401
```

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Automated suite | PASS lines, no FAIL | See log above | Pass |
| Security cadence (N % 3 == 0) | write-failclosed pass | N/A | N/A |

## Friction Summary

L18 + L17 … L6 adversarial exercised — Bearer read-path hardening band.

## Recommendations

None.

## Security Review (required when N % 3 == 0)

N/A — security review scheduled for FT753.

## Follow-up Issues

None.

## Overall Impression

Automated FT751 (Multi-tool read catalog + createTodo invalid Bearer (L18)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT752
