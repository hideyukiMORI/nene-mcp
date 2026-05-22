# Write tools & Bearer

Catalog entries with `"safety": "write"` (or any non-`read` safety) require **`NENE_MCP_BEARER_TOKEN`** in the MCP server environment.

## Fail-closed default

Without Bearer, `tools/call` returns a JSON-RPC error and **does not send HTTP**:

```text
Write tool "myTool" requires bearer authentication. Set NENE_MCP_BEARER_TOKEN in the MCP server environment.
```

This prevents silent anonymous writes when an operator forgets to configure auth.

## Where to put the token

| OK | Not OK |
| --- | --- |
| MCP host `env` block (Cursor, Claude Desktop) | `tools.json` |
| OS environment for the MCP process | Git commits |
| Secret manager → env at runtime | `nene_mcp_about` output |

## Obtaining a token

Use your app's normal session flow:

- **NeNe / NENE2**: login endpoint → session Bearer (see host docs)
- **Custom API**: whatever your OpenAPI security scheme defines

nene-mcp forwards the token as `Authorization: Bearer …` on write HTTP calls.

## Read tools

`safety: read` tools do not require Bearer unless your API enforces auth on GET.

## Related

- [Security model](/explanation/security-model)
- [Environment variables](/reference/environment-variables)
