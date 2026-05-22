# Field Trial 660 — Packagist install regression + unicode Bearer write (L15)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.8`
- Runner: `tools/ft-individual.sh 660`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Packagist install regression + unicode Bearer write (L15)**.

## Steps Taken

### 1. Primary suite

```text
PASS about-only [{'name': 'nene_mcp_about', 'title': 'About nene-mcp', 'description': 'Return package metadata and resolved environment (paths and base URLs only; no secrets).', 'inputSchema': {'type': 'object', 'properties': {}, 'additionalProperties': False}, 'annotations': {'readOnlyHint': True}}]

# Adversarial probe (FT255+ L6, variant 4)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"nene_mcp_about\",\n    \"packageName\": \"hideyukiMORI/nene-mcp\",\n    \"packageVersion\": \"0.1.8\",\n    \"phpVersion\": \"8.4.21\",\n    \"runtime\": {\n        \"catalogPath\": \"/home/xi/docker/nene-mcp-FT/ft206-persona-bearer-native/docs/mcp/tools.json\",\n        \"apiBaseUrl\": \"http://127.0.0.1:9090\",\n        \"hasBearerTokenConfigured\": true,\n        \"httpTimeoutSec\": 10,\n        \"tlsCaFileConfigured\": false,\n        \"httpLogStderr\": false\n    }\n}"}],"structuredContent":{"tool":"nene_mcp_about","packageName":"hideyukiMORI/nene-mcp","packageVersion":"0.1.8","phpVersion":"8.4.21","runtime":{"catalogPath":"/home/xi/docker/nene-mcp-FT/ft206-persona-bearer-native/docs/mcp/tools.json","apiBaseUrl":"http://127.0.0.1:9090","hasBearerTokenConfigured":true,"httpTimeoutSec":10,"tlsCaFileConfigured":false,"httpLogStderr":false}},"isError":false}}
ADV-PASS about omits bearer value
ADV-PASS HTTP response does not echo env token

# L7 probe (FT420+, variant 0)
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"Write tool \"w\" requires bearer authentication. Set NENE_MCP_BEARER_TOKEN in the MCP server environment."}}
ADV-PASS typo env var ignored; fail-closed holds

# L8 probe (FT451+, variant 0)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"w\",\n    \"operationId\": \"x\",\n    \"statusCode\": 400,\n    \"requestId\": null,\n    \"body\": \"<!DOCTYPE HTML PUBLIC \\\"-//W3C//DTD HTML 4.01//EN\\\" \\\"http://www.w3.org/TR/html4/strict.dtd\\\">\\n<html><head>\\n<title>400 Bad Request</title>\\n</head><body>\\n<h1>Bad Request</h1>\\n<p>Your browser sent a request that this server could not understand.<br />\\n</p>\\n</body></html>\\n\"\n}"}],"structuredContent":{"tool":"w","operationId":"x","statusCode":400,"requestId":null,"body":"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">\n<html><head>\n<title>400 Bad Request</title>\n</head><body>\n<h1>Bad Request</h1>\n<p>Your browser sent a request that this server could not understand.<br />\n</p>\n</body></html>\n"},"isError":true}}
ADV-PASS newline bearer did not bypass write gate

# L9 probe (FT480+, variant 0)
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"Each MCP catalog tool must define source and inputSchema objects."}}
ADV-PASS missing inputSchema rejected

# L10 probe (FT510+, v0.1.8 SMB, variant 0)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"nene_mcp_about\",\n    \"packageName\": \"hideyukiMORI/nene-mcp\",\n    \"packageVersion\": \"0.1.8\",\n    \"phpVersion\": \"8.4.21\",\n    \"runtime\": {\n        \"catalogPath\": null,\n        \"apiBaseUrl\": \"http://127.0.0.1:9090\",\n        \"hasBearerTokenConfigured\": false,\n        \"httpTimeoutSec\": 30,\n        \"tlsCaFileConfigured\": false,\n        \"httpLogStderr\": false\n    }\n}"}],"structuredContent":{"tool":"nene_mcp_about","packageName":"hideyukiMORI/nene-mcp","packageVersion":"0.1.8","phpVersion":"8.4.21","runtime":{"catalogPath":null,"apiBaseUrl":"http://127.0.0.1:9090","hasBearerTokenConfigured":false,"httpTimeoutSec":30,"tlsCaFileConfigured":false,"httpLogStderr":false}},"isError":false}}
ADV-PASS HTTP timeout env=30 in runtime

# L11 probe (FT540+, operator boundaries, variant 0)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"nene_mcp_about\",\n    \"packageName\": \"hideyukiMORI/nene-mcp\",\n    \"packageVersion\": \"0.1.8\",\n    \"phpVersion\": \"8.4.21\",\n    \"runtime\": {\n        \"catalogPath\": null,\n        \"apiBaseUrl\": \"http://127.0.0.1:9090\",\n        \"hasBearerTokenConfigured\": false,\n        \"httpTimeoutSec\": 1,\n        \"tlsCaFileConfigured\": false,\n        \"httpLogStderr\": false\n    }\n}"}],"structuredContent":{"tool":"nene_mcp_about","packageName":"hideyukiMORI/nene-mcp","packageVersion":"0.1.8","phpVersion":"8.4.21","runtime":{"catalogPath":null,"apiBaseUrl":"http://127.0.0.1:9090","hasBearerTokenConfigured":false,"httpTimeoutSec":1,"tlsCaFileConfigured":false,"httpLogStderr":false}},"isError":false}}
ADV-PASS timeout min=1 accepted

# L12 probe (FT570+, NENE2 alias compatibility, variant 0)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"nene_mcp_about\",\n    \"packageName\": \"hideyukiMORI/nene-mcp\",\n    \"packageVersion\": \"0.1.8\",\n    \"phpVersion\": \"8.4.21\",\n    \"runtime\": {\n        \"catalogPath\": null,\n        \"apiBaseUrl\": \"http://127.0.0.1:9090\",\n        \"hasBearerTokenConfigured\": false,\n        \"httpTimeoutSec\": 10,\n        \"tlsCaFileConfigured\": false,\n        \"httpLogStderr\": false\n    }\n}"}],"structuredContent":{"tool":"nene_mcp_about","packageName":"hideyukiMORI/nene-mcp","packageVersion":"0.1.8","phpVersion":"8.4.21","runtime":{"catalogPath":null,"apiBaseUrl":"http://127.0.0.1:9090","hasBearerTokenConfigured":false,"httpTimeoutSec":10,"tlsCaFileConfigured":false,"httpLogStderr":false}},"isError":false}}
ADV-PASS NENE2_LOCAL_API_BASE_URL alias

# L13 probe (FT600+, HTTP diagnostics, variant 0)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getHealthCheck\",\n    \"operationId\": \"healthCheck\",\n    \"statusCode\": 404,\n    \"requestId\": null,\n    \"body\": {\n        \"error\": \"not_found\"\n    }\n}"}],"structuredContent":{"tool":"getHealthCheck","operationId":"healthCheck","statusCode":404,"requestId":null,"body":{"error":"not_found"}},"isError":true}}
--- stderr ---
[nene-mcp] GET /health/index status=404 duration_ms=0
ADV-PASS stderr HTTP log line; no secret in stderr

# L14 probe (FT630+, Bearer E2E regression, variant 0)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"listTodos\",\n    \"operationId\": \"listTodos\",\n    \"statusCode\": 200,\n    \"requestId\": \"8e39ae56ab8ac8a7f0481e4004d07a50\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"todos\": [\n                {\n                    \"id\": 1,\n                    \"user_id\": 1,\n                    \"title\": \"Read the routing guide\",\n                    \"is_completed\": true,\n                    \"created_at\": \"2026-05-08 07:18:24\",\n                    \"updated_at\": \"2026-05-08 07:18:24\"\n                },\n                {\n                    \"id\": 2,\n                    \"user_id\": 1,\n                    \"title\": \"Create a controller action\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-08 07:18:24\",\n                    \"updated_at\": \"2026-05-08 07:18:24\"\n                },\n                {\n                    \"id\": 4,\n                    \"user_id\": 1,\n                    \"title\": \"\\uff11\\uff12\\uff13\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-08 07:31:42\",\n                    \"updated_at\": \"2026-05-08 07:31:42\"\n                },\n                {\n                    \"id\": 5,\n                    \"user_id\": 1,\n                    \"title\": \"\\uff11\\uff12\\uff13\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-08 07:31:45\",\n                    \"updated_at\": \"2026-05-08 07:31:45\"\n                },\n                {\n                    \"id\": 51,\n                    \"user_id\": 1,\n                    \"title\": \"FT450 confirm\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:44:26\",\n                    \"updated_at\": \"2026-05-22 15:44:26\"\n                },\n                {\n                    \"id\": 52,\n                    \"user_id\": 1,\n                    \"title\": \"FT450 confirm\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:44:51\",\n                    \"updated_at\": \"2026-05-22 15:44:51\"\n                },\n                {\n                    \"id\": 53,\n                    \"user_id\": 1,\n                    \"title\": \"FT630 L14 write\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:50:47\",\n                    \"updated_at\": \"2026-05-22 15:50:47\"\n                },\n                {\n                    \"id\": 54,\n                    \"user_id\": 1,\n                    \"title\": \"FT630 L14 write\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:50:54\",\n                    \"updated_at\": \"2026-05-22 15:50:54\"\n                },\n                {\n                    \"id\": 55,\n                    \"user_id\": 1,\n                    \"title\": \"FT630 L14 write\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:51:02\",\n                    \"updated_at\": \"2026-05-22 15:51:02\"\n                },\n                {\n                    \"id\": 56,\n                    \"user_id\": 1,\n                    \"title\": \"FT630 L14 write\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:51:09\",\n                    \"updated_at\": \"2026-05-22 15:51:09\"\n                },\n                {\n                    \"id\": 57,\n                    \"user_id\": 1,\n                    \"title\": \"FT630 L14 write\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:51:17\",\n                    \"updated_at\": \"2026-05-22 15:51:17\"\n                },\n                {\n                    \"id\": 58,\n                    \"user_id\": 1,\n                    \"title\": \"L15 unicode \\u30c6\\u30b9\\u30c8\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:58:05\",\n                    \"updated_at\": \"2026-05-22 15:58:05\"\n                },\n                {\n                    \"id\": 59,\n                    \"user_id\": 1,\n                    \"title\": \"FT630 L14 write\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:58:05\",\n                    \"updated_at\": \"2026-05-22 15:58:05\"\n                },\n                {\n                    \"id\": 60,\n                    \"user_id\": 1,\n                    \"title\": \"L15 roundtrip\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:58:05\",\n                    \"updated_at\": \"2026-05-22 15:58:05\"\n                },\n                {\n                    \"id\": 61,\n                    \"user_id\": 1,\n                    \"title\": \"FT630 L14 write\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:58:18\",\n                    \"updated_at\": \"2026-05-22 15:58:18\"\n                },\n                {\n                    \"id\": 62,\n                    \"user_id\": 1,\n                    \"title\": \"L15 roundtrip\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:58:18\",\n                    \"updated_at\": \"2026-05-22 15:58:18\"\n                }\n            ]\n        }\n    }\n}"}],"structuredContent":{"tool":"listTodos","operationId":"listTodos","statusCode":200,"requestId":"8e39ae56ab8ac8a7f0481e4004d07a50","body":{"Result":true,"Data":{"status":"success","errorCode":"","todos":[{"id":1,"user_id":1,"title":"Read the routing guide","is_completed":true,"created_at":"2026-05-08 07:18:24","updated_at":"2026-05-08 07:18:24"},{"id":2,"user_id":1,"title":"Create a controller action","is_completed":false,"created_at":"2026-05-08 07:18:24","updated_at":"2026-05-08 07:18:24"},{"id":4,"user_id":1,"title":"\uff11\uff12\uff13","is_completed":false,"created_at":"2026-05-08 07:31:42","updated_at":"2026-05-08 07:31:42"},{"id":5,"user_id":1,"title":"\uff11\uff12\uff13","is_completed":false,"created_at":"2026-05-08 07:31:45","updated_at":"2026-05-08 07:31:45"},{"id":51,"user_id":1,"title":"FT450 confirm","is_completed":false,"created_at":"2026-05-22 15:44:26","updated_at":"2026-05-22 15:44:26"},{"id":52,"user_id":1,"title":"FT450 confirm","is_completed":false,"created_at":"2026-05-22 15:44:51","updated_at":"2026-05-22 15:44:51"},{"id":53,"user_id":1,"title":"FT630 L14 write","is_completed":false,"created_at":"2026-05-22 15:50:47","updated_at":"2026-05-22 15:50:47"},{"id":54,"user_id":1,"title":"FT630 L14 write","is_completed":false,"created_at":"2026-05-22 15:50:54","updated_at":"2026-05-22 15:50:54"},{"id":55,"user_id":1,"title":"FT630 L14 write","is_completed":false,"created_at":"2026-05-22 15:51:02","updated_at":"2026-05-22 15:51:02"},{"id":56,"user_id":1,"title":"FT630 L14 write","is_completed":false,"created_at":"2026-05-22 15:51:09","updated_at":"2026-05-22 15:51:09"},{"id":57,"user_id":1,"title":"FT630 L14 write","is_completed":false,"created_at":"2026-05-22 15:51:17","updated_at":"2026-05-22 15:51:17"},{"id":58,"user_id":1,"title":"L15 unicode \u30c6\u30b9\u30c8","is_completed":false,"created_at":"2026-05-22 15:58:05","updated_at":"2026-05-22 15:58:05"},{"id":59,"user_id":1,"title":"FT630 L14 write","is_completed":false,"created_at":"2026-05-22 15:58:05","updated_at":"2026-05-22 15:58:05"},{"id":60,"user_id":1,"title":"L15 roundtrip","is_completed":false,"created_at":"2026-05-22 15:58:05","updated_at":"2026-05-22 15:58:05"},{"id":61,"user_id":1,"title":"FT630 L14 write","is_completed":false,"created_at":"2026-05-22 15:58:18","updated_at":"2026-05-22 15:58:18"},{"id":62,"user_id":1,"title":"L15 roundtrip","is_completed":false,"created_at":"2026-05-22 15:58:18","updated_at":"2026-05-22 15:58:18"}]}}},"isError":false}}
ADV-PASS Bearer listTodos regression (post-FT450)

# L15 probe (FT660+, Bearer+operator composite, variant 0)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"createTodo\",\n    \"operationId\": \"createTodo\",\n    \"statusCode\": 200,\n    \"requestId\": \"35cb6c74fe2f03b6a88bc5f6b3139e36\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"todo\": {\n                \"id\": 63,\n                \"user_id\": 1,\n                \"title\": \"L15 unicode \\u30c6\\u30b9\\u30c8\",\n                \"is_completed\": false,\n                \"created_at\": \"2026-05-22 15:58:27\",\n                \"updated_at\": \"2026-05-22 15:58:27\"\n            }\n        }\n    }\n}"}],"structuredContent":{"tool":"createTodo","operationId":"createTodo","statusCode":200,"requestId":"35cb6c74fe2f03b6a88bc5f6b3139e36","body":{"Result":true,"Data":{"status":"success","errorCode":"","todo":{"id":63,"user_id":1,"title":"L15 unicode \u30c6\u30b9\u30c8","is_completed":false,"created_at":"2026-05-22 15:58:27","updated_at":"2026-05-22 15:58:27"}}}},"isError":false}}
ADV-PASS unicode title createTodo via Bearer
```

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Automated suite | PASS lines, no FAIL | See log above | Pass |
| Security cadence (N % 3 == 0) | write-failclosed pass | Pass | Pass |

## Friction Summary

L15 + L14 … L6 adversarial exercised — Bearer+operator composite probes.

## Recommendations

None.

## Security Review (required when N % 3 == 0)

### SSRF and URL control

- [x] Catalog probes exercised this cycle
- [x] Redirect following disabled (v0.1.2+)
- **Result**: pass (automated probes)

### Secret handling

- [x] Write fail-closed re-checked on security cadence
- **Result**: pass

### Write tools

- [x] `safety: write` without Bearer fails closed
- **Result**: pass

### JSON-RPC / protocol

- [x] Invalid catalog paths / JSON return safe errors
- **Result**: pass

**Security summary**: pass — automated probes; no new Issues.

```text
PASS write fail-closed
```

## Follow-up Issues

None.

## Overall Impression

Automated FT660 (Packagist install regression + unicode Bearer write (L15)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT661
