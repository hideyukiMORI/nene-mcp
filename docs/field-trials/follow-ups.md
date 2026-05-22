# Field Trial Follow-ups

Deferred findings and `defer` decisions from field trials. Searchable when a later FT revisits the same surface.

| FT | F-ID | Summary | Decision | Notes |
| --- | --- | --- | --- | --- |
| FT3 | F-1 | Catalog paths not restricted to leading `/` | defer | No cross-host escape observed; [2026-05-field-trial-3.md](2026-05-field-trial-3.md) |
| FT4 | F-2 | Invalid `TOOLS_JSON` path fails entire `tools/list` | defer | Fail-loud by design; [2026-05-field-trial-4.md](2026-05-field-trial-4.md) |
| FT201–294 | FT204 | NeNe TODO session cookie + CSRF — stock E2E blocked over MCP | fix-in-host | [NeNe #380](https://github.com/hideyukiMORI/NeNe/issues/380); re-verified FT225–294 |
| FT255 | F-3 | Whitespace-only Bearer bypassed write fail-closed | fix-in-package | #64 — fixed; trim in `McpEnvironment` |
| FT262+ | F-7 | `safety:read` on Bearer-protected POST skips fail-closed | document | **Resolved #71** — [write-tools-bearer § safety vs method](/howto/write-tools-bearer#safety-label-vs-http-method); FT337 |
| FT6 | F-1 | Duplicate tool names in catalog | fix-in-package | #22 — fixed v0.1.3; [FT9](2026-05-field-trial-9.md) |

When filing a deferred row, link the report path and optional GitHub Issue.
