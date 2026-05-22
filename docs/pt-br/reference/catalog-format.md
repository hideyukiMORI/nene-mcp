# Tool catalog JSON

Committed catalog format compatible with NENE2 `docs/mcp/tools.json`.

## Top-level shape

```json
{
  "tools": [
    {
      "name": "getHealthCheck",
      "title": "Health check",
      "description": "GET /health/index",
      "safety": "read",
      "source": {
        "type": "openapi",
        "operationId": "getHealthIndex",
        "method": "GET",
        "path": "/health/index"
      },
      "inputSchema": {
        "type": "object",
        "properties": {},
        "additionalProperties": false
      },
      "responseSchemaRef": null
    }
  ]
}
```

## Rules

| Field | Rule |
| --- | --- |
| `name` | Unique across catalog (enforced v0.1.3+) |
| `safety` | `read` or `write` (non-read requires Bearer) |
| `source.type` | Must be `openapi` in JSON catalogs |
| `source.path` | Relative path preferred; appended to base URL |
| `inputSchema` | JSON Schema object for MCP clients |

## Path parameters

Use `{param}` in `path`; provide values in `tools/call` arguments.

## Validation errors

Invalid JSON, duplicate names, or missing required fields fail at `tools/list` with a safe JSON-RPC error.

## Sample

See `docs/example-ne-health-catalog.md` in the repository for a NeNe health example.
