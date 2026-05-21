# Contributing

`hideyukiMORI/nene-mcp` follows the NeNe / NENE2 cooperation style: Issues first, narrow PRs, Conventional Commits.

**Write Issues, PR titles/descriptions, and commit messages in English** so the project stays accessible to international contributors and users.

## Reading

| Topic | Document |
| --- | --- |
| Project purpose | `docs/project.md` |
| Doc index | `docs/README.md` |
| NeNe integration | `docs/integration/nene.md` |
| Other platforms | `docs/integration/other-platforms.md` |
| Workflow | `docs/workflow.md` |
| Commit conventions | `docs/development/commit-conventions.md` |
| MCP behavior | `README.md`, `SECURITY.md` |

## Flow

1. Create or confirm a GitHub Issue (English).
2. Branch from `main` as `type/issue-number-summary`.
3. Keep the change focused (behavior, docs, or CI—not all at once unless unavoidable).
4. Run `composer test`.
5. Open a PR referencing the Issue with intent, verification steps, and follow-up risks (English).
6. Do not commit `.env`, tokens, passwords, vendor trees, or local cache artifacts.

## Pull request checklist

- [ ] Linked Issue (`Closes #n` when fully resolved)
- [ ] `composer test` passes
- [ ] Docs updated when behavior or configuration changed
- [ ] No secrets or local paths committed
