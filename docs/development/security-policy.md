# Security Policy (Development)

Public summary: [`SECURITY.md`](../../SECURITY.md).  
This document is the **source of truth** for implementers and reviewers.

Inherited from NENE2 MCP / local AI command guidance and nene2-python security bans, adapted for a stdio HTTP bridge.

## Threat model

nene-mcp runs as a **local child process** of an MCP host (Cursor, Claude Desktop, etc.). It:

- Reads JSON-RPC from stdin
- May call HTTP APIs on `NENE_MCP_API_BASE_URL`
- Must not become a generic exfiltration or shell gateway

Assume the MCP host and local developer machine are trusted; **remote HTTP targets and catalog contents are not**.

## Hard rules

| Rule | Rationale |
| --- | --- |
| No secrets in Git | Tokens, passwords, `.env`, private keys |
| Bearer only via `NENE_MCP_BEARER_TOKEN` env | Keeps catalogs shareable |
| No reading `.env` files from disk | Env injection is the host's job |
| No arbitrary filesystem tools | Unless scoped Issue + review |
| No `shell_exec`, `exec`, `passthru`, backticks | Prevents command injection |
| No production URLs in docs/examples by default | Local dev / verification only |
| No logging tokens or full Authorization headers | Stderr must stay safe |
| `nene_mcp_about` exposes metadata only | Never echo bearer or env secrets |

## Catalog safety

- Honor `safety: read` vs `safety: write` in catalog entries.
- Write tools may require Bearer—document in integration guides, not in committed tokens.
- Reject catalog paths outside explicit env configuration (no catalog-driven path traversal).
- Validate JSON catalog shape before exposing tools to MCP clients.

## HTTP client

- Restrict requests to configured base URL + catalog path (no open redirect following to third parties without design).
- Use TLS verification for `https://` targets; do not disable cert checks in production code paths.
- Time out long-running requests; do not hang stdio loop indefinitely.

## MCP host configuration

Document for integrators:

- Absolute paths to `vendor/bin/nene-mcp` and `tools.json`
- Env vars set in MCP host config—not in repo
- Separate dev tokens per machine

## Reporting

Use [GitHub private security advisories](https://github.com/hideyukiMORI/nene-mcp/security/advisories/new) for vulnerabilities. Do not open public Issues for exploitable details before coordinated disclosure.

## Review trigger

Any change touching auth, HTTP client, catalog loading, or stdio protocol requires **`docs/review/mcp-server.md`** self-review before merge.
