# Field Trial 358 — Combined smoke milestone + Catalog safety mislabel (L6)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.5`
- Runner: `tools/ft-individual.sh 358`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Combined smoke milestone + Catalog safety mislabel (L6)**.

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

# Adversarial probe (FT255+ L6, variant 6)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"mislabeledWrite\",\n    \"operationId\": \"c\",\n    \"statusCode\": 401,\n    \"requestId\": null,\n    \"body\": {\n        \"error\": \"unauthorized\"\n    }\n}"}],"structuredContent":{"tool":"mislabeledWrite","operationId":"c","statusCode":401,"requestId":null,"body":{"error":"unauthorized"}},"isError":true}}
ADV-PASS F-7 documented: safety:read on protected POST returns API 401 (see write-tools-bearer)
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

N/A — security review scheduled for FT360.

## Follow-up Issues

None.

## Overall Impression

Automated FT358 (Combined smoke milestone + Catalog safety mislabel (L6)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT359
