# Field Trial 295 — Release v0.1.5 (security patch)

## Date

2026-05-22

## Baseline

- Prior tag: `v0.1.4`
- L6 adversarial band FT255–294 merged; #64 fix on main

## Goal

Ship security patch: whitespace-only Bearer no longer bypasses write fail-closed.

## Verification (pre-tag)

| Check | Result |
| --- | --- |
| `composer validate` | Pass |
| `composer test` (13 tests) | Pass |
| `McpEnvironmentTest` whitespace bearer | Pass |
| FT256 adversarial bearer probe | Pass (whitespace rejected) |
| `Package.php` VERSION | `0.1.5` |
| CHANGELOG | 0.1.5 section |

## Post-tag

- [ ] GitHub Release `v0.1.5` published
- [ ] `tools/packagist-verify.sh 0.1.5` pass

## Friction

None — single-line security fix + test.

## Follow-up

Closes #67.

## Next gate

FT296 — post-release Packagist + adversarial smoke on 0.1.5
