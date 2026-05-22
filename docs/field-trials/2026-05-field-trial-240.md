# Field Trial 240 — Packagist install regression + Bearer-native E2E (L4)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.4`
- Runner: `tools/ft-individual.sh 240`
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
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"createInventoryItem\",\n    \"operationId\": \"createItem\",\n    \"statusCode\": 201,\n    \"requestId\": null,\n    \"body\": {\n        \"id\": 2,\n        \"sku\": \"FT240\",\n        \"qty\": 1\n    }\n}"}],"structuredContent":{"tool":"createInventoryItem","operationId":"createItem","statusCode":201,"requestId":null,"body":{"id":2,"sku":"FT240","qty":1}},"isError":false}}
PASS bearer-native create
```

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Automated suite | PASS lines, no FAIL | See log above | Pass |
| Security cadence (N % 3 == 0) | write-failclosed pass | Pass | Pass |

## Friction Summary

None this cycle.

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

Automated FT240 (Packagist install regression + Bearer-native E2E (L4)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT241
