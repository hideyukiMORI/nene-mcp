# nene-mcp Project Overview

nene-mcp is an **MCP (Model Context Protocol) bridge for the NeNe ecosystem**.  
Add it with **`composer require`**—no NeNe fork or source import—to expose local HTTP APIs as MCP tools for AI agents (Cursor, Claude Desktop, etc.).

## Philosophy inherited from NeNe

[NeNe](https://github.com/hideyukiMORI/NeNe) targets a **small PHP framework that legacy-minded developers can read end to end** (see NeNe `docs/project.md`). Core principles:

- Small, explicit, reviewable by humans and AI
- OpenAPI for public HTTP contracts
- Issue-driven work, Conventional Commits, narrow PRs
- Preserve URL → controller conventions instead of replacing them with a large full-stack framework

nene-mcp extends that line:

| NeNe idea | nene-mcp mapping |
| --- | --- |
| OpenAPI is the API contract | `docs/mcp/tools.json` is the MCP tool contract |
| Keep framework core small | MCP lives in a separate Composer package (this repo) |
| Conventions stay visible for AI-assisted dev | stdio MCP + committed JSON catalog |
| Modern Composer-based PHP | Plugin-style add via `composer require hideyukimori/nene-mcp` |

NeNe repository: <https://github.com/hideyukiMORI/NeNe>  
NeNe overview (local clone): `../NeNe/docs/project.md`

## Problems this project solves

1. **Add MCP to a NeNe app** without mixing MCP dependencies into framework core
2. **Call local NeNe REST** from Cursor / Claude Desktop via tool invocations
3. **Reuse NENE2-compatible** `tools.json` format and environment variable aliases
4. **Bridge non-NeNe APIs** (vanilla PHP, Laravel, other languages) with the same stdio server

## Architecture (overview)

```text
┌─────────────────┐     stdio JSON-RPC      ┌──────────────────┐
│  MCP client     │ ◄──────────────────────► │  bin/nene-mcp    │
│  (Cursor, etc.) │                         │  (PHP process)   │
└─────────────────┘                         └────────┬─────────┘
                                                     │ HTTP
                                                     ▼
                                            ┌──────────────────┐
                                            │  Your app        │
                                            │  (NeNe / other)  │
                                            └──────────────────┘
```

- **MCP wire**: newline-delimited JSON-RPC (`initialize` / `tools/list` / `tools/call`)
- **Tool definitions**: built-in `nene_mcp_about` + optional `tools.json` (OpenAPI-derived entries)
- **Execution**: HTTP requests to catalog method/path (Bearer from env only)

Your app exposes HTTP. nene-mcp owns the stdio MCP loop.

## Scope and non-goals

**In scope**

- Composer library distribution
- NeNe / NENE2 documentation and sample catalogs
- stdio MCP server started with environment variables only
- Generic **HTTP → MCP bridge** docs for other frameworks, vanilla PHP, and other languages

**Out of scope**

- Changing NeNe routing or controller conventions
- Forking or embedding MCP hosts (Cursor, etc.)
- Cloud MCP provider–specific SDKs
- Large in-process MCP integrations (keep the stdio child-process model)

## Related repositories

| Repository | Relationship |
| --- | --- |
| [NeNe](https://github.com/hideyukiMORI/NeNe) | Primary host. Ships OpenAPI + `docs/mcp/tools.json` |
| [NENE2](https://github.com/hideyukiMORI/NENE2) | Reference for `tools.json` format and env aliases |
| nene-mcp (this repo) | stdio MCP implementation. No NeNe runtime dependency |

## Documentation index

- Integration overview: `docs/integration/README.md`
- NeNe setup: `docs/integration/nene.md`
- Other platforms: `docs/integration/other-platforms.md`
- Sample catalog: `docs/example-ne-health-catalog.md`
- Development workflow: `docs/workflow.md`

## Governance (strict)

Inherited from NENE2 and nene2-python, tightened for an English-first international package:

| Policy | Document |
| --- | --- |
| Coding standards | `docs/development/coding-standards.md` |
| Language (English only) | `docs/development/language-policy.md` |
| Quality tools | `docs/development/quality-tools.md` |
| Security | `docs/development/security-policy.md` |
| Self-review | `docs/development/self-review.md` + `docs/review/` |
| ADRs | `docs/development/adr.md` |
| Field trials | `docs/field-trials/README.md` |

## Release and distribution

| Policy | Document |
| --- | --- |
| Versioning, tags, Packagist | `docs/development/release-policy.md` |
| Pre-tag checklist | `docs/development/release-checklist.md` |
| First tag (`v0.1.0`) prep | `docs/development/release-v0.1.0-prep.md` |

Tag **`v0.1.0` before FT1**; Packagist after early FTs. See release policy.
