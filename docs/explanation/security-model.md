# Security model

nene-mcp assumes a **local-dev MCP bridge** to a trusted base URL. Threat model focuses on misconfiguration and catalog mistakes.

For **commercial adoption boundaries** (developer tool vs production gateway), see [Commercial use & production scope](/explanation/commercial-use-and-scope).

## Defaults

| Control | Behavior |
| --- | --- |
| Write tools | Fail closed without `NENE_MCP_BEARER_TOKEN` |
| HTTP redirects | Disabled (`follow_location = 0`) — prevents internal SSRF via redirects |
| Duplicate tool names | Rejected at catalog load (v0.1.3+) |
| Invalid `safety` value | Rejected at catalog load — must be `read` or `write` (v0.1.7+) |
| Secrets | Bearer only in env; never in catalog or `nene_mcp_about` |
| JSON-RPC errors | Safe messages; no stack traces on stdout |

## SSRF considerations

- Catalog paths append to configured base URL
- Absolute URLs in catalog paths produce malformed requests against the base host — not arbitrary host fetch
- Redirect following disabled after FT3 finding

## Operator responsibilities

- Keep Bearer tokens out of git and catalog JSON
- Pin Packagist versions for production-like trials
- Review `safety: write` entries before sharing MCP config
- `nene_mcp_about` may include `catalogPath` (filesystem path to `tools.json`) for operator debugging — not a secret, but omit catalog from shared MCP configs if path disclosure matters
- Align `safety` with HTTP method + OpenAPI auth — do not label Bearer-protected POST as `read` ([write-tools-bearer](/howto/write-tools-bearer#safety-label-vs-http-method))

## Reporting

See repository `SECURITY.md` and [security policy](https://github.com/hideyukiMORI/nene-mcp/blob/main/docs/development/security-policy.md) for implementers.

Field Trial security cadence: every FT where `N % 3 == 0`.

## Related

- [Write tools & Bearer](/howto/write-tools-bearer)
- [Field trials](/contributing/field-trials)
