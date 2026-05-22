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

在 `path` 中使用 `{param}`；在 `tools/call` 参数中提供值。

**NeNe：** 路径如 `/todo/item/id_{id}` — 按 OpenAPI 原样复制。见 [NeNe 目录模式](/zh/howto/neene-catalog-patterns)。

## 查询参数（GET）

**GET** 工具中未用于 `{path}` 的参数会变为 **查询字符串**。见 [Tool catalog JSON (en)](/reference/catalog-format)。

## Validation errors

Invalid JSON, duplicate names, or missing required fields fail at `tools/list` with a safe JSON-RPC error.

## Sample

完整示例：[NeNe health 目录示例](/zh/howto/health-catalog-example)。
