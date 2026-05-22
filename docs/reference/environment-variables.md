# Environment variables

| Variable | Required | Description |
| --- | --- | --- |
| `NENE_MCP_API_BASE_URL` | Yes | REST base URL (e.g. `http://localhost:8080`) |
| `NENE_MCP_TOOLS_JSON` | No | Absolute path to tool catalog JSON |
| `NENE_MCP_BEARER_TOKEN` | For write tools | Bearer token for protected endpoints |

## SMB / staging operators (optional)

| Variable | Default | Description |
| --- | --- | --- |
| `NENE_MCP_HTTP_TIMEOUT_SEC` | `10` | HTTP stream timeout in seconds (`1`–`120`; invalid values fall back to `10`) |
| `NENE_MCP_TLS_CA_FILE` | unset | Absolute path to PEM CA bundle for `https://` base URLs (internal/staging CAs) |
| `NENE_MCP_LOG` | unset | Set to `stderr` to log one safe line per HTTP call on **stderr** (method, path, status, duration — never Bearer or bodies) |

See [SMB adoption checklist](/explanation/smb-adoption-checklist).

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
- `NENE_MCP_LOG=stderr` never writes to stdout (JSON-RPC wire stays clean)

## Example (Cursor)

```json
"env": {
  "NENE_MCP_API_BASE_URL": "http://localhost:8080",
  "NENE_MCP_TOOLS_JSON": "/ABS/PATH/docs/mcp/tools.json",
  "NENE_MCP_HTTP_TIMEOUT_SEC": "30",
  "NENE_MCP_LOG": "stderr"
}
```

## Example (staging HTTPS + private CA)

```json
"env": {
  "NENE_MCP_API_BASE_URL": "https://staging-api.example.internal",
  "NENE_MCP_TOOLS_JSON": "/ABS/PATH/docs/mcp/tools.json",
  "NENE_MCP_BEARER_TOKEN": "from-secret-store",
  "NENE_MCP_TLS_CA_FILE": "/etc/ssl/certs/internal-ca.pem",
  "NENE_MCP_HTTP_TIMEOUT_SEC": "45",
  "NENE_MCP_LOG": "stderr"
}
```
