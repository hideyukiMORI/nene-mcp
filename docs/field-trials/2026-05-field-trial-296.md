# Field Trial 296 — Post-release v0.1.5 smoke

## Date

2026-05-22

## Baseline

- Tag: `v0.1.5` ([Release](https://github.com/hideyukiMORI/nene-mcp/releases/tag/v0.1.5))
- Prior FT: FT295 release gate

## Goal

Confirm Packagist, harness, and L6 adversarial bearer probe after v0.1.5 security patch.

## Packagist

| Check | Result |
| --- | --- |
| `tools/packagist-verify.sh 0.1.5` | **Pass** — installed `0.1.5` |
| `tools/ft-runner.sh packagist` | **Pass** — fresh `composer require ^0.1` |

## Harness

| Suite | Result |
| --- | --- |
| `write-failclosed` | Pass |
| `security-catalog` | Pass |
| `smoke` (ft1 health) | Pass |
| `composer test` (13 tests) | Pass |

## L6 spot check

| Probe | Result |
| --- | --- |
| Whitespace Bearer (`FT296` variant 1) | **Pass** — fail-closed (#64 fix) |
| SSRF catalog paths | Pass — stayed on configured base |

## Friction

None — security patch verified on Packagist.

## Next

FT297–336 — continue L6 band on 0.1.5 baseline.

Closes #69 (with band PR).
