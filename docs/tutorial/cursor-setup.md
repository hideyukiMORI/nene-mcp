# Cursor / MCP client setup

Configure your MCP host to spawn `vendor/bin/nene-mcp` over stdio with environment variables.

## With tool catalog (typical)

Use **absolute paths** for `php` args and `NENE_MCP_TOOLS_JSON`:

```json
{
  "mcpServers": {
    "nene-mcp": {
      "command": "php",
      "args": ["/ABS/PATH/vendor/bin/nene-mcp"],
      "env": {
        "NENE_MCP_API_BASE_URL": "http://localhost:8080",
        "NENE_MCP_TOOLS_JSON": "/ABS/PATH/your-app/docs/mcp/tools.json"
      }
    }
  }
}
```

## Catalog-free smoke test

Omit `NENE_MCP_TOOLS_JSON` until the catalog file exists:

```json
{
  "mcpServers": {
    "nene-mcp": {
      "command": "php",
      "args": ["/ABS/PATH/vendor/bin/nene-mcp"],
      "env": {
        "NENE_MCP_API_BASE_URL": "http://localhost:8080"
      }
    }
  }
}
```

Do **not** point `NENE_MCP_TOOLS_JSON` at a placeholder path — a missing file fails `tools/list` entirely.

::: tip Relative paths sometimes work — still avoid them
If the MCP host starts with cwd = your project root, `docs/mcp/tools.json` may resolve **once** on your machine. Teammates opening a subfolder, monorepo packages, or CI agents with a different cwd will get **catalog not found** with no HTTP error. Use **absolute paths** in committed `.cursor/mcp.json` templates, or document per-developer substitution (see below).
:::

## Write tools

When the catalog includes `"safety": "write"` entries, add Bearer only in the MCP host env block — never in git:

```json
"env": {
  "NENE_MCP_API_BASE_URL": "http://localhost:8080",
  "NENE_MCP_TOOLS_JSON": "/ABS/PATH/docs/mcp/tools.json",
  "NENE_MCP_BEARER_TOKEN": "your-session-token"
}
```

See [Write tools & Bearer](/howto/write-tools-bearer).

## Verify

1. MCP server starts without stderr stack traces
2. `tools/list` returns `nene_mcp_about` (+ catalog tools when configured)
3. `tools/call` on a read tool returns HTTP status and JSON body
