# Field Trial 450 — NeNe Bearer confirmation gate (FT450)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.8`
- Runner: `tools/ft-individual.sh 450`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **NeNe Bearer confirmation gate (FT450)**.

## Steps Taken

### 1. Primary suite

```text
PASS about-only [{'name': 'nene_mcp_about', 'title': 'About nene-mcp', 'description': 'Return package metadata and resolved environment (paths and base URLs only; no secrets).', 'inputSchema': {'type': 'object', 'properties': {}, 'additionalProperties': False}, 'annotations': {'readOnlyHint': True}}]

# FT450 NeNe Bearer confirmation gate
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getHealthCheck\",\n    \"operationId\": \"healthCheck\",\n    \"statusCode\": 200,\n    \"requestId\": \"d8618219fd3c1319bdc13ab281866556\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"healthStatus\": \"ok\",\n            \"api\": true,\n            \"database\": true,\n            \"schema\": true,\n            \"environment\": \"development\",\n            \"databaseType\": \"MySQL\"\n        }\n    }\n}"}],"structuredContent":{"tool":"getHealthCheck","operationId":"healthCheck","statusCode":200,"requestId":"d8618219fd3c1319bdc13ab281866556","body":{"Result":true,"Data":{"status":"success","errorCode":"","healthStatus":"ok","api":true,"database":true,"schema":true,"environment":"development","databaseType":"MySQL"}}},"isError":false}}
FT450 health OK
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"listTodos\",\n    \"operationId\": \"listTodos\",\n    \"statusCode\": 200,\n    \"requestId\": \"1866ed4c0189b059e48cc284b78d9198\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"todos\": [\n                {\n                    \"id\": 1,\n                    \"user_id\": 1,\n                    \"title\": \"Read the routing guide\",\n                    \"is_completed\": true,\n                    \"created_at\": \"2026-05-08 07:18:24\",\n                    \"updated_at\": \"2026-05-08 07:18:24\"\n                },\n                {\n                    \"id\": 2,\n                    \"user_id\": 1,\n                    \"title\": \"Create a controller action\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-08 07:18:24\",\n                    \"updated_at\": \"2026-05-08 07:18:24\"\n                },\n                {\n                    \"id\": 4,\n                    \"user_id\": 1,\n                    \"title\": \"\\uff11\\uff12\\uff13\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-08 07:31:42\",\n                    \"updated_at\": \"2026-05-08 07:31:42\"\n                },\n                {\n                    \"id\": 5,\n                    \"user_id\": 1,\n                    \"title\": \"\\uff11\\uff12\\uff13\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-08 07:31:45\",\n                    \"updated_at\": \"2026-05-08 07:31:45\"\n                },\n                {\n                    \"id\": 51,\n                    \"user_id\": 1,\n                    \"title\": \"FT450 confirm\",\n                    \"is_completed\": false,\n                    \"created_at\": \"2026-05-22 15:44:26\",\n                    \"updated_at\": \"2026-05-22 15:44:26\"\n                }\n            ]\n        }\n    }\n}"}],"structuredContent":{"tool":"listTodos","operationId":"listTodos","statusCode":200,"requestId":"1866ed4c0189b059e48cc284b78d9198","body":{"Result":true,"Data":{"status":"success","errorCode":"","todos":[{"id":1,"user_id":1,"title":"Read the routing guide","is_completed":true,"created_at":"2026-05-08 07:18:24","updated_at":"2026-05-08 07:18:24"},{"id":2,"user_id":1,"title":"Create a controller action","is_completed":false,"created_at":"2026-05-08 07:18:24","updated_at":"2026-05-08 07:18:24"},{"id":4,"user_id":1,"title":"\uff11\uff12\uff13","is_completed":false,"created_at":"2026-05-08 07:31:42","updated_at":"2026-05-08 07:31:42"},{"id":5,"user_id":1,"title":"\uff11\uff12\uff13","is_completed":false,"created_at":"2026-05-08 07:31:45","updated_at":"2026-05-08 07:31:45"},{"id":51,"user_id":1,"title":"FT450 confirm","is_completed":false,"created_at":"2026-05-22 15:44:26","updated_at":"2026-05-22 15:44:26"}]}}},"isError":false}}
FT450-PASS listTodos without session cookie
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"createTodo\",\n    \"operationId\": \"createTodo\",\n    \"statusCode\": 200,\n    \"requestId\": \"43d780135f5ad2beafd1abd53e67cf2b\",\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"success\",\n            \"errorCode\": \"\",\n            \"todo\": {\n                \"id\": 52,\n                \"user_id\": 1,\n                \"title\": \"FT450 confirm\",\n                \"is_completed\": false,\n                \"created_at\": \"2026-05-22 15:44:51\",\n                \"updated_at\": \"2026-05-22 15:44:51\"\n            }\n        }\n    }\n}"}],"structuredContent":{"tool":"createTodo","operationId":"createTodo","statusCode":200,"requestId":"43d780135f5ad2beafd1abd53e67cf2b","body":{"Result":true,"Data":{"status":"success","errorCode":"","todo":{"id":52,"user_id":1,"title":"FT450 confirm","is_completed":false,"created_at":"2026-05-22 15:44:51","updated_at":"2026-05-22 15:44:51"}}}},"isError":false}}
FT450-PASS createTodo without CSRF
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"Write tool \"createTodo\" requires bearer authentication. Set NENE_MCP_BEARER_TOKEN in the MCP server environment."}}
FT450-PASS write fail-closed without Bearer
```

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Automated suite | PASS lines, no FAIL | See log above | Pass |
| Security cadence (N % 3 == 0) | write-failclosed pass | Pass | Pass |

## Friction Summary

FT450 gate **confirmed** — NeNe #395 Bearer E2E: listTodos/createTodo without session; write fail-closed without Bearer.

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

Automated FT450 (NeNe Bearer confirmation gate (FT450)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT451
