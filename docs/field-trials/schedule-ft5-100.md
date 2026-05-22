# Field Trial Schedule FT5–FT100

Extension of [`schedule.md`](schedule.md). FT1–FT4 complete. **Autonomous cycle:** run FT → record friction → Issue/PR → next FT.

## Rotation matrix (FT19–FT100)

After FT18 milestone, FT19+ reuse automated suites via `tools/ft-runner.sh` with rotating emphasis:

| FT mod 10 | Theme | Runner suite |
| --- | --- | --- |
| 9, 19, … | Security review | `security-catalog` + redirect/bearer probes |
| 0, 10, … | Packagist regression | `packagist` |
| 1, 11, … | Multi-tool read | `multi-read` |
| 2, 12, … | About-only minimal | `about-only` |
| 3, 13, … | Misconfig adversarial | wrong base URL, bad catalog path |
| 4, 14, … | Write fail-closed | `write-failclosed` |
| 5, 15, … | Catalog edge cases | duplicate names, invalid JSON |
| 6, 16, … | NeNe Docker golden | `smoke` + health catalog |
| 7, 17, … | Host bootstrap | fresh clone + composer |
| 8, 18, … | Milestone batch report | aggregate F-N, defer review |

Every **10 FTs** publish a batch summary: `docs/field-trials/milestones/ft{N}-ft{N+9}-batch.md`.

## Planned trials FT5–FT18 (detailed)

| FT | Topic | Status |
| --- | --- | --- |
| FT5 | NeNe multi-tool read catalog | pending |
| FT6 | Security review — catalog mistakes | pending |
| FT7 | Vanilla PHP bridge (Pattern B) | pending |
| FT8 | Packagist-only install regression | pending |
| FT9 | Security — write fail-closed | pending |
| FT10 | Bearer write end-to-end | pending |
| FT11 | Misconfiguration adversarial | pending |
| FT12 | Security milestone write | pending |
| FT13–FT18 | Cross-platform + agent + milestone | pending |

## Gates

| Gate | After | Action |
| --- | --- | --- |
| G2 | FT12 | Evaluate v0.2.0 |
| G3 | FT30, FT60, FT90 | Batch milestone reports |
| G4 | FT18, FT100 | Series reflection |

## Automation

```bash
tools/ft-runner.sh smoke /path/to/tools.json
tools/ft-runner.sh multi-read /path/to/tools.json
tools/ft-runner.sh packagist
```

See [`automation.md`](automation.md).
