# SMB adoption checklist

Use this when rolling out nene-mcp to **internal teams or staging** — not as a customer-facing API gateway. See [Commercial use & production scope](/explanation/commercial-use-and-scope).

## When this tier fits

| Signal | SMB tier OK? |
| --- | --- |
| Cursor / Claude Desktop for engineers | Yes |
| Internal QA against staging API | Yes |
| VPN or private HTTPS with internal CA | Yes (with `NENE_MCP_TLS_CA_FILE`) |
| End-user production gateway | **No** |
| SLA / multi-tenant HA front door | **No** |

## Pre-flight

- [ ] Pin exact Composer version (e.g. `hideyukimori/nene-mcp:0.1.8`) — not floating `^0.1` when audit matters
- [ ] `NENE_MCP_API_BASE_URL` points to **trusted** host only
- [ ] `NENE_MCP_TOOLS_JSON` is an **absolute** path readable by the MCP host
- [ ] Write tools: `NENE_MCP_BEARER_TOKEN` in MCP host env — never in catalog or git
- [ ] Run [catalog smoke test](/howto/catalog-smoke-test)
- [ ] Run `composer check` if you vendor patches

## Optional operator env (v0.1.8+)

| Need | Env |
| --- | --- |
| Slow staging API | `NENE_MCP_HTTP_TIMEOUT_SEC` (`1`–`120`, default `10`) |
| Private CA HTTPS | `NENE_MCP_TLS_CA_FILE` → PEM bundle path |
| Debug HTTP without polluting stdout | `NENE_MCP_LOG=stderr` |

Verify with `nene_mcp_about` — `runtime` includes `httpTimeoutSec`, `tlsCaFileConfigured`, `httpLogStderr` (flags only, no secrets).

## Regression smoke

```bash
composer check
tools/ft-runner.sh write-failclosed /tmp/smb-write-check
tools/ft-runner.sh security-catalog /tmp/smb-sec-check
```

## Stop signals (escalate architecture)

- Need connection pooling or shared session across MCP spawns → host-side API or custom client wrapper
- Need long-lived HTTP/SSE MCP server → separate package / service — not stdio bridge
- Need custom retry / circuit breaker → wrap upstream API or inject custom `McpHttpClientInterface` in a fork

## Related

- [Environment variables](/reference/environment-variables)
- [Commercial use & production scope](/explanation/commercial-use-and-scope)
- [Security model](/explanation/security-model)
- Epic [#89](https://github.com/hideyukiMORI/nene-mcp/issues/89)
