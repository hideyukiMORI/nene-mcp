# Field Trial 337 — F-7 doc callout (safety mislabel)

## Date

2026-05-22

## Baseline

- nene-mcp ref: `v0.1.5` @ main
- Prior defer: F-7 in [`follow-ups.md`](follow-ups.md) (FT262+ L6 variant 6)

## Goal

Close docs-gap F-7: document that Bearer-protected POST marked `safety: read` skips fail-closed.

## Persona

**Security-conscious integrator** — reads write-tools-bearer + catalog-format before cataloging inventory API.

## Documentation delivered (#71)

| Doc | Change |
| --- | --- |
| `howto/write-tools-bearer` | § Safety label vs HTTP method (en + ja/fr/zh/de/pt-br) |
| `reference/catalog-format` | § Safety vs HTTP method table |
| `howto/catalog-smoke-test` | Common failure row for POST 401 |
| `howto/bearer-native-bridge-example` | Checklist item 4 |
| `integration/README` | POST/PUT auth bullet |
| `explanation/security-model` | Operator responsibility |

## Probe verification (unchanged behavior)

Mock API `:9090`, catalog POST `/api/inventory/items` with `"safety": "read"`:

| Step | Expectation | Actual | Status |
| --- | --- | --- | --- |
| No env Bearer | HTTP 401 (not JSON-RPC fail-closed) | 401, `isError: true` | Pass — documented |
| With env Bearer | HTTP 201/200 | 201 | Pass |
| `"safety": "write"` without Bearer | JSON-RPC fail-closed | requires bearer | Pass (contrast) |

## Friction Summary

| ID | Location | Severity | Kind | Decision |
| --- | --- | --- | --- | --- |
| F-7 | write-tools-bearer / catalog-format | medium | docs-gap | **document** — #71 closed |

## Follow-up Issues

Closes #71.

## Overall Impression

F-7 was real operator confusion, not a package bug — docs now explain fail-closed scope vs API-enforced Bearer on mislabeled reads. L6 probe can stay; expect FINDING line until docs ship (this FT).

## Next gate

FT338+ — NeNe #380 or next adversarial band when friction appears.
