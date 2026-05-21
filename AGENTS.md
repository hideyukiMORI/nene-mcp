# Agent / Automation Guide for nene-mcp

This repository mirrors the governance style of NeNe and NENE2.

## Purpose (read first)

nene-mcp is a **Composer plugin-style MCP bridge** for the NeNe ecosystem: apps `composer require hideyukimori/nene-mcp` and point Cursor (or other MCP hosts) at `vendor/bin/nene-mcp`—without forking NeNe or embedding MCP in framework core. The same stdio server works for other PHP stacks, vanilla PHP, and non-PHP HTTP APIs via `tools.json`.

Full context: `docs/project.md`

## Required reading

| Topic | Path |
| --- | --- |
| Project overview | `docs/project.md` |
| Documentation index | `docs/README.md` |
| NeNe integration | `docs/integration/nene.md` |
| Other platforms | `docs/integration/other-platforms.md` |
| Workflow | `docs/workflow.md` |
| Commits | `docs/development/commit-conventions.md` |
| Contributions | `docs/CONTRIBUTING.md` |

## NeNe reference (sibling repo)

When changing NeNe-facing examples or OpenAPI alignment, consult NeNe docs—not this repo's framework code:

| NeNe doc | Use |
| --- | --- |
| `../NeNe/docs/project.md` | Framework philosophy, routing |
| `../NeNe/docs/api/README.md` | OpenAPI policy |
| `../NeNe/AGENTS.md` | NeNe agent rules |

## Rules

1. Issue-driven changes: open or reuse a GitHub Issue before substantive edits.
2. Branch names follow `type/issue-number-summary`.
3. Conventional Commit messages in English (`docs/development/commit-conventions.md`).
4. Write Issues and PRs in English.
5. No secrets or local credentials in commits.
6. Keep MCP implementation in this package; do not assume NeNe core changes for MCP features.
