# Architecture

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

## Components

| Piece | Role |
| --- | --- |
| `StdioMcpServer` | JSON-RPC loop: initialize, tools/list, tools/call |
| `MergedCatalog` | Built-in tools + optional JSON catalog |
| `JsonToolCatalog` | Loads and validates `tools.json` |
| `NativeMcpHttpClient` | HTTP to base URL; Bearer from env; no redirect follow |

## Tool execution flow

1. MCP host sends `tools/call` with tool name + arguments
2. Server resolves tool from catalog
3. **Write** tools check `hasAuthentication()` — fail if no Bearer
4. HTTP method/path from catalog `source`; path params interpolated
5. Response wrapped as MCP structured content (`statusCode`, `body`, …)

## Configuration

All runtime config via **environment variables** — no config files in the package.

See [Environment variables](/reference/environment-variables).
