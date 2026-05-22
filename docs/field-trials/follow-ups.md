# Field Trial Follow-ups

Deferred findings and `defer` decisions from field trials. Searchable when a later FT revisits the same surface.

| FT | F-ID | Summary | Decision | Notes |
| --- | --- | --- | --- | --- |
| FT3 | F-1 | Catalog paths not restricted to leading `/` | defer | No cross-host escape observed; [2026-05-field-trial-3.md](2026-05-field-trial-3.md) |
| FT4 | F-2 | Invalid `TOOLS_JSON` path fails entire `tools/list` | defer | Fail-loud by design; [2026-05-field-trial-4.md](2026-05-field-trial-4.md) |
| FT6 | F-1 | Duplicate tool names in catalog | fix-in-package | #22 — fixed v0.1.3; [FT9](2026-05-field-trial-9.md) |

When filing a deferred row, link the report path and optional GitHub Issue.
