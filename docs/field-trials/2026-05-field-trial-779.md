# Field Trial 779 — Security review — catalog probes + NENE2 catalog + getTodoById (L18)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.8`
- Runner: `tools/ft-individual.sh 779`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Security review — catalog probes + NENE2 catalog + getTodoById (L18)**.

## Steps Taken

### 1. Primary suite

```text
# FT security catalog probes
PASS duplicate names rejected
PASS invalid JSON rejected
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"bad\",\n    \"operationId\": \"x\",\n    \"statusCode\": 400,\n    \"requestId\": null,\n    \"body\": \"<!DOCTYP

# Adversarial probe (FT255+ L6, variant 3)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getTodoById\",\n    \"operationId\": \"getTodo\",\n    \"statusCode\": 404,\n    \"requestId\": null,\n    \"body\": \"<!DOCTYPE HTML PUBLIC \\\"-//W3C//DTD HTML 4.01//EN\\\" \\\"http://www.w3.org/TR/html4/strict.dtd\\\">\\n<html><head>\\n<title>404 Not Found</title>\\n</head><body>\\n<h1>Not Found</h1>\\n<p>The requested URL was not found on this server.</p>\\n</body></html>\\n\"\n}"}],"structuredContent":{"tool":"getTodoById","operationId":"getTodo","statusCode":404,"requestId":null,"body":"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">\n<html><head>\n<title>404 Not Found</title>\n</head><body>\n<h1>Not Found</h1>\n<p>The requested URL was not found on this server.</p>\n</body></html>\n"},"isError":true}}
ADV-PASS path param encoded (no local file read)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getTodoById\",\n    \"operationId\": \"getTodo\",\n    \"statusCode\": 401,\n    \"requestId\": \"a6777345e066d1b18f914592a6efc26b\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"failure\",\n            \"errorCode\": \"SESSION-CLOSED\",\n            \"errorMessage\": \"Session timeout. Please log in again.\"\n        }\n    }\n}"}],"structuredContent":{"tool":"getTodoById","operationId":"getTodo","statusCode":401,"requestId":"a6777345e066d1b18f914592a6efc26b","body":{"Result":true,"Data":{"status":"failure","errorCode":"SESSION-CLOSED","errorMessage":"Session timeout. Please log in again."}}},"isError":true}}
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
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"listTodos\",\n    \"operationId\": \"listTodos\",\n    \"statusCode\": 401,\n    \"requestId\": \"361adfbeb104295d01247bd6aed2fd8d\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"failure\",\n            \"errorCode\": \"SESSION-CLOSED\",\n            \"errorMessage\": \"Session timeout. Please log in again.\"\n        }\n    }\n}"}],"structuredContent":{"tool":"listTodos","operationId":"listTodos","statusCode":401,"requestId":"361adfbeb104295d01247bd6aed2fd8d","body":{"Result":true,"Data":{"status":"failure","errorCode":"SESSION-CLOSED","errorMessage":"Session timeout. Please log in again."}}},"isError":true}}
ADV-PASS invalid Bearer returns 401

# L15 probe (FT660+, Bearer+operator composite, variant 5)
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"Write tool \"sessionLogin\" requires bearer authentication. Set NENE_MCP_BEARER_TOKEN in the MCP server environment."}}
ADV-PASS sessionLogin write fail-closed without Bearer

# L16 probe (FT690+, NeNe observability, variant 5)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"createTodo\",\n    \"operationId\": \"createTodo\",\n    \"statusCode\": 200,\n    \"requestId\": \"3ff7ec7a6f28509a49ca8334ab4164a3\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"todo\": {\n                \"id\": 183,\n                \"user_id\": 1,\n                \"title\": \"L16xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\",\n                \"is_completed\": false,\n                \"created_at\": \"2026-05-22 16:16:26\",\n                \"updated_at\": \"2026-05-22 16:16:26\"\n            }\n        }\n    }\n}"}],"structuredContent":{"tool":"createTodo","operationId":"createTodo","statusCode":200,"requestId":"3ff7ec7a6f28509a49ca8334ab4164a3","body":{"Result":true,"Data":{"status":"success","errorCode":"","todo":{"id":183,"user_id":1,"title":"L16xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx","is_completed":false,"created_at":"2026-05-22 16:16:26","updated_at":"2026-05-22 16:16:26"}}}},"isError":false}}
ADV-PASS long title (200 chars) accepted

# L17 probe (FT720+, Bearer gate sustain, variant 5)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"createTodo\",\n    \"operationId\": \"createTodo\",\n    \"statusCode\": 200,\n    \"requestId\": \"b2120da92f382ad7e588745236d56ed4\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"todo\": {\n                \"id\": 184,\n                \"user_id\": 1,\n                \"title\": \"L17 requestId write\",\n                \"is_completed\": false,\n                \"created_at\": \"2026-05-22 16:16:26\",\n                \"updated_at\": \"2026-05-22 16:16:26\"\n            }\n        }\n    }\n}"}],"structuredContent":{"tool":"createTodo","operationId":"createTodo","statusCode":200,"requestId":"b2120da92f382ad7e588745236d56ed4","body":{"Result":true,"Data":{"status":"success","errorCode":"","todo":{"id":184,"user_id":1,"title":"L17 requestId write","is_completed":false,"created_at":"2026-05-22 16:16:26","updated_at":"2026-05-22 16:16:26"}}}},"isError":false}}
ADV-PASS requestId present on Bearer write

# L18 probe (FT750+, Bearer read-path hardening, variant 5)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getTodoById\",\n    \"operationId\": \"getTodo\",\n    \"statusCode\": 200,\n    \"requestId\": \"15fe6fca15fc574bf42c38c3502fd1c3\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"todo\": {\n                \"id\": 1,\n                \"user_id\": 1,\n                \"title\": \"Read the routing guide\",\n                \"is_completed\": true,\n                \"created_at\": \"2026-05-08 07:18:24\",\n                \"updated_at\": \"2026-05-08 07:18:24\"\n            }\n        }\n    }\n}"}],"structuredContent":{"tool":"getTodoById","operationId":"getTodo","statusCode":200,"requestId":"15fe6fca15fc574bf42c38c3502fd1c3","body":{"Result":true,"Data":{"status":"success","errorCode":"","todo":{"id":1,"user_id":1,"title":"Read the routing guide","is_completed":true,"created_at":"2026-05-08 07:18:24","updated_at":"2026-05-08 07:18:24"}}}},"isError":false}}
ADV-PASS NENE2 catalog alias + Bearer getTodoById
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

N/A — security review scheduled for FT780.

## Follow-up Issues

None.

## Overall Impression

Automated FT779 (Security review — catalog probes + NENE2 catalog + getTodoById (L18)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT780
