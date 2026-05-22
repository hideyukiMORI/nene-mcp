# Field trials

nene-mcp inherits **Field Trial (FT)** methodology from NeNe, NENE2, and nene2-python.

## Purpose

Small, time-boxed integration exercises from a fresh setup. Every friction point becomes a GitHub Issue driving package or documentation changes.

**Goal:** raise product quality — not ship the trial app.

## Quality-first (FT9+)

- **One FT → one report file**
- Automation (`ft-runner.sh`) supplements FT — does not replace individual reports
- PHPUnit + CI catch regressions between trials

## For contributors

Full methodology, schedules, and report templates live in the repository:

- `docs/field-trials/README.md`
- `docs/field-trials/quality-strategy.md`
- `docs/templates/field-trial-report.md`

## Status

FT1–FT200 individual reports exist in the repository. See `docs/field-trials/index-ft10-200.md` for the FT10–FT200 index.

## Run automation locally

```bash
tools/ft-individual.sh 42
tools/ft-range.sh 10 20
tools/ft-runner.sh smoke /path/to/tools.json
```
