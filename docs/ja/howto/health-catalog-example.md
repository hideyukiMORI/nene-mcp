# NeNe health カタログ例

NeNe アプリの `docs/mcp/tools.json` にコピー。OpenAPI の `operationId: healthCheck` に整合。

[English](/howto/health-catalog-example)

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

`NENE_MCP_TOOLS_JSON` は **絶対パス** を使用してください。
