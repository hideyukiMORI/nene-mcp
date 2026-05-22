# Exemplo catálogo health NeNe

Copie para `docs/mcp/tools.json`. `operationId: healthCheck`.

```json
{
  "tools": [
    {
      "name": "getHealthCheck",
      "title": "Health Check",
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

## URI_ROOT

Ver [Padrões NeNe](/pt-br/howto/neene-catalog-patterns).
