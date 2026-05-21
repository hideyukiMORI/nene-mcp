# Integration Guide

How to attach nene-mcp to your app and MCP client.

## Which guide to read

| Your situation | Document |
| --- | --- |
| Building a small service with NeNe | [`nene.md`](nene.md) |
| Laravel / Symfony / CodeIgniter PHP app | [`other-platforms.md`](other-platforms.md) § Other PHP frameworks |
| Framework-free vanilla PHP | [`other-platforms.md`](other-platforms.md) § Vanilla PHP |
| Node / Python / Go API | [`other-platforms.md`](other-platforms.md) § Other languages |
| Catalog JSON format only | [`../example-ne-health-catalog.md`](../example-ne-health-catalog.md) |

## Shared prerequisites

1. **App** — documented HTTP API (OpenAPI recommended) running locally
2. **nene-mcp** — `composer require hideyukimori/nene-mcp` so `vendor/bin/nene-mcp` is available
3. **MCP client** — spawn `nene-mcp` over stdio and pass API URL + catalog path via env

nene-mcp contains no NeNe-specific code. NeNe is one host that ships OpenAPI + `tools.json`.

## Environment variables (all integrations)

| Variable | Meaning |
| --- | --- |
| `NENE_MCP_API_BASE_URL` | REST base URL (`NENE2_LOCAL_API_BASE_URL` accepted) |
| `NENE_MCP_TOOLS_JSON` | Absolute path to tool catalog JSON (`NENE2_LOCAL_TOOLS_JSON` accepted) |
| `NENE_MCP_BEARER_TOKEN` | Bearer for write or protected endpoints (secrets in env only) |

Without a catalog, MCP still starts and exposes only `nene_mcp_about`.

## Next steps

- NeNe: [`nene.md`](nene.md)
- Everything else: [`other-platforms.md`](other-platforms.md)
