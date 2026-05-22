# Field Trial 436 — NeNe Docker golden path smoke + unicode path param (L7)

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.6`
- Runner: `tools/ft-individual.sh 436`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **NeNe Docker golden path smoke + unicode path param (L7)**.

## Steps Taken

### 1. Primary suite

```text
# FT smoke: /home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json
PASS initialize
PASS tools/list about
tools: ['nene_mcp_about', 'getHealthCheck', 'listTodos', 'getHealthWrongId']

# Adversarial probe (FT255+ L6, variant 4)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"nene_mcp_about\",\n    \"packageName\": \"hideyukiMORI/nene-mcp\",\n    \"packageVersion\": \"0.1.6\",\n    \"phpVersion\": \"8.4.21\",\n    \"runtime\": {\n        \"catalogPath\": \"/home/xi/docker/nene-mcp-FT/ft206-persona-bearer-native/docs/mcp/tools.json\",\n        \"apiBaseUrl\": \"http://127.0.0.1:9090\",\n        \"hasBearerTokenConfigured\": true\n    }\n}"}],"structuredContent":{"tool":"nene_mcp_about","packageName":"hideyukiMORI/nene-mcp","packageVersion":"0.1.6","phpVersion":"8.4.21","runtime":{"catalogPath":"/home/xi/docker/nene-mcp-FT/ft206-persona-bearer-native/docs/mcp/tools.json","apiBaseUrl":"http://127.0.0.1:9090","hasBearerTokenConfigured":true}},"isError":false}}
ADV-PASS about omits bearer value
ADV-PASS HTTP response does not echo env token

# L7 probe (FT420+, variant 4)
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"getTodoById\",\n    \"operationId\": \"getTodo\",\n    \"statusCode\": 405,\n    \"requestId\": null,\n    \"body\": {\n        \"Result\": true,\n        \"Data\": {\n            \"status\": \"failure\",\n            \"errorCode\": \"METHOD-NOT-ALLOWED\",\n            \"errorMessage\": \"The HTTP method is not allowed for this endpoint.\"\n        }\n    }\n}"}],"structuredContent":{"tool":"getTodoById","operationId":"getTodo","statusCode":405,"requestId":null,"body":{"Result":true,"Data":{"status":"failure","errorCode":"METHOD-NOT-ALLOWED","errorMessage":"The HTTP method is not allowed for this endpoint."}}},"isError":true}}
ADV-PASS unicode/null id encoded in path
```

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Automated suite | PASS lines, no FAIL | See log above | Pass |
| Security cadence (N % 3 == 0) | write-failclosed pass | N/A | N/A |

## Friction Summary

L7 + L6 adversarial exercised — see probe log. NeNe Bearer gate: FT450 after #380/#395.

## Recommendations

None.

## Security Review (required when N % 3 == 0)

N/A — security review scheduled for FT438.

## Follow-up Issues

None.

## Overall Impression

Automated FT436 (NeNe Docker golden path smoke + unicode path param (L7)): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT437
