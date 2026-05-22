# Field Trial 707 — Fresh clone bootstrap + long title write (L16)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.8`
- Runner: `tools/ft-individual.sh 707`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Fresh clone bootstrap + long title write (L16)**.

## Steps Taken

### 1. Primary suite

```text
PASS about-only [{'name': 'nene_mcp_about', 'title': 'About nene-mcp', 'description': 'Return package metadata and resolved environment (paths and base URLs only; no secrets).', 'inputSchema': {'type': 'object', 'properties': {}, 'additionalProperties': False}, 'annotations': {'readOnlyHint': True}}]

# Adversarial probe (FT255+ L6, variant 3)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getTodoById\",\n    \"operationId\": \"getTodo\",\n    \"statusCode\": 404,\n    \"requestId\": null,\n    \"body\": \"<!DOCTYPE HTML PUBLIC \\\"-//W3C//DTD HTML 4.01//EN\\\" \\\"http://www.w3.org/TR/html4/strict.dtd\\\">\\n<html><head>\\n<title>404 Not Found</title>\\n</head><body>\\n<h1>Not Found</h1>\\n<p>The requested URL was not found on this server.</p>\\n</body></html>\\n\"\n}"}],"structuredContent":{"tool":"getTodoById","operationId":"getTodo","statusCode":404,"requestId":null,"body":"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">\n<html><head>\n<title>404 Not Found</title>\n</head><body>\n<h1>Not Found</h1>\n<p>The requested URL was not found on this server.</p>\n</body></html>\n"},"isError":true}}
ADV-PASS path param encoded (no local file read)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getTodoById\",\n    \"operationId\": \"getTodo\",\n    \"statusCode\": 401,\n    \"requestId\": \"9ec1bb1133bfa9b7556fc9b61fa5c49c\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"failure\",\n            \"errorCode\": \"SESSION-CLOSED\",\n            \"errorMessage\": \"Session timeout. Please log in again.\"\n        }\n    }\n}"}],"structuredContent":{"tool":"getTodoById","operationId":"getTodo","statusCode":401,"requestId":"9ec1bb1133bfa9b7556fc9b61fa5c49c","body":{"Result":true,"Data":{"status":"failure","errorCode":"SESSION-CLOSED","errorMessage":"Session timeout. Please log in again."}}},"isError":true}}
ADV-PASS traversal strings sent as literal id

# L7 probe (FT420+, variant 5)
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"Write tool \"w2\" requires bearer authentication. Set NENE_MCP_BEARER_TOKEN in the MCP server environment."}}
ADV-PASS empty-string Bearer rejected (#64)

# L8 probe (FT451+, variant 5)
{"jsonrpc":"2.0","id":1,"result":{"tools":[{"name":"nene_mcp_about","title":"About nene-mcp","description":"Return package metadata and resolved environment (paths and base URLs only; no secrets).","inputSchema":{"type":"object","properties":{},"additionalProperties":false},"annotations":{"readOnlyHint":true}},{"name":"getHealth","title":"Health","description":"only health deployed","inputSchema":{"type":"object","properties":{},"additionalProperties":false},"annotations":{"readOnlyHint":true}}]}}
WARN jsonrpc 1.0 response logged

# L9 probe (FT480+, variant 5)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getHealth\",\n    \"operationId\": \"health\",\n    \"statusCode\": 200,\n    \"requestId\": null,\n    \"body\": {\n        \"status\": \"ok\"\n    }\n}"}],"structuredContent":{"tool":"getHealth","operationId":"health","statusCode":200,"requestId":null,"body":{"status":"ok"}},"isError":false}}
ADV-PASS null arguments handled without crash

# L10 probe (FT510+, v0.1.8 SMB, variant 5)
Package baseline: 0.1.8
ADV-PASS v0.1.8 SMB baseline pinned
WARN Packagist 0.1.8 not visible yet

# L11 probe (FT540+, operator boundaries, variant 5)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"nene_mcp_about\",\n    \"packageName\": \"hideyukiMORI/nene-mcp\",\n    \"packageVersion\": \"0.1.8\",\n    \"phpVersion\": \"8.4.21\",\n    \"runtime\": {\n        \"catalogPath\": null,\n        \"apiBaseUrl\": \"http://127.0.0.1:9090\",\n        \"hasBearerTokenConfigured\": false,\n        \"httpTimeoutSec\": 60,\n        \"tlsCaFileConfigured\": false,\n        \"httpLogStderr\": true\n    }\n}"}],"structuredContent":{"tool":"nene_mcp_about","packageName":"hideyukiMORI/nene-mcp","packageVersion":"0.1.8","phpVersion":"8.4.21","runtime":{"catalogPath":null,"apiBaseUrl":"http://127.0.0.1:9090","hasBearerTokenConfigured":false,"httpTimeoutSec":60,"tlsCaFileConfigured":false,"httpLogStderr":true}},"isError":false}}
ADV-PASS combined timeout+stderr flags in runtime

# L12 probe (FT570+, NENE2 alias compatibility, variant 5)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"nene_mcp_about\",\n    \"packageName\": \"hideyukiMORI/nene-mcp\",\n    \"packageVersion\": \"0.1.8\",\n    \"phpVersion\": \"8.4.21\",\n    \"runtime\": {\n        \"catalogPath\": null,\n        \"apiBaseUrl\": \"http://127.0.0.1:9090\",\n        \"hasBearerTokenConfigured\": true,\n        \"httpTimeoutSec\": 15,\n        \"tlsCaFileConfigured\": false,\n        \"httpLogStderr\": false\n    }\n}"}],"structuredContent":{"tool":"nene_mcp_about","packageName":"hideyukiMORI/nene-mcp","packageVersion":"0.1.8","phpVersion":"8.4.21","runtime":{"catalogPath":null,"apiBaseUrl":"http://127.0.0.1:9090","hasBearerTokenConfigured":true,"httpTimeoutSec":15,"tlsCaFileConfigured":false,"httpLogStderr":false}},"isError":false}}
ADV-PASS bearer trim + operator flags; no secret leak

# L13 probe (FT600+, HTTP diagnostics, variant 5)
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"TLS CA bundle \"/nonexistent/ft-l13-ca.pem\" is not readable. Set NENE_MCP_TLS_CA_FILE to a valid PEM file or unset it."}}
ADV-PASS unreadable TLS CA fails before HTTPS request

# L14 probe (FT630+, Bearer E2E regression, variant 5)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"listTodos\",\n    \"operationId\": \"listTodos\",\n    \"statusCode\": 401,\n    \"requestId\": \"0cfe0fcd2dd09eae94793110635b0829\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"failure\",\n            \"errorCode\": \"SESSION-CLOSED\",\n            \"errorMessage\": \"Session timeout. Please log in again.\"\n        }\n    }\n}"}],"structuredContent":{"tool":"listTodos","operationId":"listTodos","statusCode":401,"requestId":"0cfe0fcd2dd09eae94793110635b0829","body":{"Result":true,"Data":{"status":"failure","errorCode":"SESSION-CLOSED","errorMessage":"Session timeout. Please log in again."}}},"isError":true}}
ADV-PASS invalid Bearer returns 401

# L15 probe (FT660+, Bearer+operator composite, variant 5)
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"Write tool \"sessionLogin\" requires bearer authentication. Set NENE_MCP_BEARER_TOKEN in the MCP server environment."}}
ADV-PASS sessionLogin write fail-closed without Bearer

# L16 probe (FT690+, NeNe observability, variant 5)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"createTodo\",\n    \"operationId\": \"createTodo\",\n    \"statusCode\": 200,\n    \"requestId\": \"cdae33aa9ca5f3d20b2b1abdfaed95e5\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"todo\": {\n                \"id\": 102,\n                \"user_id\": 1,\n                \"title\": \"L16xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\",\n                \"is_completed\": false,\n                \"created_at\": \"2026-05-22 16:03:13\",\n                \"updated_at\": \"2026-05-22 16:03:13\"\n            }\n        }\n    }\n}"}],"structuredContent":{"tool":"createTodo","operationId":"createTodo","statusCode":200,"requestId":"cdae33aa9ca5f3d20b2b1abdfaed95e5","body":{"Result":true,"Data":{"status":"success","errorCode":"","todo":{"id":102,"user_id":1,"title":"L16xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx","is_completed":false,"created_at":"2026-05-22 16:03:13","updated_at":"2026-05-22 16:03:13"}}}},"isError":false}}
ADV-PASS long title (200 chars) accepted
```

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Automated suite | PASS lines, no FAIL | See log above | Pass |
| Security cadence (N % 3 == 0) | write-failclosed pass | N/A | N/A |

## Friction Summary

L16 + L15 … L6 adversarial exercised — NeNe observability and Bearer edge cases.

## Recommendations

None.

## Security Review (required when N % 3 == 0)

N/A — security review scheduled for FT708.

## Follow-up Issues

None.

## Overall Impression

Automated FT707 (Fresh clone bootstrap + long title write (L16)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT708
