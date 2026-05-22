# Field Trial 229 — Security review — catalog probes + Packagist 0.1.4 pin

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.4`
- Runner: `tools/ft-individual.sh 229`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Security review — catalog probes + Packagist 0.1.4 pin**.

## Steps Taken

### 1. Primary suite

```text
# FT security catalog probes
PASS duplicate names rejected
PASS invalid JSON rejected
{"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\n    \"tool\": \"bad\",\n    \"operationId\": \"x\",\n    \"statusCode\": 404,\n    \"requestId\": null,\n    \"body\": {\n       

# Persona probe (FT225+ band, variant 4)
# Packagist verify: hideyukimori/nene-mcp:0.1.4
PHP Deprecated:  Composer\Util\ErrorHandler::register(): Implicitly marking parameter $io as nullable is deprecated, the explicit nullable type must be used instead in /usr/share/php/Composer/Util/ErrorHandler.php on line 89

Deprecated: Composer\Util\ErrorHandler::register(): Implicitly marking parameter $io as nullable is deprecated, the explicit nullable type must be used instead in /usr/share/php/Composer/Util/ErrorHandler.php on line 89
PHP Deprecated:  Composer\Util\ErrorHandler::register(): Implicitly marking parameter $io as nullable is deprecated, the explicit nullable type must be used instead in /usr/share/php/Composer/Util/ErrorHandler.php on line 89

Deprecated: Composer\Util\ErrorHandler::register(): Implicitly marking parameter $io as nullable is deprecated, the explicit nullable type must be used instead in /usr/share/php/Composer/Util/ErrorHandler.php on line 89
Installed package version: 0.1.4
PASS tools/list smoke
PASS packagist verify 0.1.4
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

Automated FT229 (Security review — catalog probes + Packagist 0.1.4 pin): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT230
