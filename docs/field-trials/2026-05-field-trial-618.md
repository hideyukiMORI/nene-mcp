# Field Trial 618 — Combined smoke milestone + stderr HTTP log line (L13)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.8`
- Runner: `tools/ft-individual.sh 618`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Combined smoke milestone + stderr HTTP log line (L13)**.

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

# Adversarial probe (FT255+ L6, variant 2)
{"jsonrpc":"2.0","id":null,"error":{"code":-32700,"message":"Syntax error"}}
ADV-PASS malformed JSON-RPC rejected
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"MCP tool \"nonexistent_tool_xyz\" was not found."}}
ADV-PASS unknown tool rejected
{"jsonrpc":"2.0","id":1,"result":{"tools":[{"name":"nene_mcp_about","title":"About nene-mcp","description":"Return package metadata and resolved environment (paths and base URLs only; no secrets).","i
ADV-PASS oversized line handled

# L7 probe (FT420+, variant 0)
{"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"Write tool \"w\" requires bearer authentication. Set NENE_MCP_BEARER_TOKEN in the MCP server environment."}}
ADV-PASS typo env var ignored; fail-closed holds

# L8 probe (FT451+, variant 0)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"w\",\n    \"operationId\": \"x\",\n    \"statusCode\": 400,\n    \"requestId\": null,\n    \"body\": \"<!DOCTYPE HTML PUBLIC \\\"-//W3C//DTD HTML 4.01//EN\\\" \\\"http://www.w3.org/TR/html4/strict.dtd\\\">\\n<html><head>\\n<title>400 Bad Request</title>\\n</head><body>\\n<h1>Bad Request</h1>\\n<p>Your browser sent a request that this server could not understand.<br />\\n</p>\\n<hr>\\n<address>Apache/2.4.67 (Debian) Server at localhost Port 80</address>\\n</body></html>\\n\"\n}"}],"structuredContent":{"tool":"w","operationId":"x","statusCode":400,"requestId":null,"body":"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">\n<html><head>\n<title>400 Bad Request</title>\n</head><body>\n<h1>Bad Request</h1>\n<p>Your browser sent a request that this server could not understand.<br />\n</p>\n<hr>\n<address>Apache/2.4.67 (Debian) Server at localhost Port 80</address>\n</body></html>\n"},"isError":true}}
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
```

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Automated suite | PASS lines, no FAIL | See log above | Pass |
| Security cadence (N % 3 == 0) | write-failclosed pass | Pass | Pass |

## Friction Summary

L13 + L12 + L11 + L10 + L9 + L8 + L7 + L6 adversarial exercised — HTTP diagnostics. FT450 on hold for NeNe #395.

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

Automated FT618 (Combined smoke milestone + stderr HTTP log line (L13)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT619
