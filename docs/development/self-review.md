# Self-Review Checklist Policy

Inherited from [NENE2 self-review policy](https://github.com/hideyukiMORI/NENE2/blob/main/docs/development/self-review.md).

## Position

Policy docs spread across `docs/development/`. Checklists are the **final reminder layer** before push or PR so strict rules are not missed.

## Rules

- Checklists live in `docs/review/`.
- Review every applicable item; mark non-applicable items as `N/A` mentally—do not delete checklist rows to pass.
- Mention checklist names in PR body when practical.
- Checklists link to policy docs; they do not replace them.
- AI agents must run the relevant checklist before claiming a PR is ready.

## Before push or PR

1. Identify work type (MCP code, docs, CI, release).
2. Open matching checklist(s).
3. Run narrowest verification (`composer test` minimum; `composer check` when available).
4. Note in PR: `Self-review: mcp-server` (example).

## Checklist index

| File | Use when |
| --- | --- |
| [`mcp-server.md`](../review/mcp-server.md) | Protocol, catalog, HTTP client, bootstrap, env |
| [`docs-policy.md`](../review/docs-policy.md) | Policy docs, workflow, ADRs, README |
| [`release-ci.md`](../review/release-ci.md) | CI, composer scripts, PHP matrix |
| [`field-trial-report.md`](../review/field-trial-report.md) | Before publishing FT reports |

Add new checklists only when a work type repeats enough to justify one.

## Non-goals

- Replacing PHPUnit or CI
- Long compliance forms
- Checklists for one-line typo fixes (use judgment)
