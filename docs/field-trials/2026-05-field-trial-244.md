# Field Trial 244 — Write fail-closed regression + Packagist 0.1.4 pin

Automated individual report per [`quality-strategy.md`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: `0.1.4`
- Runner: `tools/ft-individual.sh 244`
- Catalog: `/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **Write fail-closed regression + Packagist 0.1.4 pin**.

## Steps Taken

### 1. Primary suite

```text
PASS write fail-closed

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

N/A — security review scheduled for FT246.

## Follow-up Issues

None.

## Overall Impression

Automated FT244 (Write fail-closed regression + Packagist 0.1.4 pin): **Pass**.

## Next FT gate

- [ ] No open actionable Issues before FT245
