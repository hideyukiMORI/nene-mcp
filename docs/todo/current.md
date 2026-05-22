# Current work

## Release

- **v0.1.3** — pending merge (PR #24): duplicate names, FT9 quality
- **v0.3.0** — evaluate after FT200 gate ([milestone](field-trials/milestones/2026-05-ft200-gate.md))

## Field trials

| Range | Status |
| --- | --- |
| FT1–FT9 | ✅ Individual reports |
| FT10–FT200 | ✅ Individual reports ([index](field-trials/index-ft10-200.md)) |

Methodology: [`quality-strategy.md`](field-trials/quality-strategy.md)

## Automation

- `tools/ft-individual.sh` — one FT → one report
- `tools/ft-range.sh` — batch with reports
- `tools/ft-runner.sh` — suites (CI wired)

## Open manual follow-ups

- Bearer write **live** e2e with NeNe session (automated fail-closed only in FT10 band)
- Cross-platform host FTs on demand (FT13–17 themes partially automated)

## Next

Merge PR #24 + #25; tag v0.1.3; optional v0.3.0 planning.
