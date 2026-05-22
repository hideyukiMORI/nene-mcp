# Contributing

`hideyukiMORI/nene-mcp` follows strict governance inherited from NeNe, NENE2, and nene2-python: **Issues first, narrow PRs, English only, self-review before merge**.

## Required reading

| Topic | Document |
| --- | --- |
| Workflow | `docs/workflow.md` |
| Coding standards | `docs/development/coding-standards.md` |
| Language policy | `docs/development/language-policy.md` |
| Quality tools | `docs/development/quality-tools.md` |
| Security | `docs/development/security-policy.md` |
| Self-review | `docs/development/self-review.md` |
| Field trials | `docs/field-trials/README.md` |
| Commit conventions | `docs/development/commit-conventions.md` |
| Project purpose | `docs/project.md` |

## Flow

1. Create or confirm a GitHub Issue (**English**).
2. Branch from `main` as `type/issue-number-summary`.
3. Implement a focused change; update docs when behavior or policy changes.
4. Complete applicable checklist in `docs/review/`.
5. Run `composer test` (or `composer check` when available).
6. Open a PR with purpose, verification, self-review checklist names, and `Closes #n`.
7. Do not commit `.env`, tokens, passwords, `vendor/`, or local cache.

## Pull request checklist

- [ ] Linked Issue (`Closes #n` when fully resolved)
- [ ] English title and description
- [ ] Self-review checklist noted (e.g. `mcp-server`)
- [ ] `composer test` passes
- [ ] Docs / ADR updated when contracts or policy changed
- [ ] No secrets or machine-local paths committed

## Scope

One coherent change per PR. See `docs/workflow.md` for what not to mix.
