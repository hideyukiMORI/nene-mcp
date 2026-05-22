# Field Trial Schedule FT5–FT100

Extension of [`schedule.md`](schedule.md). FT1–FT8 complete. **Quality-first:** each FT needs an individual report per [`quality-strategy.md`](quality-strategy.md).

## Rotation matrix (regression harness)

`tools/ft-cycle.sh` reuses these themes for **automated regression logs**—not as FT completion:

| FT mod 10 | Theme | Runner suite |
| --- | --- | --- |
| 9, 19, … | Security review | `security-catalog` + `write-failclosed` |
| 0, 10, … | Packagist regression | `packagist` |
| 1, 11, … | Multi-tool read | `multi-read` |
| 2, 12, … | About-only minimal | `about-only` |
| 3, 13, … | Misconfig adversarial | wrong base URL, bad catalog path |
| 4, 14, … | Write fail-closed | `write-failclosed` |
| 5, 15, … | Catalog edge cases | duplicate names, invalid JSON |
| 6, 16, … | NeNe Docker golden | `smoke` + health catalog |
| 7, 17, … | Host bootstrap | fresh clone + composer |
| 8, 18, … | Milestone batch log | aggregate metrics only |

## Planned trials FT5–FT18 (detailed)

| FT | Topic | Status |
| --- | --- | --- |
| FT5 | NeNe multi-tool read catalog | ✅ [report](2026-05-field-trial-5.md) |
| FT6 | Security review — catalog mistakes | ✅ [report](2026-05-field-trial-6.md) |
| FT7 | Vanilla PHP bridge (Pattern B) | ✅ [report](2026-05-field-trial-7.md) |
| FT8 | Packagist-only install regression | ✅ [report](2026-05-field-trial-8.md) |
| FT9 | Security — write fail-closed | ✅ [report](2026-05-field-trial-9.md) |
| FT10 | Bearer write end-to-end | ✅ [report](2026-05-field-trial-10.md) (automated; live session deferred) |
| FT11 | Misconfiguration adversarial | ✅ [report](2026-05-field-trial-11.md) |
| FT12 | Security milestone write | ✅ [report](2026-05-field-trial-12.md) |
| FT13–FT18 | Cross-platform + agent + milestone | ✅ [reports](index-ft10-200.md) |
| FT19–FT200 | Rotation regression band | ✅ [index](index-ft10-200.md) |

## Gates

| Gate | After | Action |
| --- | --- | --- |
| G2 | FT12 | Evaluate v0.2.0 |
| G3 | FT30, FT60, FT90 | Regression log summaries (optional) |
| G4 | FT18, FT100 | Series reflection |

## Automation

```bash
tools/ft-runner.sh smoke /path/to/tools.json
tools/ft-runner.sh multi-read /path/to/tools.json
tools/ft-runner.sh packagist
```

See [`automation.md`](automation.md).
