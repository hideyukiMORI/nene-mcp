# Field Trial 230 — Packagist install regression + Bearer-native E2E (L4)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.4`
- Runner: `tools/ft-individual.sh 230`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Packagist install regression + Bearer-native E2E (L4)**.

## Steps Taken

### 1. Primary suite

```text
PASS about-only [{'name': 'nene_mcp_about', 'title': 'About nene-mcp', 'description': 'Return package metadata and resolved environment (paths and base URLs only; no secrets).', 'inputSchema': {'type': 'object', 'properties': {}, 'additionalProperties': False}, 'annotations': {'readOnlyHint': True}}]

# Persona probe (FT225+ band, variant 0)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"listInventoryItems\",\n    \"operationId\": \"listItems\",\n    \"statusCode\": 200,\n    \"requestId\": null,\n    \"body\": {\n        \"items\": [\n            {\n                \"id\": 1,\n                \"sku\": \"WIDGET-1\",\n                \"qty\": 10\n            },\n            {\n                \"id\": 2,\n                \"sku\": \"GADGET-2\",\n                \"qty\": 5\n            }\n        ]\n    }\n}"}],"structuredContent":{"tool":"listInventoryItems","operationId":"listItems","statusCode":200,"requestId":null,"body":{"items":[{"id":1,"sku":"WIDGET-1","qty":10},{"id":2,"sku":"GADGET-2","qty":5}]}},"isError":false}}
PASS bearer-native list
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"createInventoryItem\",\n    \"operationId\": \"createItem\",\n    \"statusCode\": 201,\n    \"requestId\": null,\n    \"body\": {\n        \"id\": 2,\n        \"sku\": \"FT230\",\n        \"qty\": 1\n    }\n}"}],"structuredContent":{"tool":"createInventoryItem","operationId":"createItem","statusCode":201,"requestId":null,"body":{"id":2,"sku":"FT230","qty":1}},"isError":false}}
PASS bearer-native create
```

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Automated suite | PASS lines, no FAIL | See log above | Pass |
| Security cadence (N % 3 == 0) | write-failclosed pass | N/A | N/A |

## Friction Summary

None this cycle.

## Recommendations

None.

## Security Review (required when N % 3 == 0)

N/A — security review scheduled for FT231.

## Follow-up Issues

None.

## Overall Impression

Automated FT230 (Packagist install regression + Bearer-native E2E (L4)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT231
