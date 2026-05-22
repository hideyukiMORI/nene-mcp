# Field Trial 219 — PHPUnit: GET query + NeNe path regression

## Date

2026-05-22

## Goal

Lock FT217 query-string behavior and NeNe `id_{id}` path interpolation in PHPUnit so docs-backed behavior cannot regress silently.

## Tests added

| Test | Asserts |
| --- | --- |
| `testGetToolAppendsRemainingArgumentsAsQueryString` | `GET /api/items?sku=WIDGET-1&limit=10` |
| `testGetToolInterpolatesNeNeStylePathSegments` | `GET /todo/item/id_42` |

## Security Review (219 % 3 == 0)

- [x] Tests use stub HTTP client — no network SSRF
- [x] No secrets in test fixtures
- **Result**: Pass

## Friction

None — quality instrument only.

## Follow-up

Merged with integration README + i18n CSRF (#53).
