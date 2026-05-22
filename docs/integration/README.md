# Integration Guide

How to attach nene-mcp to your app and MCP client. **Published docs:** [hideyukimori.github.io/nene-mcp](https://hideyukimori.github.io/nene-mcp/).

## Which guide to read

| Your situation | Document |
| --- | --- |
| NeNe host | [Integrate with NeNe](https://hideyukimori.github.io/nene-mcp/howto/integrate-nene) + [NeNe catalog patterns](https://hideyukimori.github.io/nene-mcp/howto/neene-catalog-patterns) |
| Bearer-native API (inventory, JWT, etc.) | [Bearer-native bridge example](https://hideyukimori.github.io/nene-mcp/howto/bearer-native-bridge-example) |
| Laravel / Symfony / vanilla PHP sidecar | [Other platforms](https://hideyukimori.github.io/nene-mcp/howto/other-platforms) |
| Catalog JSON only | [Tool catalog format](https://hideyukimori.github.io/nene-mcp/reference/catalog-format) + [health example](https://hideyukimori.github.io/nene-mcp/howto/health-catalog-example) |

## Shared prerequisites

1. **App** — HTTP API running locally (OpenAPI recommended)
2. **nene-mcp** — `composer require hideyukimori/nene-mcp:^0.1`
3. **MCP client** — stdio spawn of `vendor/bin/nene-mcp`; **absolute** `NENE_MCP_TOOLS_JSON`

**NeNe:** session-cookie + CSRF on TODO writes — MCP cannot complete stock TODO E2E; see [NeNe catalog patterns](https://hideyukimori.github.io/nene-mcp/howto/neene-catalog-patterns) and [NeNe #380](https://github.com/hideyukiMORI/NeNe/issues/380).

## Environment variables

| Variable | Meaning |
| --- | --- |
| `NENE_MCP_API_BASE_URL` | REST base URL (include `URI_ROOT` prefix when deployed under a path) |
| `NENE_MCP_TOOLS_JSON` | Absolute path to `tools.json` |
| `NENE_MCP_BEARER_TOKEN` | Bearer for writes and **Bearer-protected GET** |

Without a catalog, only `nene_mcp_about` is exposed.

## Write tools and Bearer

`safety: write` requires `NENE_MCP_BEARER_TOKEN` — fail-closed without it (FT9).

- Token in MCP host `env` only — never in catalog or git
- **NeNe:** not session Bearer — cookie/CSRF host; use Bearer-native APIs or NeNe #380
- **GET with auth:** set Bearer even for `safety: read` when API returns 401
- **POST/PUT with auth:** use `safety: write` when API requires Bearer — `read` skips fail-closed ([write-tools-bearer](https://hideyukimori.github.io/nene-mcp/howto/write-tools-bearer#safety-label-vs-http-method))

Duplicate tool names rejected at load (v0.1.3+).

## Smoke

[Catalog smoke test](https://hideyukimori.github.io/nene-mcp/howto/catalog-smoke-test) — include tool-count checklist before announcing MCP to agents.

## Repo-only detail

NeNe-specific bootstrap notes also live in [`nene.md`](nene.md) (may lag the docs site).
