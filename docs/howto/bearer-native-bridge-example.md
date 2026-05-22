# Bearer-native bridge example

Contrast with [NeNe catalog patterns](/howto/neene-catalog-patterns): when your API uses **`Authorization: Bearer`** (not session cookies), nene-mcp can proxy **authenticated reads and writes** with a static env token.

This walkthrough matches Field Trial 206 — a vanilla PHP bridge + sidecar HTTP API (any language for the API; MCP process needs PHP 8.2+).

## Pattern

```text
inventory-api/          # your API (Node, Go, PHP, …) — Bearer auth
bridge/
├── composer.json       # requires hideyukimori/nene-mcp
├── docs/mcp/tools.json
└── .cursor/mcp.json    # spawns vendor/bin/nene-mcp
```

## 1. Install bridge

```bash
mkdir inventory-bridge && cd inventory-bridge
composer require hideyukimori/nene-mcp:^0.1
```

See [Other platforms](/howto/other-platforms) for the sidecar model.

## 2. Obtain a Bearer token (out of band)

Use your API’s normal client-credentials or login flow **outside** MCP first (curl, CI secret, admin UI). Example response shape:

```json
{ "token": "your-agent-token", "token_type": "Bearer" }
```

Put the token in the MCP host env — **never** in `tools.json` or git:

```json
"env": {
  "NENE_MCP_API_BASE_URL": "http://127.0.0.1:9090",
  "NENE_MCP_TOOLS_JSON": "/ABS/PATH/docs/mcp/tools.json",
  "NENE_MCP_BEARER_TOKEN": "your-agent-token"
}
```

::: warning Token issuance tools marked `write`
If you catalog a **token endpoint** as `"safety": "write"`, nene-mcp still requires `NENE_MCP_BEARER_TOKEN` before HTTP (fail-closed). For public token routes, use a **placeholder** Bearer in env to satisfy fail-closed, or keep token exchange out of the catalog.
:::

## 3. Catalog (inventory sample)

```json
{
  "tools": [
    {
      "name": "getHealth",
      "title": "Health",
      "description": "Public GET /health",
      "safety": "read",
      "source": {
        "type": "openapi",
        "operationId": "health",
        "method": "GET",
        "path": "/health"
      },
      "inputSchema": {
        "type": "object",
        "properties": {},
        "additionalProperties": false
      },
      "responseSchemaRef": null
    },
    {
      "name": "listInventoryItems",
      "title": "List inventory",
      "description": "Bearer-protected GET /api/inventory/items",
      "safety": "read",
      "source": {
        "type": "openapi",
        "operationId": "listItems",
        "method": "GET",
        "path": "/api/inventory/items"
      },
      "inputSchema": {
        "type": "object",
        "properties": {},
        "additionalProperties": false
      },
      "responseSchemaRef": null
    },
    {
      "name": "createInventoryItem",
      "title": "Create item",
      "description": "Bearer-protected POST /api/inventory/items",
      "safety": "write",
      "source": {
        "type": "openapi",
        "operationId": "createItem",
        "method": "POST",
        "path": "/api/inventory/items"
      },
      "inputSchema": {
        "type": "object",
        "properties": {
          "sku": { "type": "string" },
          "qty": { "type": "integer" }
        },
        "required": ["sku"],
        "additionalProperties": false
      },
      "responseSchemaRef": null
    }
  ]
}
```

## 4. Bearer on protected **read** tools

nene-mcp does **not** fail-closed on `safety: read`, but your API may still require Bearer on GET.

| Symptom | Fix |
| --- | --- |
| `listInventoryItems` → HTTP **401**, `isError: true` | Set `NENE_MCP_BEARER_TOKEN` in MCP env (token is sent on GET when env is set) |
| Write tools blocked before HTTP | Expected fail-closed — set Bearer first |

This is the opposite of NeNe session cookies: Bearer in env works across **stateless** MCP calls.

## 5. Smoke

```bash
export NENE_MCP_API_BASE_URL=http://127.0.0.1:9090
export NENE_MCP_TOOLS_JSON=/ABS/PATH/docs/mcp/tools.json
export NENE_MCP_BEARER_TOKEN=your-agent-token

printf '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"listInventoryItems","arguments":{}}}\n' \
  | php vendor/bin/nene-mcp
```

Expect HTTP **200** and JSON `items` in structured content.

Write smoke:

```bash
printf '{"jsonrpc":"2.0","id":2,"method":"tools/call","params":{"name":"createInventoryItem","arguments":{"sku":"AGENT-1","qty":1}}}\n' \
  | php vendor/bin/nene-mcp
```

Expect **201** (or your API’s success code).

Optional GET filter — add `"sku"` to a search tool’s `inputSchema`; remaining GET args become query string ([catalog-format](/reference/catalog-format)).

## 6. Team checklist — avoid partial catalog drift

Before telling agents “inventory tools are live”:

1. `tools/list` shows **every** tool name you expect (not only `getHealth`).
2. Run [catalog smoke test](/howto/catalog-smoke-test) on **each** read and write tool.
3. Commit the same `tools.json` path configured in `.cursor/mcp.json`.
4. Mutating tools that require Bearer use `"safety": "write"` — not `read` ([safety vs method](/howto/write-tools-bearer#safety-label-vs-http-method)).

Deploying health-only JSON while docs promise inventory tools is an operator mistake — MCP cannot infer missing tools.

## Related

- [Write tools & Bearer](/howto/write-tools-bearer)
- [NeNe catalog patterns](/howto/neene-catalog-patterns) — cookie-auth hosts
- [Other platforms](/howto/other-platforms)
