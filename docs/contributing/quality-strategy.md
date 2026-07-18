# Quality strategy

Field trials are one **quality instrument**. The goal is better product quality and assurance — not FT counts or green automation counters alone.

## Instruments

| Instrument | Output |
| --- | --- |
| Individual FT report | private `nene-origin/internal-docs/mcp/field-trials/YYYY-MM-field-trial-{N}.md` |
| GitHub Issue | Actionable friction |
| PHPUnit + CI | Regression safety net |
| `tools/ft-runner.sh` | Repeatable smoke |

## FT complete means

- Report merged
- Friction table filled; security section when `N % 3 == 0`
- Actionable Issues closed or deferred in private `nene-origin/internal-docs/mcp/field-trials/follow-ups.md`
- Tests added when behavior must not regress

## Source of truth

Full document: private `nene-origin/internal-docs/mcp/field-trials/quality-strategy.md`.

## Contributing

See `docs/CONTRIBUTING.md` and `docs/workflow.md` for Issue-driven workflow and Conventional Commits.
