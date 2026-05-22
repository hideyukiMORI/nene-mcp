# Field Trial 379 — Release v0.1.6 (F-7 docs)

## Date

2026-05-22

## Baseline

- Prior tag: `v0.1.5`
- F-7 docs #71 merged; FT339–378 L6 band green

## Goal

Doc-only patch release for safety mislabel documentation.

## Verification (pre-tag)

| Check | Result |
| --- | --- |
| `composer validate` | Pass |
| `composer test` (13 tests) | Pass |
| `Package.php` VERSION | `0.1.6` |
| CHANGELOG | 0.1.6 section |

## Post-tag

- [ ] GitHub Release `v0.1.6` published
- [ ] `tools/packagist-verify.sh 0.1.6` pass

## Friction

None — docs-only semver patch.

Closes #75.

## Next

FT380 — post-release smoke on 0.1.6
