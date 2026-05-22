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
| `safety` | `read` or `write` (non-read requires Bearer) |
| `source.type` | Must be `openapi` in JSON catalogs |
| `source.path` | Relative path preferred; appended to base URL |
| `inputSchema` | JSON Schema object for MCP clients |

## Path parameters

Use `{param}` in `path`; provide values in `tools/call` arguments.

**NeNe :** chemins comme `/todo/item/id_{id}` — copier le chemin OpenAPI tel quel. Voir [Motifs catalogue NeNe](/fr/howto/neene-catalog-patterns).

## Paramètres de requête (GET)

Pour les outils **GET**, les arguments non utilisés dans `{path}` deviennent une **query string** (`?sku=…`). Voir [Tool catalog JSON (en)](/reference/catalog-format).

## Validation errors

Invalid JSON, duplicate names, or missing required fields fail at `tools/list` with a safe JSON-RPC error.

## Sample

Exemple complet : [Exemple catalogue health NeNe](/fr/howto/health-catalog-example).
