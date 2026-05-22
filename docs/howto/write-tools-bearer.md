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

Use whatever your **OpenAPI security scheme** defines:

- **Bearer / JWT APIs**: issue or copy the token from your auth flow
- **NeNe sample TODO module**: OpenAPI uses **`sessionCookie`**, not Bearer — see [NeNe catalog patterns](/howto/neene-catalog-patterns) (authenticated TODO over MCP needs host-side Bearer support or a different API)
- **Login tools marked `write`**: nene-mcp requires env Bearer even when the HTTP login route is public — you may use a placeholder value for fail-closed bootstrap on cookie-based hosts

nene-mcp forwards the token as `Authorization: Bearer …` on HTTP calls when the env var is set.

## Credentials in MCP arguments

Login or write tools that take passwords in `tools/call` arguments expose those values to **MCP host logs and agent transcripts**. Use dev-only accounts; never commit secrets to catalog JSON or git.

## Read tools

`safety: read` tools do not require Bearer in nene-mcp unless you set the env var (Bearer is then sent on GET as well). Hosts that require session cookies on GET are not covered by Bearer alone — see [NeNe catalog patterns](/howto/neene-catalog-patterns).

## Related

- [Security model](/explanation/security-model)
- [Environment variables](/reference/environment-variables)
- [NeNe catalog patterns](/howto/neene-catalog-patterns)
