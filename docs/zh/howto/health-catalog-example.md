# NeNe health 目录示例

复制到 NeNe 应用的 `docs/mcp/tools.json`。与 OpenAPI `operationId: healthCheck` 一致。

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

## 子目录部署（`URI_ROOT`）

NeNe 使用路径前缀时，在 **`NENE_MCP_API_BASE_URL`** 中包含该前缀（如 `http://localhost:8080/mybiz`）。目录 path 仍为 `/health/index`。见 [NeNe 目录模式](/zh/howto/neene-catalog-patterns)。

## 验证

```bash
export NENE_MCP_API_BASE_URL=http://localhost:8080
export NENE_MCP_TOOLS_JSON=/绝对路径/docs/mcp/tools.json
printf '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"getHealthCheck","arguments":{}}}\n' \
  | php vendor/bin/nene-mcp
```

期望 `statusCode` 200。

## 相关

- [工具目录 JSON](/zh/reference/catalog-format)
- [集成 NeNe](/zh/howto/integrate-nene)
