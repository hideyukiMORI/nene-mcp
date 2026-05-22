# MCP protocol surface

nene-mcp implements a **subset** of MCP over newline-delimited JSON-RPC on stdio.

## Supported methods

| Method | Description |
| --- | --- |
| `initialize` | Returns server info and capabilities |
| `tools/list` | Built-in + catalog tools |
| `tools/call` | Execute tool (builtin or HTTP-backed) |
| `notifications/initialized` | Acknowledged with no response |

Unsupported methods return JSON-RPC `-32601`.

## Built-in tool

| Name | Safety | Description |
| --- | --- | --- |
| `nene_mcp_about` | read | Package version, PHP version, resolved paths (no secrets) |

## Tool list shape

Each tool includes:

- `name`, `title`, `description`
- `inputSchema` (JSON Schema)
- `annotations.readOnlyHint` — `true` when `safety: read`

## tools/call result

HTTP-backed tools return structured content:

```json
{
  "statusCode": 200,
  "requestId": "...",
  "body": { }
}
```

HTTP errors set `isError: true` while still returning structured content.

## Transport and connection failures

When the TCP/HTTP layer cannot complete a request (connection refused, DNS failure, timeout), `tools/call` returns a JSON-RPC **error** (typically `-32603`) with a short message — not a `result` object with `statusCode`. This differs from HTTP 4xx/5xx responses from a reachable host, which still return structured content with `isError: true`.

Verify `NENE_MCP_API_BASE_URL` with [catalog smoke test](/howto/catalog-smoke-test) before enabling write tools.

## Protocol version

`initialize` reports `protocolVersion: 2024-11-05`.
