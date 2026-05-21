# NeNe Integration

Add nene-mcp **plugin-style** to a NeNe app. No NeNe fork and no MCP code in `class/xion/`.

## Relationship to NeNe

NeNe is a **small, readable legacy-style PHP framework** ([NeNe docs/project.md](https://github.com/hideyukiMORI/NeNe/blob/main/docs/project.md)).  
nene-mcp sits beside it as a **Composer dependency**—an MCP bridge, not framework core.

```text
NeNe app repo
├── composer.json          ← require hideyukimori/nene-mcp
├── docs/
│   ├── api/openapi.yaml   ← HTTP contract (NeNe standard)
│   └── mcp/
│       └── tools.json     ← MCP tool contract (app-owned)
├── vendor/bin/nene-mcp    ← stdio MCP server
└── class/ ...             ← NeNe core unchanged
```

## Steps

### 1. Add via Composer

At the NeNe app root (where `composer.json` lives):

```bash
composer require hideyukimori/nene-mcp
```

Same after cloning the NeNe template repo when the app already has `composer.json`.

### 2. Add a tool catalog

Write OpenAPI-aligned entries in `docs/mcp/tools.json` (path is flexible; this path matches NeNe / NENE2 convention).

Minimal health example: [`../example-ne-health-catalog.md`](../example-ne-health-catalog.md)

Rules:

- `source.type: openapi` — match `method`, `path`, and `operationId` to OpenAPI
- `safety: read` / `write` — safety classification for MCP clients
- With subdirectory deploy (`URI_ROOT`), align `path` and `servers.url`

### 3. Start the local API

As usual for NeNe:

```bash
docker compose up
# or traditional Apache/PHP setup
```

Default base URL: `http://localhost:8080`

### 4. Configure the MCP client (Cursor)

Project or user MCP config (e.g. `.cursor/mcp.json`):

```json
{
  "mcpServers": {
    "nene-mcp": {
      "command": "php",
      "args": ["/ABS/PATH/TO/ne-app/vendor/bin/nene-mcp"],
      "env": {
        "NENE_MCP_API_BASE_URL": "http://localhost:8080",
        "NENE_MCP_TOOLS_JSON": "/ABS/PATH/TO/ne-app/docs/mcp/tools.json"
      }
    }
  }
}
```

Use **absolute paths**. Add `NENE_MCP_BEARER_TOKEN` only when tools need Bearer (never commit it).

### 5. Verify

1. MCP server `nene-mcp` shows healthy in Cursor
2. `tools/list` includes `nene_mcp_about` and catalog tools
3. Calling `getHealthCheck` (etc.) returns NeNe REST responses

## NeNe development notes

- **Framework boundary**: MCP lives in `vendor/` (nene-mcp). Do not add it to `class/xion/`
- **OpenAPI first**: update OpenAPI before `tools.json` for new REST endpoints (same as NeNe API policy)
- **Secrets**: tokens only in `.env` or MCP env—not in `tools.json` or PHP source
- **Issue-driven**: feature work in NeNe and bug fixes in nene-mcp each get their own Issue in the respective repo

## NENE2 compatibility

`NENE2_LOCAL_API_BASE_URL` and `NENE2_LOCAL_TOOLS_JSON` are accepted aliases when migrating from NENE2 local MCP docs.

## References

- [nene-mcp project overview](../project.md)
- [NeNe README](https://github.com/hideyukiMORI/NeNe/blob/main/README.md)
- [NeNe building-a-service](https://github.com/hideyukiMORI/NeNe/blob/main/docs/tutorials/building-a-service.md)
