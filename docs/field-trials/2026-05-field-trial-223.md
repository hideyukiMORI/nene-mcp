# Field Trial 223 — Release v0.1.4 (docs + PHPUnit)

## Date

2026-05-22

## Baseline

- Prior tag: `v0.1.3`
- Persona band FT201–222 merged; open Issues: 0

## Goal

Ship patch release documenting persona-band docs and FT219 PHPUnit regression tests.

## Verification (pre-tag)

| Check | Result |
| --- | --- |
| `composer validate` | Pass |
| `composer test` (12 tests) | Pass |
| `tools/ft-runner.sh` suites | Pass (FT222) |
| `Package.php` VERSION | `0.1.4` |
| CHANGELOG | 0.1.4 section |

## Post-tag

- [x] GitHub Release `v0.1.4` published — https://github.com/hideyukiMORI/nene-mcp/releases/tag/v0.1.4
- [x] `tools/packagist-verify.sh 0.1.4` pass
- [x] Release verify workflow green (PR #59 merge)

## Friction

None expected — docs-heavy patch.

## Follow-up

Closes #58.

## Next gate

FT224 — post-release Packagist + docs site persona smoke
