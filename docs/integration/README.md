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
2. **nene-mcp** — `composer require hideyukimori/nene-mcp` ([Packagist](https://packagist.org/packages/hideyukimori/nene-mcp)) so `vendor/bin/nene-mcp` is available
3. **MCP client** — spawn `nene-mcp` over stdio ([Packagist](https://packagist.org/packages/hideyukimori/nene-mcp)). Omit `NENE_MCP_TOOLS_JSON` until `tools.json` exists (about-only smoke test); add it when HTTP tools are ready.

**NeNe hosts:** PHP **`ext-intl`** and Docker quick start — see [`nene.md`](nene.md#prerequisites). Host-side fixes are filed in the NeNe repository when FTs find bootstrap gaps.

nene-mcp contains no NeNe-specific code. NeNe is one host that ships OpenAPI + `tools.json`.

## Environment variables (all integrations)

| Variable | Meaning |
| --- | --- |
| `NENE_MCP_API_BASE_URL` | REST base URL (`NENE2_LOCAL_API_BASE_URL` accepted) |
| `NENE_MCP_TOOLS_JSON` | Absolute path to tool catalog JSON (`NENE2_LOCAL_TOOLS_JSON` accepted) |
| `NENE_MCP_BEARER_TOKEN` | Bearer for write or protected endpoints (secrets in env only) |

Without a catalog, MCP still starts and exposes only `nene_mcp_about`.

## Write tools and Bearer

Catalog entries with `"safety": "write"` (or any non-`read` safety) require `NENE_MCP_BEARER_TOKEN` in the MCP server environment. Without it, `tools/call` returns a JSON-RPC error and **does not** send HTTP—fail-closed by design (FT9).

- Set the token only in the MCP host config (Cursor `env`, Claude Desktop env block)—never in `tools.json` or git.
- Obtain the token from your app's normal login/session flow (NeNe: session Bearer after login; see host docs).
- Read-only tools (`safety: read`) do not require Bearer unless your API enforces auth on GET.

Duplicate tool `name` values in the catalog are rejected at load time (v0.1.3+).

## Next steps

- NeNe: [`nene.md`](nene.md)
- Everything else: [`other-platforms.md`](other-platforms.md)
