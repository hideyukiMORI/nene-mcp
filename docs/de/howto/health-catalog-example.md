# NeNe Health-Katalog Beispiel

In `docs/mcp/tools.json` kopieren. OpenAPI `operationId: healthCheck`.

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

`NENE_MCP_API_BASE_URL` muss den Deployment-Prefix enthalten — [NeNe-Katalogmuster](/de/howto/neene-catalog-patterns).

## Weiter

- [Katalog-JSON](/de/reference/catalog-format)
- [NeNe integrieren](/de/howto/integrate-nene)
