# Field Trial 302 — About-only minimal install + Catalog safety mislabel (L6)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.5`
- Runner: `tools/ft-individual.sh 302`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **About-only minimal install + Catalog safety mislabel (L6)**.

## Steps Taken

### 1. Primary suite

```text
PASS about-only [{'name': 'nene_mcp_about', 'title': 'About nene-mcp', 'description': 'Return package metadata and resolved environment (paths and base URLs only; no secrets).', 'inputSchema': {'type': 'object', 'properties': {}, 'additionalProperties': False}, 'annotations': {'readOnlyHint': True}}]

# Adversarial probe (FT255+ L6, variant 6)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"mislabeledWrite\",\n    \"operationId\": \"c\",\n    \"statusCode\": 401,\n    \"requestId\": null,\n    \"body\": {\n        \"error\": \"unauthorized\"\n    }\n}"}],"structuredContent":{"tool":"mislabeledWrite","operationId":"c","statusCode":401,"requestId":null,"body":{"error":"unauthorized"}},"isError":true}}
FINDING (F-7): safety:read skips fail-closed; API 401 only — operator may expose write without env Bearer (document)
```

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Automated suite | PASS lines, no FAIL | See log above | Pass |
| Security cadence (N % 3 == 0) | write-failclosed pass | N/A | N/A |

## Friction Summary

| FINDING (F-7): safety:read skips fail-closed; API 401 only — operator may expose write without env Bearer (document) | medium | security-gap / docs-gap | see probe log |

## Recommendations

Document `safety:read` on Bearer-protected POST — operators must set env Bearer even when catalog says read.

## Security Review (required when N % 3 == 0)

N/A — security review scheduled for FT303.

## Follow-up Issues

None.

## Overall Impression

Automated FT302 (About-only minimal install + Catalog safety mislabel (L6)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT303
