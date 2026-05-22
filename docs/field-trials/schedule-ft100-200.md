# Field Trial Schedule FT100–FT200

Extension of [`schedule-ft5-100.md`](schedule-ft5-100.md). **Quality-first:** each FT requires an individual report ([`quality-strategy.md`](quality-strategy.md)).

## Rotation matrix (FT19–FT200)

Same `FT mod 10` rotation as FT19–FT100. FT10–FT18 follow the detailed rows in [`schedule-ft5-100.md`](schedule-ft5-100.md) when executed via `tools/ft-individual.sh`.

| FT mod 10 | Theme | Runner suite |
| --- | --- | --- |
| 9, 19, … | Security review | `security-catalog` |
| 0, 10, … | Packagist regression | `packagist` |
| 1, 11, … | Multi-tool read | `multi-read` |
| 2, 12, … | About-only minimal | `about-only` |
| 3, 13, … | Misconfig adversarial | invalid catalog path |
| 4, 14, … | Write fail-closed | `write-failclosed` |
| 5, 15, … | Catalog edge cases | `security-catalog` |
| 6, 16, … | NeNe Docker golden | `smoke` |
| 7, 17, … | Fresh clone bootstrap | `packagist` |
| 8, 18, … | Combined milestone | `about-only` + `multi-read` |

Every **FT % 3 == 0** adds a **write-failclosed** security cadence probe in the individual report.

## Gates

| Gate | After | Action |
| --- | --- | --- |
| G3 | FT100, FT150, FT200 | Milestone regression summary (`milestones/`) — not FT completion |
| G5 | FT200 | Series reflection; evaluate v0.3.0 criteria |

## Automation

```bash
tools/ft-individual.sh 42          # one FT → one report file
tools/ft-range.sh 10 200           # batch with individual reports
tools/ft-cycle.sh 19 200           # regression log only (no reports)
```

See [`automation.md`](automation.md) and [`index-ft10-200.md`](index-ft10-200.md).
