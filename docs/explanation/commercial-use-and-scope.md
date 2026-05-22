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

### 2. Fixed HTTP timeout

`NativeMcpHttpClient` uses a **10 second** stream timeout (not configurable via env today). Slow upstream APIs or long-running operations may fail without operator code changes.

### 3. Limited TLS flexibility

Default PHP stream TLS verification applies for `https://` targets. This package does **not** expose:

- Custom CA bundles
- Client certificates
- Certificate pinning

Operators needing these controls should terminate TLS elsewhere or inject a custom `McpHttpClientInterface` in a fork/wrapper (not shipped here).

### 4. No retry or observability hooks

Network failures surface immediately as MCP JSON-RPC errors. By design:

- No automatic retries or circuit breakers
- No structured logging, metrics, or trace IDs on stdout/stderr (stdout is JSON-RPC only)

Production monitoring requires wrapping the process or instrumenting at the MCP host level.

### 5. Pre-1.0 contract

During `0.x.y` ([release policy](/development/release-policy)):

- JSON-RPC behavior, env var names, and catalog schema may change with CHANGELOG notice
- Do not promise multi-year API stability or SLA on `0.x` tags

Pin exact versions (`0.1.7`, not floating `^0.1`) when compliance or audit requires reproducibility.

### 6. Cross-repo integration gaps

Some host paths remain **verified only after host fixes**. Example: NeNe TODO Bearer E2E is gated on [NeNe #380](https://github.com/hideyukiMORI/NeNe/issues/380) / [#395](https://github.com/hideyukiMORI/NeNe/issues/395); nene-mcp **FT450** runs when those close. Until then, stock NeNe TODO over MCP is a documented defer—not a nene-mcp regression.

---

## Operating recommendations (when “Yes”)

| Practice | Why |
| --- | --- |
| Pin Composer version | Avoid silent behavior changes on `0.x` |
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
