# Agent / Automation Guide for nene-mcp

Strict governance inherited from **NENE2** and **nene2-python** (issue-driven, typed boundaries, self-review, English-only public surface). Adapted for a small PHP MCP library.

## Purpose (read first)

nene-mcp is a **Composer plugin-style MCP bridge** for the NeNe ecosystem: apps `composer require hideyukimori/nene-mcp` and point Cursor (or other MCP hosts) at `vendor/bin/nene-mcp`—without forking NeNe or embedding MCP in framework core.

Full context: `docs/project.md`

> **Operational logs moved to the private mirror (P3, 2026-07-18).** `docs/todo`,
> `docs/reports/daily`, and field-trials (individual reports, milestones, indexes)
> now live in private `nene-origin/internal-docs/mcp/`. Read the latest work status
> and handoff there. The public repo keeps only Diátaxis docs (tutorial / how-to /
> reference / explanation) plus ADR and CHANGELOG.

## Required reading

| Topic | Path |
| --- | --- |
| Project overview | `docs/project.md` |
| Documentation index | `docs/README.md` |
| Workflow | `docs/workflow.md` |
| **Coding standards** | `docs/development/coding-standards.md` |
| **Language policy** | `docs/development/language-policy.md` |
| **Quality tools** | `docs/development/quality-tools.md` |
| **Security policy** | `docs/development/security-policy.md` |
| **Self-review policy** | `docs/development/self-review.md` |
| **Field trials** | private `nene-origin/internal-docs/mcp/field-trials/README.md` |
| **Release policy** | `docs/development/release-policy.md` |
| FT report checklist | `docs/review/field-trial-report.md` |
| MCP server checklist | `docs/review/mcp-server.md` |
| NeNe integration | `docs/integration/nene.md` |
| Other platforms | `docs/integration/other-platforms.md` |
| Commits | `docs/development/commit-conventions.md` |
| Contributions | `docs/CONTRIBUTING.md` |

## Sibling repos (reference only)

| Repo | Use |
| --- | --- |
| `../NENE2/docs/development/` | Strict PHP/API governance model |
| `../nene2-python/CLAUDE.md` | Strict typing, pre-PR checks, security bans |
| `../NeNe/docs/project.md` | NeNe host philosophy, OpenAPI |

Do not import sibling code. Link policies instead of duplicating full framework rules.

## Operating rules

1. **Issue-driven** — no substantive edit without a GitHub Issue.
2. **Branch** — `type/issue-number-summary`; never commit directly to `main`.
3. **English only** — Issues, PRs, commits, public docs (`docs/development/language-policy.md`).
4. **Self-review** — run `docs/review/*.md` checklists before PR; name them in the PR body.
5. **Verify** — `composer test` minimum; `composer check` when configured.
6. **Secrets** — never commit tokens, `.env`, or bearer values.
7. **Boundaries** — MCP stays in this package; no NeNe `class/xion/` changes from here.
8. **Docs first** — when Cursor rules and `docs/` conflict, update `docs/` first.
9. **Field trials** — validate integrations externally; record `F-N` friction; close Issues before the next FT (private `nene-origin/internal-docs/mcp/field-trials/README.md`).

## MCP-specific rules

- Wire: newline JSON-RPC; methods `initialize`, `tools/list`, `tools/call`.
- Tools: documented HTTP via catalog, or read-only `nene_mcp_about`.
- No filesystem/shell tools without Issue + security review.
- Env access only in `McpEnvironment`.

## Project direction

Stay small, strict, and AI-readable—like NENE2/nene2-python, but as a standalone HTTP→MCP bridge package.
