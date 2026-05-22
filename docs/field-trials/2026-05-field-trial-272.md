# Field Trial 272 — About-only minimal install + SSRF off-host escape (L6)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.4`
- Runner: `tools/ft-individual.sh 272`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **About-only minimal install + SSRF off-host escape (L6)**.

## Steps Taken

### 1. Primary suite

```text
PASS about-only [{'name': 'nene_mcp_about', 'title': 'About nene-mcp', 'description': 'Return package metadata and resolved environment (paths and base URLs only; no secrets).', 'inputSchema': {'type': 'object', 'properties': {}, 'additionalProperties': False}, 'annotations': {'readOnlyHint': True}}]

# Adversarial probe (FT255+ L6, variant 0)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"ssrfAbs\",\n    \"operationId\": \"x\",\n    \"statusCode\": 404,\n    \"requestId\": null,\n    \"body\": {\n        \"error\": \"not_found\"\n    }\n}"}],"structuredContent":{"tool":"ssrfAbs","operationId":"x","statusCode":404,"requestId":null,"body":{"error":"not_found"}},"isError":true}}
ADV-PASS SSRF ssrfAbs stayed on configured base
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"ssrfProto\",\n    \"operationId\": \"y\",\n    \"statusCode\": 200,\n    \"requestId\": null,\n    \"body\": {\n        \"status\": \"ok\"\n    }\n}"}],"structuredContent":{"tool":"ssrfProto","operationId":"y","statusCode":200,"requestId":null,"body":{"status":"ok"}},"isError":false}}
ADV-PASS SSRF ssrfProto stayed on configured base
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

N/A — security review scheduled for FT273.

## Follow-up Issues

None.

## Overall Impression

Automated FT272 (About-only minimal install + SSRF off-host escape (L6)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT273
