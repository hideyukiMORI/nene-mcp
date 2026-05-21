# Other Frameworks, Vanilla PHP, and Other Languages

nene-mcp is **not NeNe-only**.  
Describe any HTTP API with a NENE2-compatible `tools.json` and the same stdio MCP server exposes it to AI agents.

## Common model

```text
[MCP host] ──stdio──► [nene-mcp (PHP)] ──HTTP──► [your API]
```

- **Host** (Cursor, Claude Desktop, custom agent): MCP protocol and UI
- **nene-mcp**: tool listing and HTTP proxy (requires PHP 8.2+ on the host machine)
- **API**: any language or framework; REST/JSON responses are enough

No `require` of NeNe.

---

## PHP: other frameworks (Laravel, Symfony, CodeIgniter, etc.)

### 1. Install nene-mcp via Composer

```bash
composer require hideyukimori/nene-mcp
```

No framework patches needed.

### 2. Provide tools.json from OpenAPI or by hand

Copy `operationId`, `method`, and `path` into catalog entries when OpenAPI exists.  
NeNe sample: [`../example-ne-health-catalog.md`](../example-ne-health-catalog.md)

Example layout:

```text
your-app/
├── docs/mcp/tools.json
└── vendor/bin/nene-mcp
```

### 3. Start the dev server

Use the framework dev server (`php artisan serve`, Symfony CLI, built-in PHP server, etc.) and set `NENE_MCP_API_BASE_URL` to that URL.

### 4. MCP configuration

Same shape as [`nene.md`](nene.md). Point `args` at your app's `vendor/bin/nene-mcp`.

---

## PHP: vanilla (no framework)

### Pattern A — add Composer to the API project

```bash
composer init
composer require hideyukimori/nene-mcp
```

Add `docs/mcp/tools.json` and pass the base URL of your existing `index.php` API via env.

### Pattern B — separate MCP bridge directory

If the API repo has no Composer, use a **small wrapper repo** for MCP only:

```text
mcp-bridge/
├── composer.json          ← require hideyukimori/nene-mcp
├── docs/mcp/tools.json    ← endpoints for your vanilla PHP API
└── vendor/bin/nene-mcp
```

Point `NENE_MCP_API_BASE_URL` at the vanilla app URL in MCP env.  
The API's PHP version can differ from nene-mcp's 8.2+ requirement, but the **stdio server** needs PHP 8.2+ on the MCP host machine.

---

## Other languages (Node.js, Python, Go, Ruby, etc.)

nene-mcp is a **PHP stdio MCP server**. Non-PHP APIs work when:

| Requirement | Notes |
| --- | --- |
| HTTP API | Responses match what the catalog expects (usually JSON) |
| Local reachability | MCP host can reach the API URL |
| PHP 8.2+ | To run `nene-mcp` (not required in the API itself) |
| tools.json | Endpoints in NENE2-compatible format |

### Example: Node API + PHP MCP bridge

1. Run Node API at `http://localhost:3000`
2. Install nene-mcp in a Composer-only directory (or monorepo `tools/mcp/`)
3. Define `GET /health` etc. in `tools.json`
4. MCP client config:

```json
{
  "mcpServers": {
    "my-api-mcp": {
      "command": "php",
      "args": ["/ABS/PATH/mcp-bridge/vendor/bin/nene-mcp"],
      "env": {
        "NENE_MCP_API_BASE_URL": "http://localhost:3000",
        "NENE_MCP_TOOLS_JSON": "/ABS/PATH/mcp-bridge/docs/mcp/tools.json"
      }
    }
  }
}
```

The API language and MCP server language (PHP) are **deliberately separate**—that is the point of this layout.

### vs native MCP SDKs in other languages

| Approach | Best for |
| --- | --- |
| **nene-mcp** | Reuse existing REST. Share contracts via OpenAPI/tools.json. Same catalog as NeNe/NENE2 |
| **Language MCP SDK** | New MCP-only handlers. Direct DB access without HTTP |

You can register both in Cursor's `mcpServers`.

---

## Security

- Pass Bearer for `safety: write` tools via env ([`SECURITY.md`](../../SECURITY.md))
- Do not point MCP at production URLs (local dev / verification only)
- Never embed credentials in the catalog

---

## Summary

| Platform | How to add nene-mcp |
| --- | --- |
| NeNe | `composer require` at app root → [`nene.md`](nene.md) |
| Other PHP FW | Same |
| Vanilla PHP | Composer on API or MCP bridge mini repo |
| Other-language API | MCP bridge mini repo + `tools.json` + env |

Same NeNe idea at the MCP layer: stay small, make contracts explicit, do not pollute framework core.
