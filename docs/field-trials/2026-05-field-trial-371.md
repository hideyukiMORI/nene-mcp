# Field Trial 371 — Multi-tool read catalog + Path param injection (L6)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.5`
- Runner: `tools/ft-individual.sh 371`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Multi-tool read catalog + Path param injection (L6)**.

## Steps Taken

### 1. Primary suite

```text
# FT smoke: /home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json
PASS initialize
PASS tools/list about
tools: ['nene_mcp_about', 'getHealthCheck', 'listTodos', 'getHealthWrongId']
PASS tools/call getHealthCheck (HTTP response returned)
PASS tools/call listTodos (HTTP response returned)

# Adversarial probe (FT255+ L6, variant 3)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getTodoById\",\n    \"operationId\": \"getTodo\",\n    \"statusCode\": 404,\n    \"requestId\": null,\n    \"body\": \"<!DOCTYPE HTML PUBLIC \\\"-//W3C//DTD HTML 4.01//EN\\\" \\\"http://www.w3.org/TR/html4/strict.dtd\\\">\\n<html><head>\\n<title>404 Not Found</title>\\n</head><body>\\n<h1>Not Found</h1>\\n<p>The requested URL was not found on this server.</p>\\n<hr>\\n<address>Apache/2.4.67 (Debian) Server at 127.0.0.1 Port 8080</address>\\n</body></html>\\n\"\n}"}],"structuredContent":{"tool":"getTodoById","operationId":"getTodo","statusCode":404,"requestId":null,"body":"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">\n<html><head>\n<title>404 Not Found</title>\n</head><body>\n<h1>Not Found</h1>\n<p>The requested URL was not found on this server.</p>\n<hr>\n<address>Apache/2.4.67 (Debian) Server at 127.0.0.1 Port 8080</address>\n</body></html>\n"},"isError":true}}
ADV-PASS path param encoded (no local file read)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getTodoById\",\n    \"operationId\": \"getTodo\",\n    \"statusCode\": 405,\n    \"requestId\": null,\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"failure\",\n            \"errorCode\": \"METHOD-NOT-ALLOWED\",\n            \"errorMessage\": \"The HTTP method is not allowed for this endpoint.\"\n        }\n    }\n}"}],"structuredContent":{"tool":"getTodoById","operationId":"getTodo","statusCode":405,"requestId":null,"body":{"Result":true,"Data":{"status":"failure","errorCode":"METHOD-NOT-ALLOWED","errorMessage":"The HTTP method is not allowed for this endpoint."}}},"isError":true}}
ADV-PASS traversal strings sent as literal id
```

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Automated suite | PASS lines, no FAIL | See log above | Pass |
| Security cadence (N % 3 == 0) | write-failclosed pass | N/A | N/A |

## Friction Summary

Adversarial L6 exercised — attacks blocked or deferred (NeNe #380). Whitespace bearer: #64.

## Recommendations

None.

## Security Review (required when N % 3 == 0)

N/A — security review scheduled for FT372.

## Follow-up Issues

None.

## Overall Impression

Automated FT371 (Multi-tool read catalog + Path param injection (L6)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT372
