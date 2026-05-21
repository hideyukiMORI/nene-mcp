# Development Workflow

nene-mcp uses an Issue-first workflow aligned with NeNe and NENE2.

Project purpose and NeNe relationship: `docs/project.md`.

**Issues, PRs, and commits are written in English.**

## Typical flow

1. Create or reuse a GitHub Issue describing motivation and acceptance criteria (English).
2. Create branch `type/issue-number-summary`.
3. Implement scoped changes plus documentation when behavior or configuration shifts.
4. Run `composer test` before opening or updating a PR.
5. Mention the Issue in PR body (`Closes #n` when fully resolved).

## Principles

1. MCP tools call **documented HTTP** or ship as **built-in read-only inspectors** (`nene_mcp_about`).
2. Stdio MCP uses newline-delimited JSON-RPC, consistent with sibling NENE2 local MCP conventions.
