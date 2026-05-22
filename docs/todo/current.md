# Current work

## Release

- **v0.1.2** — Packagist (redirect SSRF fix)
- **v0.1.3** — pending: duplicate catalog names (#22), FT9 quality work

## Field trials

| Range | Status |
| --- | --- |
| FT1–FT8 | ✅ Individual reports |
| FT9 | ✅ [Individual report](field-trials/2026-05-field-trial-9.md) |
| FT10+ | Individual reports required ([quality-strategy](field-trials/quality-strategy.md)) |

Batch logs under `field-trials/milestones/` are regression-only—not FT completion.

## Quality instruments

- [`quality-strategy.md`](field-trials/quality-strategy.md)
- `tools/ft-runner.sh` — regression suites (CI wired)
- PHPUnit — catalog validation, write fail-closed

## Open

- FT10 — Bearer write end-to-end (NeNe session)

## Next

FT10 after #22 merge and v0.1.3 tag.
