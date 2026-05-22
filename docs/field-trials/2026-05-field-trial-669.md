# Field Trial 669 — Security review — catalog probes + NENE2 base + Bearer (L15)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.8`
- Runner: `tools/ft-individual.sh 669`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Security review — catalog probes + NENE2 base + Bearer (L15)**.

## Steps Taken

### 1. Primary suite

```text
# FT security catalog probes
PASS duplicate names rejected
PASS invalid JSON rejected
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"bad\",\n    \"operationId\": \"x\",\n    \"statusCode\": 400,\n    \"requestId\": null,\n    \"body\": \"<!DOCTYP

# Adversarial probe (FT255+ L6, variant 5)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"sessionLogin\",\n    \"operationId\": \"login\",\n    \"statusCode\": 401,\n    \"requestId\": \"1e2e662735e1df8e17852e5805abbb4c\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"failure\",\n            \"errorCode\": \"LOGIN-FAILED\",\n            \"errorMessage\": \"Wrong user ID or user PASS\"\n        }\n    }\n}"}],"structuredContent":{"tool":"sessionLogin","operationId":"login","statusCode":401,"requestId":"1e2e662735e1df8e17852e5805abbb4c","body":{"Result":true,"Data":{"status":"failure","errorCode":"LOGIN-FAILED","errorMessage":"Wrong user ID or user PASS"}}},"isError":true}}
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"createTodo\",\n    \"operationId\": \"createTodo\",\n    \"statusCode\": 401,\n    \"requestId\": \"117b9cd574d3803f42c2b0583bc707df\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"failure\",\n            \"errorCode\": \"SESSION-CLOSED\",\n            \"errorMessage\": \"Session timeout. Please log in again.\"\n        }\n    }\n}"}],"structuredContent":{"tool":"createTodo","operationId":"createTodo","statusCode":401,"requestId":"117b9cd574d3803f42c2b0583bc707df","body":{"Result":true,"Data":{"status":"failure","errorCode":"SESSION-CLOSED","errorMessage":"Session timeout. Please log in again."}}},"isError":true}}
ADV-PASS NeNe write chain blocked (session/CSRF/Bearer — fix-in-host #380)

# L7 probe (FT420+, variant 3)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"listInventoryItems\",\n    \"operationId\": \"listItems\",\n    \"statusCode\": 200,\n    \"requestId\": null,\n 
ADV-PASS oversized query did not crash MCP

# L8 probe (FT451+, variant 3)
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"MCP catalog tool name \"dup\" is duplicated. Tool names must be unique."}}
ADV-PASS duplicate tool names rejected (#22)

# L9 probe (FT480+, variant 3)
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"Write tool \"delw\" requires bearer authentication. Set NENE_MCP_BEARER_TOKEN in the MCP server environment."}}
ADV-PASS DELETE write blocked without bearer

# L10 probe (FT510+, v0.1.8 SMB, variant 3)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"nene_mcp_about\",\n    \"packageName\": \"hideyukiMORI/nene-mcp\",\n    \"packageVersion\": \"0.1.8\",\n    \"phpVersion\": \"8.4.21\",\n    \"runtime\": {\n        \"catalogPath\": null,\n        \"apiBaseUrl\": \"http://127.0.0.1:9090\",\n        \"hasBearerTokenConfigured\": false,\n        \"httpTimeoutSec\": 10,\n        \"tlsCaFileConfigured\": false,\n        \"httpLogStderr\": true\n    }\n}"}],"structuredContent":{"tool":"nene_mcp_about","packageName":"hideyukiMORI/nene-mcp","packageVersion":"0.1.8","phpVersion":"8.4.21","runtime":{"catalogPath":null,"apiBaseUrl":"http://127.0.0.1:9090","hasBearerTokenConfigured":false,"httpTimeoutSec":10,"tlsCaFileConfigured":false,"httpLogStderr":true}},"isError":false}}
ADV-PASS stderr log flag in runtime

# L11 probe (FT540+, operator boundaries, variant 3)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"nene_mcp_about\",\n    \"packageName\": \"hideyukiMORI/nene-mcp\",\n    \"packageVersion\": \"0.1.8\",\n    \"phpVersion\": \"8.4.21\",\n    \"runtime\": {\n        \"catalogPath\": null,\n        \"apiBaseUrl\": \"http://127.0.0.1:9090\",\n        \"hasBearerTokenConfigured\": false,\n        \"httpTimeoutSec\": 10,\n        \"tlsCaFileConfigured\": false,\n        \"httpLogStderr\": false\n    }\n}"}],"structuredContent":{"tool":"nene_mcp_about","packageName":"hideyukiMORI/nene-mcp","packageVersion":"0.1.8","phpVersion":"8.4.21","runtime":{"catalogPath":null,"apiBaseUrl":"http://127.0.0.1:9090","hasBearerTokenConfigured":false,"httpTimeoutSec":10,"tlsCaFileConfigured":false,"httpLogStderr":false}},"isError":false}}
ADV-PASS invalid log value ignored

# L12 probe (FT570+, NENE2 alias compatibility, variant 3)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"nene_mcp_about\",\n    \"packageName\": \"hideyukiMORI/nene-mcp\",\n    \"packageVersion\": \"0.1.8\",\n    \"phpVersion\": \"8.4.21\",\n    \"runtime\": {\n        \"catalogPath\": null,\n        \"apiBaseUrl\": \"http://127.0.0.1:9090\",\n        \"hasBearerTokenConfigured\": false,\n        \"httpTimeoutSec\": 7,\n        \"tlsCaFileConfigured\": false,\n        \"httpLogStderr\": false\n    }\n}"}],"structuredContent":{"tool":"nene_mcp_about","packageName":"hideyukiMORI/nene-mcp","packageVersion":"0.1.8","phpVersion":"8.4.21","runtime":{"catalogPath":null,"apiBaseUrl":"http://127.0.0.1:9090","hasBearerTokenConfigured":false,"httpTimeoutSec":7,"tlsCaFileConfigured":false,"httpLogStderr":false}},"isError":false}}
ADV-PASS leading-zero timeout parsed as 7

# L13 probe (FT600+, HTTP diagnostics, variant 3)
{"jsonrpc":"2.0","id":1,"result":{"tools":[{"name":"nene_mcp_about","title":"About nene-mcp","description":"Return package metadata and resolved environment (paths and base URLs only; no secrets).","inputSchema":{"type":"object","properties":{},"additionalProperties":false},"annotations":{"readOnlyHint":true}},{"name":"getHealthCheck","title":"Health Check","description":"GET /health/index (operationId healthCheck).","inputSchema":{"type":"object","properties":{},"additionalProperties":false},"annotations":{"readOnlyHint":true}},{"name":"listTodos","title":"List TODOs","description":"GET /todo/index (operationId listTodos). Requires session; expect 401 without auth.","inputSchema":{"type":"object","properties":{},"additionalProperties":false},"annotations":{"readOnlyHint":true}},{"name":"getHealthWrongId","title":"Wrong operationId probe","description":"Misaligned operationId on purpose (FT5 adversarial).","inputSchema":{"type":"object","properties":{},"additionalProperties":false},"annotations":{"readOnlyHint":true}}]}}
ADV-PASS NENE_MCP_TOOLS_JSON overrides NENE2 catalog alias

# L14 probe (FT630+, Bearer E2E regression, variant 3)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"nene_mcp_about\",\n    \"packageName\": \"hideyukiMORI/nene-mcp\",\n    \"packageVersion\": \"0.1.8\",\n    \"phpVersion\": \"8.4.21\",\n    \"runtime\": {\n        \"catalogPath\": null,\n        \"apiBaseUrl\": \"http://127.0.0.1:8080\",\n        \"hasBearerTokenConfigured\": true,\n        \"httpTimeoutSec\": 10,\n        \"tlsCaFileConfigured\": false,\n        \"httpLogStderr\": false\n    }\n}"}],"structuredContent":{"tool":"nene_mcp_about","packageName":"hideyukiMORI/nene-mcp","packageVersion":"0.1.8","phpVersion":"8.4.21","runtime":{"catalogPath":null,"apiBaseUrl":"http://127.0.0.1:8080","hasBearerTokenConfigured":true,"httpTimeoutSec":10,"tlsCaFileConfigured":false,"httpLogStderr":false}},"isError":false}}
ADV-PASS about shows bearer configured; token not leaked

# L15 probe (FT660+, Bearer+operator composite, variant 3)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"listTodos\",\n    \"operationId\": \"listTodos\",\n    \"statusCode\": 200,\n    \"requestId\": \"59482f384ef26368ae3b94dbc79d33ee\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"todos\": [\n                {\n                    \"id\": 1,\n                    \"user_id\": 1,\n                    \"title\": \"Read the routing guide\",\n                    \"is_completed\": true,\n                    \"created_at\": \"2026-05-08 07:18:24\",\n                    \"updated_at\": \"2026-05-08 07:18:24\"\n                },\n                {\n                    \"id\": 2,\n                    \"user_id\": 1,\n                    \"title\": \"Create a controller action\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-08 07:18:24\",\n                    \"updated_at\": \"2026-05-08 07:18:24\"\n                },\n                {\n                    \"id\": 4,\n                    \"user_id\": 1,\n                    \"title\": \"\\uff11\\uff12\\uff13\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-08 07:31:42\",\n                    \"updated_at\": \"2026-05-08 07:31:42\"\n                },\n                {\n                    \"id\": 5,\n                    \"user_id\": 1,\n                    \"title\": \"\\uff11\\uff12\\uff13\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-08 07:31:45\",\n                    \"updated_at\": \"2026-05-08 07:31:45\"\n                },\n                {\n                    \"id\": 51,\n                    \"user_id\": 1,\n                    \"title\": \"FT450 confirm\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:44:26\",\n                    \"updated_at\": \"2026-05-22 15:44:26\"\n                },\n                {\n                    \"id\": 52,\n                    \"user_id\": 1,\n                    \"title\": \"FT450 confirm\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:44:51\",\n                    \"updated_at\": \"2026-05-22 15:44:51\"\n                },\n                {\n                    \"id\": 53,\n                    \"user_id\": 1,\n                    \"title\": \"FT630 L14 write\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:50:47\",\n                    \"updated_at\": \"2026-05-22 15:50:47\"\n                },\n                {\n                    \"id\": 54,\n                    \"user_id\": 1,\n                    \"title\": \"FT630 L14 write\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:50:54\",\n                    \"updated_at\": \"2026-05-22 15:50:54\"\n                },\n                {\n                    \"id\": 55,\n                    \"user_id\": 1,\n                    \"title\": \"FT630 L14 write\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:51:02\",\n                    \"updated_at\": \"2026-05-22 15:51:02\"\n                },\n                {\n                    \"id\": 56,\n                    \"user_id\": 1,\n                    \"title\": \"FT630 L14 write\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:51:09\",\n                    \"updated_at\": \"2026-05-22 15:51:09\"\n                },\n                {\n                    \"id\": 57,\n                    \"user_id\": 1,\n                    \"title\": \"FT630 L14 write\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:51:17\",\n                    \"updated_at\": \"2026-05-22 15:51:17\"\n                },\n                {\n                    \"id\": 58,\n                    \"user_id\": 1,\n                    \"title\": \"L15 unicode \\u30c6\\u30b9\\u30c8\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:58:05\",\n                    \"updated_at\": \"2026-05-22 15:58:05\"\n                },\n                {\n                    \"id\": 59,\n                    \"user_id\": 1,\n                    \"title\": \"FT630 L14 write\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:58:05\",\n                    \"updated_at\": \"2026-05-22 15:58:05\"\n                },\n                {\n                    \"id\": 60,\n                    \"user_id\": 1,\n                    \"title\": \"L15 roundtrip\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:58:05\",\n                    \"updated_at\": \"2026-05-22 15:58:05\"\n                },\n                {\n                    \"id\": 61,\n                    \"user_id\": 1,\n                    \"title\": \"FT630 L14 write\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:58:18\",\n                    \"updated_at\": \"2026-05-22 15:58:18\"\n                },\n                {\n                    \"id\": 62,\n                    \"user_id\": 1,\n                    \"title\": \"L15 roundtrip\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:58:18\",\n                    \"updated_at\": \"2026-05-22 15:58:18\"\n                },\n                {\n                    \"id\": 63,\n                    \"user_id\": 1,\n                    \"title\": \"L15 unicode \\u30c6\\u30b9\\u30c8\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:58:27\",\n                    \"updated_at\": \"2026-05-22 15:58:27\"\n                },\n                {\n                    \"id\": 64,\n                    \"user_id\": 1,\n                    \"title\": \"FT630 L14 write\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:58:28\",\n                    \"updated_at\": \"2026-05-22 15:58:28\"\n                },\n                {\n                    \"id\": 65,\n                    \"user_id\": 1,\n                    \"title\": \"L15 roundtrip\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:58:28\",\n                    \"updated_at\": \"2026-05-22 15:58:28\"\n                },\n                {\n                    \"id\": 66,\n                    \"user_id\": 1,\n                    \"title\": \"L15 stderr write\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:58:29\",\n                    \"updated_at\": \"2026-05-22 15:58:29\"\n                },\n                {\n                    \"id\": 67,\n                    \"user_id\": 1,\n                    \"title\": \"L15 unicode \\u30c6\\u30b9\\u30c8\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:58:30\",\n                    \"updated_at\": \"2026-05-22 15:58:30\"\n                },\n                {\n                    \"id\": 68,\n                    \"user_id\": 1,\n                    \"title\": \"FT630 L14 write\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:58:35\",\n                    \"updated_at\": \"2026-05-22 15:58:35\"\n                },\n                {\n                    \"id\": 69,\n                    \"user_id\": 1,\n                    \"title\": \"L15 roundtrip\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:58:35\",\n                    \"updated_at\": \"2026-05-22 15:58:35\"\n                }\n            ]\n        }\n    }\n}"}],"structuredContent":{"tool":"listTodos","operationId":"listTodos","statusCode":200,"requestId":"59482f384ef26368ae3b94dbc79d33ee","body":{"Result":true,"Data":{"status":"success","errorCode":"","todos":[{"id":1,"user_id":1,"title":"Read the routing guide","is_completed":true,"created_at":"2026-05-08 07:18:24","updated_at":"2026-05-08 07:18:24"},{"id":2,"user_id":1,"title":"Create a controller action","is_completed":false,"created_at":"2026-05-08 07:18:24","updated_at":"2026-05-08 07:18:24"},{"id":4,"user_id":1,"title":"\uff11\uff12\uff13","is_completed":false,"created_at":"2026-05-08 07:31:42","updated_at":"2026-05-08 07:31:42"},{"id":5,"user_id":1,"title":"\uff11\uff12\uff13","is_completed":false,"created_at":"2026-05-08 07:31:45","updated_at":"2026-05-08 07:31:45"},{"id":51,"user_id":1,"title":"FT450 confirm","is_completed":false,"created_at":"2026-05-22 15:44:26","updated_at":"2026-05-22 15:44:26"},{"id":52,"user_id":1,"title":"FT450 confirm","is_completed":false,"created_at":"2026-05-22 15:44:51","updated_at":"2026-05-22 15:44:51"},{"id":53,"user_id":1,"title":"FT630 L14 write","is_completed":false,"created_at":"2026-05-22 15:50:47","updated_at":"2026-05-22 15:50:47"},{"id":54,"user_id":1,"title":"FT630 L14 write","is_completed":false,"created_at":"2026-05-22 15:50:54","updated_at":"2026-05-22 15:50:54"},{"id":55,"user_id":1,"title":"FT630 L14 write","is_completed":false,"created_at":"2026-05-22 15:51:02","updated_at":"2026-05-22 15:51:02"},{"id":56,"user_id":1,"title":"FT630 L14 write","is_completed":false,"created_at":"2026-05-22 15:51:09","updated_at":"2026-05-22 15:51:09"},{"id":57,"user_id":1,"title":"FT630 L14 write","is_completed":false,"created_at":"2026-05-22 15:51:17","updated_at":"2026-05-22 15:51:17"},{"id":58,"user_id":1,"title":"L15 unicode \u30c6\u30b9\u30c8","is_completed":false,"created_at":"2026-05-22 15:58:05","updated_at":"2026-05-22 15:58:05"},{"id":59,"user_id":1,"title":"FT630 L14 write","is_completed":false,"created_at":"2026-05-22 15:58:05","updated_at":"2026-05-22 15:58:05"},{"id":60,"user_id":1,"title":"L15 roundtrip","is_completed":false,"created_at":"2026-05-22 15:58:05","updated_at":"2026-05-22 15:58:05"},{"id":61,"user_id":1,"title":"FT630 L14 write","is_completed":false,"created_at":"2026-05-22 15:58:18","updated_at":"2026-05-22 15:58:18"},{"id":62,"user_id":1,"title":"L15 roundtrip","is_completed":false,"created_at":"2026-05-22 15:58:18","updated_at":"2026-05-22 15:58:18"},{"id":63,"user_id":1,"title":"L15 unicode \u30c6\u30b9\u30c8","is_completed":false,"created_at":"2026-05-22 15:58:27","updated_at":"2026-05-22 15:58:27"},{"id":64,"user_id":1,"title":"FT630 L14 write","is_completed":false,"created_at":"2026-05-22 15:58:28","updated_at":"2026-05-22 15:58:28"},{"id":65,"user_id":1,"title":"L15 roundtrip","is_completed":false,"created_at":"2026-05-22 15:58:28","updated_at":"2026-05-22 15:58:28"},{"id":66,"user_id":1,"title":"L15 stderr write","is_completed":false,"created_at":"2026-05-22 15:58:29","updated_at":"2026-05-22 15:58:29"},{"id":67,"user_id":1,"title":"L15 unicode \u30c6\u30b9\u30c8","is_completed":false,"created_at":"2026-05-22 15:58:30","updated_at":"2026-05-22 15:58:30"},{"id":68,"user_id":1,"title":"FT630 L14 write","is_completed":false,"created_at":"2026-05-22 15:58:35","updated_at":"2026-05-22 15:58:35"},{"id":69,"user_id":1,"title":"L15 roundtrip","is_completed":false,"created_at":"2026-05-22 15:58:35","updated_at":"2026-05-22 15:58:35"}]}}},"isError":false}}
ADV-PASS NENE2 base alias + Bearer listTodos
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

Automated FT669 (Security review — catalog probes + NENE2 base + Bearer (L15)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT670
