# NeNe health catalog example

Copy this to `docs/mcp/tools.json` in your NeNe app. Aligned with NeNe `docs/api/openapi.yaml` (`operationId: healthCheck`).

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

## Subdirectory deploy (`URI_ROOT`)

When the app runs under a subdirectory, adjust `path` and your OpenAPI `servers.url` to match. Smoke with [catalog smoke test](/howto/catalog-smoke-test) before adding write tools.

## Verify

```bash
export NENE_MCP_API_BASE_URL=http://localhost:8080
export NENE_MCP_TOOLS_JSON=/ABS/PATH/docs/mcp/tools.json
printf '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"getHealthCheck","arguments":{}}}\n' \
  | php vendor/bin/nene-mcp
```

Expect `statusCode` 200 in structured content.

## Related

- [Tool catalog JSON reference](/reference/catalog-format)
- [Integrate with NeNe](/howto/integrate-nene)
