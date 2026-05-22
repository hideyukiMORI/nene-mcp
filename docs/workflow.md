# Development Workflow

nene-mcp uses an Issue-first workflow aligned with NeNe, NENE2, and nene2-python strict governance.

Project purpose: `docs/project.md`.

**Issues, PRs, and commits are English only** (`docs/development/language-policy.md`).

## Standard flow

1. Create or reuse a focused GitHub Issue (motivation + acceptance criteria).
2. Confirm context in `docs/todo/current.md` when work spans sessions.
3. Create branch `type/issue-number-summary` from `main`.
4. Implement the smallest useful change; update docs when behavior or policy shifts.
5. Review applicable self-review checklist in `docs/review/`.
6. Run verification (`composer test` minimum; `composer check` when configured).
7. Commit with Conventional Commits; reference Issue `#number`.
8. Push and open PR linked to Issue (`Closes #number` when fully resolved).
9. Merge after review and green CI.

## Field trials

Continuous integration quality practice inherited from NeNe, NENE2, and nene2-python.

- Methodology: `docs/field-trials/README.md`
- ADR: `docs/adr/0001-adopt-field-trial-methodology.md`
- Report template: `docs/templates/field-trial-report.md`
- Before publishing a report: `docs/review/field-trial-report.md`

Rules:

- Run trials from external clones under `../nene-mcp-FT/ft{N}-{topic}/`.
- Record friction as `F-N`; file Issues; **close all actionable Issues before starting the next FT**.
- FT `{N}` where **`N % 3 == 0`** includes MCP security review in the report.

## Branch names

```text
feat/12-catalog-validation
fix/34-http-base-url-trailing-slash
docs/1-neNe-integration-guide
ci/8-add-phpstan
```

## PR requirements

Every PR must include:

- **Purpose** — why the change exists
- **Summary** — what changed
- **Verification** — commands run and results
- **Self-review** — checklist names used (e.g. `mcp-server`)
- **Issue link** — `Closes #n` when complete
- **Risks / follow-ups** — when non-obvious

Use `.github/pull_request_template.md`.

## Scope control

Do not mix in one PR:

- MCP protocol changes + unrelated docs rewrites
- Security fixes + dependency major bumps
- CI setup + feature work
- Formatting-only sweeps + behavior changes

Open a follow-up Issue instead of expanding scope.

## Principles

1. MCP tools call **documented HTTP** or ship as **built-in read-only inspectors** (`nene_mcp_about`).
2. Stdio MCP uses newline-delimited JSON-RPC, consistent with NENE2 local MCP conventions.
3. Strict coding standards are mandatory (`docs/development/coding-standards.md`).
4. Security policy is not negotiable (`docs/development/security-policy.md`).

## AI agent responsibilities

When completing work end-to-end:

- Create or reuse Issue and branch
- Edit only relevant files
- Run checklists in `docs/review/`
- Verify with documented commands
- Do not commit secrets or claim checks passed without running them

If the user asks for investigation-only or no-commit scope, honor that.

## Related policies

| Topic | Document |
| --- | --- |
| Coding standards | `docs/development/coding-standards.md` |
| Language | `docs/development/language-policy.md` |
| Quality tools | `docs/development/quality-tools.md` |
| Security | `docs/development/security-policy.md` |
| Self-review policy | `docs/development/self-review.md` |
| ADRs | `docs/development/adr.md` |
| **Field trials** | `docs/field-trials/README.md` |
| Commits | `docs/development/commit-conventions.md` |
