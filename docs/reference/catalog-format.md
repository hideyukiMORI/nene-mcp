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
        "operationId": "healthCheck",
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
| `safety` | `read` or `write` (non-read requires Bearer env **before HTTP**) |
| `source.type` | Must be `openapi` in JSON catalogs |
| `source.path` | Relative path preferred; appended to base URL |
| `source.operationId` | Should match OpenAPI `operationId` for traceability |
| `inputSchema` | JSON Schema object for MCP clients |

## Path parameters

Use `{param}` in `path`; provide values in `tools/call` arguments. nene-mcp URL-encodes each replacement.

**NeNe convention:** paths like `/todo/item/id_{id}` — copy the OpenAPI path literally, not `/todo/item/{id}`. See [NeNe catalog patterns](/howto/neene-catalog-patterns).

## Query parameters (GET)

For `GET` tools, arguments **not consumed** as `{path}` tokens are appended as a **query string** (`http_build_query`).

Example catalog entry:

```json
{
  "name": "searchInventory",
  "safety": "read",
  "source": {
    "type": "openapi",
    "operationId": "searchItems",
    "method": "GET",
    "path": "/api/inventory/items"
  },
  "inputSchema": {
    "type": "object",
    "properties": { "sku": { "type": "string" } },
    "additionalProperties": false
  }
}
```

`tools/call` with `{ "sku": "WIDGET-1" }` → `GET /api/inventory/items?sku=WIDGET-1`.

POST/PUT/PATCH: remaining arguments become JSON body (not query).

## Safety vs HTTP method

`safety` controls **nene-mcp fail-closed**, not OpenAPI security alone.

| `source.method` | OpenAPI auth | Recommended `safety` |
| --- | --- | --- |
| GET | public | `read` |
| GET | Bearer required | `read` + set `NENE_MCP_BEARER_TOKEN` in MCP env |
| POST / PUT / PATCH / DELETE | Bearer required | **`write`** (fail-closed without env Bearer) |

Do **not** mark a Bearer-protected **POST** as `"safety": "read"` expecting fail-closed — MCP will send HTTP without Bearer and the API returns 401. See [Write tools & Bearer — safety label vs HTTP method](/howto/write-tools-bearer#safety-label-vs-http-method).

## Validation errors

Invalid JSON, duplicate names, or missing required fields fail at `tools/list` with a safe JSON-RPC error.

## Sample

Full NeNe health example: [NeNe health catalog example](/howto/health-catalog-example).
