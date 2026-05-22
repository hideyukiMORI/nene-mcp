[![CI](https://github.com/hideyukiMORI/nene-mcp/actions/workflows/ci.yml/badge.svg)](https://github.com/hideyukiMORI/nene-mcp/actions/workflows/ci.yml)
[![Docs](https://github.com/hideyukiMORI/nene-mcp/actions/workflows/docs.yml/badge.svg)](https://hideyukimori.github.io/nene-mcp/)

# nene-mcp

A small PHP library that adds **stdio MCP (Model Context Protocol)** to [NeNe](https://github.com/hideyukiMORI/NeNe) apps with a single **`composer require`**—no NeNe fork, no MCP code in framework core.

Developers familiar with legacy PHP can run it with **Composer and environment variables only**. It works **standalone** without importing NeNe or NENE2 source. Any HTTP API—Laravel, vanilla PHP, Node, etc.—can use the same bridge when you provide a NENE2-compatible `docs/mcp/tools.json`.

**Learn more:** [Documentation site](https://hideyukimori.github.io/nene-mcp/) · [docs/project.md](docs/project.md) · [NeNe integration](docs/integration/nene.md)

## Features

- **Standalone**: built-in read-only tool `nene_mcp_about` out of the box.
- **NENE2-compatible wire**: newline-delimited JSON-RPC with `initialize` / `tools/list` / `tools/call`.
- **Committed catalog JSON** (optional) adds OpenAPI-aligned tool entries.
- **Security defaults**: write fail-closed, no redirect following, catalog validation (`safety: read|write`).
- **SMB / staging operators** (v0.1.8+): configurable HTTP timeout, optional TLS CA bundle, opt-in stderr HTTP log — see [SMB adoption checklist](https://hideyukimori.github.io/nene-mcp/explanation/smb-adoption-checklist).
- Shared **[Issue-driven workflow + Conventional Commits](docs/development/commit-conventions.md)** with NeNe and NENE2.

**Scope:** MCP sidecar for developers and small teams (Cursor, Claude Desktop, internal staging)—not a customer-facing API gateway. See [Commercial use & scope](https://hideyukimori.github.io/nene-mcp/explanation/commercial-use-and-scope).

## Install

```bash
composer require hideyukimori/nene-mcp
```

Published on [Packagist](https://packagist.org/packages/hideyukimori/nene-mcp). Pin for reproducible deploys:

```bash
composer require hideyukimori/nene-mcp:0.1.8
```

Or clone for development:

```bash
git clone git@github.com:hideyukiMORI/nene-mcp.git
cd nene-mcp
composer install
composer test
```

## Cursor / MCP client example (local NeNe app)

Set the **absolute path** to `vendor/bin/nene-mcp` and env vars for your environment.

### With tool catalog (typical)

```json
{
  "mcpServers": {
    "nene-mcp": {
      "command": "php",
      "args": ["/ABS/PATH/vendor/bin/nene-mcp"],
      "env": {
        "NENE_MCP_API_BASE_URL": "http://localhost:8080",
        "NENE_MCP_TOOLS_JSON": "/ABS/PATH/ne-app/docs/mcp/tools.json"
      }
    }
  }
}
```

### Catalog-free (smoke test / Day 0)

Omit `NENE_MCP_TOOLS_JSON` until `tools.json` exists. MCP starts with only `nene_mcp_about`:

```json
{
  "mcpServers": {
    "nene-mcp": {
      "command": "php",
      "args": ["/ABS/PATH/vendor/bin/nene-mcp"],
      "env": {
        "NENE_MCP_API_BASE_URL": "http://localhost:8080"
      }
    }
  }
}
```

Do **not** set `NENE_MCP_TOOLS_JSON` to a placeholder path—a missing file fails `tools/list` entirely.

Without a catalog, MCP still starts and `tools/list` exposes only `nene_mcp_about`. See **[docs/example-ne-health-catalog.md](docs/example-ne-health-catalog.md)** for a minimal NeNe sample when you add HTTP tools.

## Environment variables

| Variable | Meaning |
| --- | --- |
| `NENE_MCP_API_BASE_URL` | REST base URL (no trailing slash). Default `http://localhost:8080`. Overridable via `NENE2_LOCAL_API_BASE_URL`. |
| `NENE_MCP_TOOLS_JSON` | Path to NENE2-compatible tool catalog JSON. When omitted, no OpenAPI HTTP tools—only `nene_mcp_about`. Also accepts `NENE2_LOCAL_TOOLS_JSON`. |
| `NENE_MCP_BEARER_TOKEN` | For endpoints that require Bearer (e.g. `safety: write`). **Keep secrets in env only.** |

Optional (SMB / staging — v0.1.8+):

| Variable | Meaning |
| --- | --- |
| `NENE_MCP_HTTP_TIMEOUT_SEC` | HTTP timeout seconds (`1`–`120`, default `10`) |
| `NENE_MCP_TLS_CA_FILE` | PEM CA bundle path for `https://` base URLs |
| `NENE_MCP_LOG` | Set to `stderr` for safe per-request HTTP lines (never stdout) |

Full reference: [Environment variables](https://hideyukimori.github.io/nene-mcp/reference/environment-variables).

## Composer scripts

```bash
composer test          # PHPUnit
composer check         # PHPUnit + PHPStan level 8
```

## Documentation

| Document | Contents |
| --- | --- |
| [docs/project.md](docs/project.md) | Purpose, NeNe relationship, architecture |
| [docs/integration/nene.md](docs/integration/nene.md) | Composer integration for NeNe |
| [docs/integration/other-platforms.md](docs/integration/other-platforms.md) | Other frameworks, vanilla PHP, other languages |
| [docs/README.md](docs/README.md) | Documentation index |
| [AGENTS.md](AGENTS.md) | Guide for AI agents |

## Contributing

Governance follows NENE2-style strict policy—read before opening a PR:

- `docs/workflow.md` — Issue and branch policy
- `docs/development/coding-standards.md` — PHP / MCP rules
- `docs/development/security-policy.md` — security requirements
- `docs/review/mcp-server.md` — pre-PR checklist for code changes
- `docs/field-trials/README.md` — field trial methodology
- `docs/development/release-policy.md` — versioning and Packagist timing
- `docs/CONTRIBUTING.md` — full contribution guide

## License

MIT — see `LICENSE`.
