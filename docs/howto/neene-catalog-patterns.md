# NeNe catalog patterns

NeNe-specific conventions when mapping `docs/api/openapi.yaml` to `docs/mcp/tools.json`. nene-mcp has no NeNe code — these patterns come from the sample NeNe REST API.

## Path parameters (`id_{param}`)

NeNe often uses **key-value path segments**, not OpenAPI `{param}` templates alone.

| OpenAPI path | Catalog `path` | `tools/call` arguments |
| --- | --- | --- |
| `/todo/item/id_{id}` | `/todo/item/id_{id}` | `{ "id": "42" }` → HTTP `/todo/item/id_42` |

nene-mcp replaces each `{name}` token in `path` with the argument value (URL-encoded).

**Common mistake:** copying `/todo/item/{id}` from generic OpenAPI style → NeNe returns **405** because the route expects `id_{id}`.

```json
{
  "name": "getTodoById",
  "safety": "read",
  "source": {
    "type": "openapi",
    "operationId": "getTodo",
    "method": "GET",
    "path": "/todo/item/id_{id}"
  },
  "inputSchema": {
    "type": "object",
    "properties": { "id": { "type": "string" } },
    "required": ["id"],
    "additionalProperties": false
  }
}
```

See also [Tool catalog JSON — path parameters](/reference/catalog-format).

## Base URL and `URI_ROOT`

`NENE_MCP_API_BASE_URL` is the **origin + optional deployment prefix** where NeNe serves HTTP. Catalog `path` values are appended to it.

| NeNe deployment | `NENE_MCP_API_BASE_URL` | Catalog path |
| --- | --- | --- |
| Root (`http://localhost:8080/health/index`) | `http://localhost:8080` | `/health/index` |
| Subdirectory `URI_ROOT=/mybiz/` | `http://localhost:8080/mybiz` | `/health/index` |

**Mismatch symptom:** HTTP **404** on health or business tools with `isError: true` — check NeNe `URI_ROOT` and reverse-proxy path prefix in [NeNe deployment docs](https://github.com/hideyukiMORI/NeNe).

Do **not** put the prefix only in catalog paths while the base URL is the host root (or the reverse) unless that matches how NeNe actually routes.

## Session cookie auth (sample TODO module)

NeNe OpenAPI declares **`sessionCookie`** on `/todo/*` and `/session/login` follow-up calls — not Bearer.

nene-mcp today:

- Sends **`Authorization: Bearer …`** when `NENE_MCP_BEARER_TOKEN` is set
- Does **not** store `Set-Cookie` between MCP `tools/call` requests (stateless HTTP)

So a docs-only flow **login → listTodos → createTodo** on the **stock NeNe sample** will not work end-to-end via MCP alone: `sessionLogin` may return 200, but the next call has no session cookie.

| Goal | Practical approach |
| --- | --- |
| Health / public reads | Works with MCP as documented |
| NeNe TODO module over MCP | Add Bearer-compatible auth in NeNe, or use a host/API designed for Bearer tokens |
| Custom bridge | Out of nene-mcp scope unless an ADR adds optional cookie storage |

This is a **host auth model** limitation, not a catalog JSON bug.

## Write tools and login bootstrap

Tools with `"safety": "write"` require `NENE_MCP_BEARER_TOKEN` in the MCP process env **before HTTP** (fail-closed).

NeNe `/session/login` accepts unauthenticated POST, but nene-mcp still blocks the catalog login tool without env Bearer. Operators may set a **placeholder** token to satisfy fail-closed while the HTTP login endpoint ignores Bearer — only for hosts where login is public.

**Credentials in MCP arguments:** `user_id` / `user_pass` in `tools/call` appear in agent transcripts and host logs. Prefer env-based test accounts in dev; never commit secrets.

## Related

- [Integrate with NeNe](/howto/integrate-nene)
- [Write tools & Bearer](/howto/write-tools-bearer)
- [NeNe health catalog example](/howto/health-catalog-example)
