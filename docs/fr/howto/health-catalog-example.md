# Exemple catalogue health NeNe

Copiez dans `docs/mcp/tools.json` de votre app NeNe. Aligné sur OpenAPI `operationId: healthCheck`.

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

## Déploiement sous-répertoire (`URI_ROOT`)

Avec un prefix NeNe, définissez **`NENE_MCP_API_BASE_URL`** avec ce prefix (ex. `http://localhost:8080/mybiz`). Les chemins catalogue restent `/health/index`. Voir [Motifs catalogue NeNe](/fr/howto/neene-catalog-patterns).

## Vérifier

```bash
export NENE_MCP_API_BASE_URL=http://localhost:8080
export NENE_MCP_TOOLS_JSON=/CHEMIN/ABS/docs/mcp/tools.json
printf '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"getHealthCheck","arguments":{}}}\n' \
  | php vendor/bin/nene-mcp
```

Attendu : `statusCode` 200.

## Voir aussi

- [JSON du catalogue](/fr/reference/catalog-format)
- [Intégrer avec NeNe](/fr/howto/integrate-nene)
