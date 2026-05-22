# Environment variables

| Variable | Required | Description |
| --- | --- | --- |
| `NENE_MCP_API_BASE_URL` | Yes | REST base URL (e.g. `http://localhost:8080`) |
| `NENE_MCP_TOOLS_JSON` | No | Absolute path to tool catalog JSON |
| `NENE_MCP_BEARER_TOKEN` | For write tools | Bearer token for protected endpoints |

## NENE2 aliases

Accepted for compatibility:

| nene-mcp | Alias |
| --- | --- |
| `NENE_MCP_API_BASE_URL` | `NENE2_LOCAL_API_BASE_URL` |
| `NENE_MCP_TOOLS_JSON` | `NENE2_LOCAL_TOOLS_JSON` |

## Behavior notes

- Omitting `NENE_MCP_TOOLS_JSON` → only `nene_mcp_about` is listed
- Invalid catalog path → `tools/list` fails with JSON-RPC error
- Bearer is never echoed in tool responses or logs on stdout

## Example (Cursor)

```json
"env": {
  "NENE_MCP_API_BASE_URL": "http://localhost:8080",
  "NENE_MCP_TOOLS_JSON": "/ABS/PATH/docs/mcp/tools.json"
}
```
