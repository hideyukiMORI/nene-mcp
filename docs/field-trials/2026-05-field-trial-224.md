# Field Trial 224 — Post-release v0.1.4 smoke

## Date

2026-05-22

## Baseline

- Tag: `v0.1.4` (GitHub Release published)
- Prior FT: FT223 release gate

## Goal

Confirm Packagist, harness, and live docs site after v0.1.4 ship.

## Packagist

| Check | Result |
| --- | --- |
| `tools/packagist-verify.sh 0.1.4` | **Pass** — installed `0.1.4`, `tools/list` smoke |
| `tools/ft-runner.sh packagist` | **Pass** — fresh `composer require hideyukimori/nene-mcp:^0.1` |

## Harness (main @ v0.1.4)

| Suite | Result |
| --- | --- |
| `packagist-verify.sh 0.1.4` | Pass |
| `smoke` (ft1 health catalog) | Pass |
| `write-failclosed` | Pass |
| `security-catalog` | Pass |
| `composer test` (12 tests) | Pass |

## Live docs (GitHub Pages)

| URL | Result |
| --- | --- |
| `/howto/neene-catalog-patterns` | **Pass** — session cookie, CSRF, `id_{id}`, URI_ROOT |
| `/howto/bearer-native-bridge-example` | **Pass** — FT206 inventory pattern |
| `/reference/catalog-format` | **Pass** — GET query parameters section |

Nav shows `v0.1.4` after Pages deploy from release merge.

## Friction

None — docs-heavy patch release verified end-to-end.

## Deliverables

- Persona index FT223 + FT224 rows
- `docs/todo/current.md` — v0.1.4 shipped

## Next

Await NeNe [#380](https://github.com/hideyukiMORI/NeNe/issues/380) for Bearer E2E on stock NeNe TODO; FT225+ persona band as needed.

Closes #60.
