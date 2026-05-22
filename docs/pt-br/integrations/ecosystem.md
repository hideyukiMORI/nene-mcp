# Ecosystem map

nene-mcp is one piece of the hideyukiMORI NeNe / NENE2 ecosystem.

| Project | Role | Docs |
| --- | --- | --- |
| **NeNe** | Small PHP framework (reference app) | [GitHub](https://github.com/hideyukiMORI/NeNe) |
| **NENE2** | Production PHP framework + OpenAPI + MCP docs | [hideyukimori.github.io/NENE2](https://hideyukimori.github.io/NENE2/) |
| **nene-mcp** | Standalone stdio MCP bridge (this package) | You are here |
| **nene2-js** | TypeScript client for NENE2 JSON APIs | [hideyukimori.github.io/nene2-js](https://hideyukimori.github.io/nene2-js/) |
| **nene2-python** | Python parity port | [GitHub](https://github.com/hideyukiMORI/nene2-python) |

## Boundaries

```text
Your HTTP API  ←—— nene-mcp (stdio MCP)  ←—— Cursor / Claude / agents
       ↑
  NENE2 / NeNe / Laravel / Node / …
```

- **NENE2** owns PHP runtime, routing, OpenAPI, Problem Details
- **nene2-js** owns typed fetch from Node/browsers — not MCP
- **nene-mcp** owns stdio MCP wire + HTTP proxy — not framework core

## Install matrix

| Goal | Package |
| --- | --- |
| MCP in Cursor against local API | `composer require hideyukimori/nene-mcp` |
| PHP API framework | `composer require hideyukimori/nene2` |
| TS client for NENE2 REST | `npm i @hideyukimori/nene2-client` |

## Cross-links

When documenting integrations, link sibling docs rather than duplicating framework internals.
