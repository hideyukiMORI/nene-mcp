# Commercial use & production scope

This page states **what nene-mcp is for** and **what it is not**, so teams can decide adoption without misreading the security model or field-trial coverage.

## Design premise

From [Security model](/explanation/security-model):

> nene-mcp assumes a **local-dev MCP bridge** to a **trusted base URL**.

That is the starting point. Commercial viability depends on **which side of the bridge** you operate on—not on whether the package is “enterprise grade” in abstract.

## One-line summary

**Good fit:** developers use AI (Cursor, Claude Desktop, etc.) to call **their own** REST APIs over MCP.

**Poor fit:** nene-mcp becomes **customer-facing production infrastructure** (API gateway, SLA-backed service, high-availability front door).

---

## Decision matrix

| Use case | Commercial use | Notes |
| --- | --- | --- |
| Developer tool (Cursor / Claude Desktop / IDE MCP) | **Yes** | Matches design intent; fail-closed writes, SSRF mitigation, secret handling validated in FT band |
| Internal AI workflow (dev / QA teams) | **Yes** | Pin Composer version + Bearer in host env; treat API base URL as trusted |
| **SMB internal / staging** (checklist) | **Yes with checklist** | v0.1.8+: timeout, TLS CA, stderr HTTP log — see [SMB adoption checklist](/explanation/smb-adoption-checklist) |
| Staging demos & verification | **Yes** | Same constraints as local dev; pin versions for reproducibility |
| End-user production API gateway | **No** | Wrong architecture—see [Out of scope](#out-of-scope-for-production-gateway-use) |
| SLA-backed hosted service | **No** | `0.x` releases do not promise long-term wire/env/catalog stability ([release policy](/development/release-policy)) |
| High availability / high throughput | **No** | stdio spawn model; no pooling, shared state, or horizontal scaling in this package |

---

## In scope (commercially reasonable)

These scenarios align with how the package is built and tested:

- **AI-assisted development** — engineers invoke catalog tools against localhost, staging, or VPN-reachable internal APIs.
- **QA / staging automation** — MCP hosts run `vendor/bin/nene-mcp` with pinned `^0.1` and explicit env vars.
- **Internal platforms** — platform teams document catalog + env for *their* developers; nene-mcp remains a sidecar stdio process, not a shared multi-tenant service.

Quality signals for this tier:

- 500+ individual field-trial reports with adversarial bands (L6–L9)
- PHPUnit + PHPStan level 8 in CI (`composer check`)
- Documented security defaults (redirect off, Bearer fail-closed, catalog validation)

---

## Out of scope for production gateway use

Do **not** deploy nene-mcp as the public edge for customer traffic. Reasons are **architectural**, not missing polish:

### 1. stdio spawn model

MCP hosts start a **new PHP process per session** (or per tool batch). There is:

- No connection pooling to upstream APIs
- No shared session state between spawns
- No built-in concurrency control beyond the host OS

High-frequency or multi-tenant traffic needs a **long-lived HTTP/SSE MCP server** or a reverse proxy layer—out of scope for this library.

### 2. HTTP timeout (configurable since v0.1.8)

`NENE_MCP_HTTP_TIMEOUT_SEC` (default `10`, range `1`–`120`) replaces the former hard-coded limit. Invalid values fall back to `10`.

### 3. TLS flexibility (partial, v0.1.8+)

`NENE_MCP_TLS_CA_FILE` sets a PEM CA bundle for `https://` base URLs. Still **no** client certificates or certificate pinning in the default client.

### 4. Observability (opt-in, v0.1.8+)

`NENE_MCP_LOG=stderr` emits one safe line per HTTP call on stderr. stdout remains JSON-RPC only. No metrics/trace IDs in-package.

### 5. No automatic retry

Network failures surface immediately as MCP JSON-RPC errors unless the host or upstream API retries.

### 6. Pre-1.0 contract

During `0.x.y` ([release policy](/development/release-policy)):

- JSON-RPC behavior, env var names, and catalog schema may change with CHANGELOG notice
- Do not promise multi-year API stability or SLA on `0.x` tags

Pin exact versions (`0.1.8`, not floating `^0.1`) when compliance or audit requires reproducibility.

### 7. Cross-repo integration gaps

Some host paths remain **verified only after host fixes**. Example: NeNe TODO Bearer E2E is gated on [NeNe #380](https://github.com/hideyukiMORI/NeNe/issues/380) / [#395](https://github.com/hideyukiMORI/NeNe/issues/395); nene-mcp **FT450** runs when those close. Until then, stock NeNe TODO over MCP is a documented defer—not a nene-mcp regression.

---

## Operating recommendations (when “Yes”)

| Practice | Why |
| --- | --- |
| Pin Composer version | Avoid silent behavior changes on `0.x` |
| Tune timeout / TLS CA / stderr log | See [SMB adoption checklist](/explanation/smb-adoption-checklist) |
| Keep Bearer in MCP host `env` | Never in catalog or git |
| Use trusted base URLs only | SSRF model assumes operator-controlled target |
| Run [catalog smoke test](/howto/catalog-smoke-test) before rollout | Catches catalog mistakes early |
| Run `composer check` in your fork/CI if you vendor patches | Same gate as upstream |

---

## If you need production gateway semantics

Open an Issue describing the requirement. Likely outcomes:

- **Host-side** reverse proxy + Bearer at the API layer (nene-mcp unchanged)
- **Separate package** for long-lived MCP transport (HTTP/SSE)—not a bolt-on to stdio bridge
- **Custom `McpHttpClientInterface`** for timeouts, TLS, retries—injected outside this repo’s default bootstrap

---

## Related

- [Scope & mission](/explanation/scope)
- [Security model](/explanation/security-model)
- [Architecture](/explanation/architecture)
- [Release policy](/development/release-policy)
- [Integration guide](/integration/README)
