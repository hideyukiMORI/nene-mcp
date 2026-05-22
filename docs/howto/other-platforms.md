# Other platforms

The same stdio MCP bridge works for **any HTTP API** when you provide a NENE2-compatible catalog.

## PHP frameworks

| Stack | Approach |
| --- | --- |
| Laravel / Symfony / CodeIgniter | `composer require hideyukimori/nene-mcp`; point base URL at your app |
| Vanilla PHP | Bridge repo or app `vendor/bin/nene-mcp` |

## Other languages

Run nene-mcp as a **sidecar PHP process** next to Node, Python, or Go APIs:

1. API exposes OpenAPI-documented REST
2. Generate or hand-write `tools.json` from OpenAPI
3. MCP host spawns `php /path/to/vendor/bin/nene-mcp`

## Pattern B — vanilla bridge repo

Field Trial 7 validated a framework-free clone. For a **Bearer-native** inventory walkthrough (contrast with NeNe session cookies), see [Bearer-native bridge example](/howto/bearer-native-bridge-example).

```text
my-api-bridge/
├── composer.json          # requires hideyukimori/nene-mcp
├── docs/mcp/tools.json
└── .cursor/mcp.json       # spawns vendor/bin/nene-mcp
```

Your API stays in any language; only the MCP process requires PHP 8.2+.

## Non-goals

- nene-mcp does not embed Laravel/Symfony adapters
- nene-mcp does not generate catalogs from OpenAPI automatically (use NENE2/NeNe tooling or hand-maintain JSON)

## Related

- [Integrate with NeNe](/howto/integrate-nene)
- [Bearer-native bridge example](/howto/bearer-native-bridge-example)
- [Tool catalog format](/reference/catalog-format)
