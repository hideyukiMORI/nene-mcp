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

## Protocol version

`initialize` reports `protocolVersion: 2024-11-05`.
