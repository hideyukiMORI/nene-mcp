# Scope & mission

nene-mcp is a **standalone Composer MCP bridge** for the NeNe ecosystem and generic HTTP apps.

## Mission

Integrators add `composer require hideyukimori/nene-mcp`, configure MCP, and trust read/write HTTP proxy behavior **without reading source**.

## In scope

- stdio JSON-RPC MCP server (`initialize`, `tools/list`, `tools/call`)
- NENE2-compatible committed `tools.json` catalogs
- HTTP proxy to configured base URL + catalog paths
- Built-in `nene_mcp_about` metadata tool
- Fail-closed write tools, redirect SSRF mitigation, catalog validation

## Out of scope

- NeNe framework core changes (file Issues in NeNe repo)
- Automatic OpenAPI → tools.json codegen (host responsibility)
- Non-stdio MCP transports (HTTP/SSE server mode)
- End-user UI or localization of MCP error strings
- **Production API gateway / SLA-hosted MCP service** — see [Commercial use & production scope](/explanation/commercial-use-and-scope)

## Philosophy

Inherited from [NeNe](https://github.com/hideyukiMORI/NeNe):

- Small, explicit, reviewable
- OpenAPI / catalog as contract
- Issue-driven changes, narrow PRs
- MCP as **plugin-style** Composer package — not framework core

## Related

- [Architecture](/explanation/architecture)
- [Ecosystem](/integrations/ecosystem)
