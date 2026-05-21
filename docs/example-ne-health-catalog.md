# Sample NeNe `tools.json`

Minimal example aligned with NeNe `docs/api/openapi.yaml`.

```json
{
  "tools": [
    {
      "name": "getHealthCheck",
      "title": "Health Check",
      "description": "GET /health/index (operationId healthCheck).",
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

When deploying under a subdirectory (`URI_ROOT`), adjust `path` and `servers.url` accordingly.
