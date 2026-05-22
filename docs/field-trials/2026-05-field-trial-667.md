# Field Trial 667 — Fresh clone bootstrap + create/read round-trip (L15)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.8`
- Runner: `tools/ft-individual.sh 667`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Fresh clone bootstrap + create/read round-trip (L15)**.

## Steps Taken

### 1. Primary suite

```text
PASS about-only [{'name': 'nene_mcp_about', 'title': 'About nene-mcp', 'description': 'Return package metadata and resolved environment (paths and base URLs only; no secrets).', 'inputSchema': {'type': 'object', 'properties': {}, 'additionalProperties': False}, 'annotations': {'readOnlyHint': True}}]

# Adversarial probe (FT255+ L6, variant 3)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getTodoById\",\n    \"operationId\": \"getTodo\",\n    \"statusCode\": 404,\n    \"requestId\": null,\n    \"body\": \"<!DOCTYPE HTML PUBLIC \\\"-//W3C//DTD HTML 4.01//EN\\\" \\\"http://www.w3.org/TR/html4/strict.dtd\\\">\\n<html><head>\\n<title>404 Not Found</title>\\n</head><body>\\n<h1>Not Found</h1>\\n<p>The requested URL was not found on this server.</p>\\n</body></html>\\n\"\n}"}],"structuredContent":{"tool":"getTodoById","operationId":"getTodo","statusCode":404,"requestId":null,"body":"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">\n<html><head>\n<title>404 Not Found</title>\n</head><body>\n<h1>Not Found</h1>\n<p>The requested URL was not found on this server.</p>\n</body></html>\n"},"isError":true}}
ADV-PASS path param encoded (no local file read)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getTodoById\",\n    \"operationId\": \"getTodo\",\n    \"statusCode\": 401,\n    \"requestId\": \"e8c38233f0f1d2657b469f6455e76a65\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"failure\",\n            \"errorCode\": \"SESSION-CLOSED\",\n            \"errorMessage\": \"Session timeout. Please log in again.\"\n        }\n    }\n}"}],"structuredContent":{"tool":"getTodoById","operationId":"getTodo","statusCode":401,"requestId":"e8c38233f0f1d2657b469f6455e76a65","body":{"Result":true,"Data":{"status":"failure","errorCode":"SESSION-CLOSED","errorMessage":"Session timeout. Please log in again."}}},"isError":true}}
ADV-PASS traversal strings sent as literal id

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
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"createTodo\",\n    \"operationId\": \"createTodo\",\n    \"statusCode\": 200,\n    \"requestId\": \"d30cebe2db94551e3270eddef9202f8e\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"todo\": {\n                \"id\": 68,\n                \"user_id\": 1,\n                \"title\": \"FT630 L14 write\",\n                \"is_completed\": false,\n                \"created_at\": \"2026-05-22 15:58:35\",\n                \"updated_at\": \"2026-05-22 15:58:35\"\n            }\n        }\n    }\n}"}],"structuredContent":{"tool":"createTodo","operationId":"createTodo","statusCode":200,"requestId":"d30cebe2db94551e3270eddef9202f8e","body":{"Result":true,"Data":{"status":"success","errorCode":"","todo":{"id":68,"user_id":1,"title":"FT630 L14 write","is_completed":false,"created_at":"2026-05-22 15:58:35","updated_at":"2026-05-22 15:58:35"}}}},"isError":false}}
ADV-PASS Bearer createTodo without CSRF

# L15 probe (FT660+, Bearer+operator composite, variant 1)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"createTodo\",\n    \"operationId\": \"createTodo\",\n    \"statusCode\": 200,\n    \"requestId\": \"569843f2b6c06a872c176c7174f9366d\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"todo\": {\n                \"id\": 69,\n                \"user_id\": 1,\n                \"title\": \"L15 roundtrip\",\n                \"is_completed\": false,\n                \"created_at\": \"2026-05-22 15:58:35\",\n                \"updated_at\": \"2026-05-22 15:58:35\"\n            }\n        }\n    }\n}"}],"structuredContent":{"tool":"createTodo","operationId":"createTodo","statusCode":200,"requestId":"569843f2b6c06a872c176c7174f9366d","body":{"Result":true,"Data":{"status":"success","errorCode":"","todo":{"id":69,"user_id":1,"title":"L15 roundtrip","is_completed":false,"created_at":"2026-05-22 15:58:35","updated_at":"2026-05-22 15:58:35"}}}},"isError":false}}
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getTodoById\",\n    \"operationId\": \"getTodo\",\n    \"statusCode\": 200,\n    \"requestId\": \"9aa542eccc7593fd547fd1edd5fa978b\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"todo\": {\n                \"id\": 69,\n                \"user_id\": 1,\n                \"title\": \"L15 roundtrip\",\n                \"is_completed\": false,\n                \"created_at\": \"2026-05-22 15:58:35\",\n                \"updated_at\": \"2026-05-22 15:58:35\"\n            }\n        }\n    }\n}"}],"structuredContent":{"tool":"getTodoById","operationId":"getTodo","statusCode":200,"requestId":"9aa542eccc7593fd547fd1edd5fa978b","body":{"Result":true,"Data":{"status":"success","errorCode":"","todo":{"id":69,"user_id":1,"title":"L15 roundtrip","is_completed":false,"created_at":"2026-05-22 15:58:35","updated_at":"2026-05-22 15:58:35"}}}},"isError":false}}
ADV-PASS create/read round-trip id_69
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

N/A — security review scheduled for FT669.

## Follow-up Issues

None.

## Overall Impression

Automated FT667 (Fresh clone bootstrap + create/read round-trip (L15)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT668
