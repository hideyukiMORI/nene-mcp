# Field Trial 757 — Fresh clone bootstrap + createTodo invalid Bearer (L18)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.8`
- Runner: `tools/ft-individual.sh 757`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Fresh clone bootstrap + createTodo invalid Bearer (L18)**.

## Steps Taken

### 1. Primary suite

```text
PASS about-only [{'name': 'nene_mcp_about', 'title': 'About nene-mcp', 'description': 'Return package metadata and resolved environment (paths and base URLs only; no secrets).', 'inputSchema': {'type': 'object', 'properties': {}, 'additionalProperties': False}, 'annotations': {'readOnlyHint': True}}]

# Adversarial probe (FT255+ L6, variant 5)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"sessionLogin\",\n    \"operationId\": \"login\",\n    \"statusCode\": 401,\n    \"requestId\": \"6a770b6765b882f0cfd95e03b000222a\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"failure\",\n            \"errorCode\": \"LOGIN-FAILED\",\n            \"errorMessage\": \"Wrong user ID or user PASS\"\n        }\n    }\n}"}],"structuredContent":{"tool":"sessionLogin","operationId":"login","statusCode":401,"requestId":"6a770b6765b882f0cfd95e03b000222a","body":{"Result":true,"Data":{"status":"failure","errorCode":"LOGIN-FAILED","errorMessage":"Wrong user ID or user PASS"}}},"isError":true}}
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"createTodo\",\n    \"operationId\": \"createTodo\",\n    \"statusCode\": 401,\n    \"requestId\": \"afcb3b7146a8fdbeba9eb9d053ee470e\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"failure\",\n            \"errorCode\": \"SESSION-CLOSED\",\n            \"errorMessage\": \"Session timeout. Please log in again.\"\n        }\n    }\n}"}],"structuredContent":{"tool":"createTodo","operationId":"createTodo","statusCode":401,"requestId":"afcb3b7146a8fdbeba9eb9d053ee470e","body":{"Result":true,"Data":{"status":"failure","errorCode":"SESSION-CLOSED","errorMessage":"Session timeout. Please log in again."}}},"isError":true}}
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
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"createTodo\",\n    \"operationId\": \"createTodo\",\n    \"statusCode\": 200,\n    \"requestId\": \"b8fbdc483040d345b89729d60cfaf47d\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"todo\": {\n                \"id\": 158,\n                \"user_id\": 1,\n                \"title\": \"FT630 L14 write\",\n                \"is_completed\": false,\n                \"created_at\": \"2026-05-22 16:15:55\",\n                \"updated_at\": \"2026-05-22 16:15:55\"\n            }\n        }\n    }\n}"}],"structuredContent":{"tool":"createTodo","operationId":"createTodo","statusCode":200,"requestId":"b8fbdc483040d345b89729d60cfaf47d","body":{"Result":true,"Data":{"status":"success","errorCode":"","todo":{"id":158,"user_id":1,"title":"FT630 L14 write","is_completed":false,"created_at":"2026-05-22 16:15:55","updated_at":"2026-05-22 16:15:55"}}}},"isError":false}}
ADV-PASS Bearer createTodo without CSRF

# L15 probe (FT660+, Bearer+operator composite, variant 1)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"createTodo\",\n    \"operationId\": \"createTodo\",\n    \"statusCode\": 200,\n    \"requestId\": \"c5d9c183866da26f58587095011e16a0\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"todo\": {\n                \"id\": 159,\n                \"user_id\": 1,\n                \"title\": \"L15 roundtrip\",\n                \"is_completed\": false,\n                \"created_at\": \"2026-05-22 16:15:55\",\n                \"updated_at\": \"2026-05-22 16:15:55\"\n            }\n        }\n    }\n}"}],"structuredContent":{"tool":"createTodo","operationId":"createTodo","statusCode":200,"requestId":"c5d9c183866da26f58587095011e16a0","body":{"Result":true,"Data":{"status":"success","errorCode":"","todo":{"id":159,"user_id":1,"title":"L15 roundtrip","is_completed":false,"created_at":"2026-05-22 16:15:55","updated_at":"2026-05-22 16:15:55"}}}},"isError":false}}
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getTodoById\",\n    \"operationId\": \"getTodo\",\n    \"statusCode\": 200,\n    \"requestId\": \"169d0317da7071844bb0caf88108f201\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"todo\": {\n                \"id\": 159,\n                \"user_id\": 1,\n                \"title\": \"L15 roundtrip\",\n                \"is_completed\": false,\n                \"created_at\": \"2026-05-22 16:15:55\",\n                \"updated_at\": \"2026-05-22 16:15:55\"\n            }\n        }\n    }\n}"}],"structuredContent":{"tool":"getTodoById","operationId":"getTodo","statusCode":200,"requestId":"169d0317da7071844bb0caf88108f201","body":{"Result":true,"Data":{"status":"success","errorCode":"","todo":{"id":159,"user_id":1,"title":"L15 roundtrip","is_completed":false,"created_at":"2026-05-22 16:15:55","updated_at":"2026-05-22 16:15:55"}}}},"isError":false}}
ADV-PASS create/read round-trip id_159

# L16 probe (FT690+, NeNe observability, variant 1)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"createTodo\",\n    \"operationId\": \"createTodo\",\n    \"statusCode\": 400,\n    \"requestId\": \"d7f8e1e771f04483963f4a5e1137e537\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"failure\",\n            \"errorCode\": \"TODO-TITLE-REQUIRED\",\n            \"errorMessage\": \"TODO title is required.\"\n        }\n    }\n}"}],"structuredContent":{"tool":"createTodo","operationId":"createTodo","statusCode":400,"requestId":"d7f8e1e771f04483963f4a5e1137e537","body":{"Result":true,"Data":{"status":"failure","errorCode":"TODO-TITLE-REQUIRED","errorMessage":"TODO title is required."}}},"isError":true}}
ADV-PASS empty title rejected with 400

# L17 probe (FT720+, Bearer gate sustain, variant 1)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"listTodos\",\n    \"operationId\": \"listTodos\",\n    \"statusCode\": 401,\n    \"requestId\": \"1c692651487ddfc0d47a29a37d591292\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"failure\",\n            \"errorCode\": \"SESSION-CLOSED\",\n            \"errorMessage\": \"Session timeout. Please log in again.\"\n        }\n    }\n}"}],"structuredContent":{"tool":"listTodos","operationId":"listTodos","statusCode":401,"requestId":"1c692651487ddfc0d47a29a37d591292","body":{"Result":true,"Data":{"status":"failure","errorCode":"SESSION-CLOSED","errorMessage":"Session timeout. Please log in again."}}},"isError":true}}
ADV-PASS listTodos without Bearer returns 401

# L18 probe (FT750+, Bearer read-path hardening, variant 1)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"createTodo\",\n    \"operationId\": \"createTodo\",\n    \"statusCode\": 401,\n    \"requestId\": \"1ebdf39047acb727ce048b4aae045622\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"failure\",\n            \"errorCode\": \"SESSION-CLOSED\",\n            \"errorMessage\": \"Session timeout. Please log in again.\"\n        }\n    }\n}"}],"structuredContent":{"tool":"createTodo","operationId":"createTodo","statusCode":401,"requestId":"1ebdf39047acb727ce048b4aae045622","body":{"Result":true,"Data":{"status":"failure","errorCode":"SESSION-CLOSED","errorMessage":"Session timeout. Please log in again."}}},"isError":true}}
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

N/A — security review scheduled for FT759.

## Follow-up Issues

None.

## Overall Impression

Automated FT757 (Fresh clone bootstrap + createTodo invalid Bearer (L18)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT758
