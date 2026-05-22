# Field Trial 204 — Persona: docs-only, authenticated TODO business module (hard)

## Date

2026-05-22

## Baseline

- nene-mcp ref: `v0.1.3` (Packagist verified)
- FT clone: `../nene-mcp-FT/ft204-persona-business-hard/` (catalog) + shared NeNe `ft201-persona-business/nene-app/`
- Persona: **Backend lead** — **public docs only** ([hideyukimori.github.io/nene-mcp](https://hideyukimori.github.io/nene-mcp/)); no repo source, no FT tribal knowledge
- Scenario: Ship MCP for a **real business module** — health + session login + authenticated todo list/create (multi-step auth, path params, subdirectory deployment)
- MCP client: stdio harness (Cursor spawn simulation)
- NeNe HTTP: `http://localhost:8080` (pre-existing Docker — persona cannot discover from nene-mcp docs alone; same gap as FT201 F-2)

## Goal

From public docs alone: build a **five-tool catalog** (health, listTodos, getTodoById, sessionLogin, createTodo), configure Bearer for writes, and achieve a working **login → list → create** agent workflow on NeNe.

**Difficulty ramp vs FT201:** FT201 stopped at health + fake `listOrders` (404). FT204 requires authenticated reads/writes, OpenAPI path mapping, write fail-closed, and subdirectory base URL debugging.

## Persona journey (docs-only)

### 1. Catalog from OpenAPI + Reference

Persona maps NeNe OpenAPI (`healthCheck`, `listTodos`, `login`, `createTodo`, `getTodo`) into [catalog-format](https://hideyukimori.github.io/nene-mcp/reference/catalog-format) entries. Uses standard `{id}` path for `getTodoById` → `/todo/item/{id}` (common OpenAPI style).

**Finding (F-1)**: NeNe OpenAPI path is `/todo/item/id_{id}` (key-value segment), not `/todo/item/{id}`. Catalog interpolation only replaces `{param}` tokens — persona gets **HTTP 405** with `/todo/item/1`. Severity: **high** — docs-only integrator cannot infer NeNe path convention from catalog-format alone. **Decision: document** — NeNe path-parameter howto (#36).

### 2. Bearer for writes per write-tools-bearer

Docs: [Write tools & Bearer](https://hideyukimori.github.io/nene-mcp/howto/write-tools-bearer) — *"NeNe / NENE2: login endpoint → session Bearer (see host docs)"*.

Persona sets `NENE_MCP_BEARER_TOKEN` from docs guidance, marks `sessionLogin` and `createTodo` as `safety: write`.

Write fail-closed **works**: `sessionLogin` without Bearer → JSON-RPC error, no HTTP (**Pass**, same as FT9/202).

With Bearer set, `sessionLogin` → HTTP **200**, body includes `csrfToken`.

**Finding (F-2)**: NeNe OpenAPI declares **`sessionCookie`** security on `/todo/*`, not Bearer. nene-mcp sends only `Authorization: Bearer …` and **does not persist Set-Cookie** across MCP calls. After successful `sessionLogin`, `listTodos` still returns **401 SESSION-CLOSED**. Severity: **high** — docs imply Bearer is sufficient for NeNe; authenticated business reads/writes are **not achievable** with current bridge + docs. **Decision: document** (integrate-nene limitation) + **trade-off** (stateless proxy vs cookie jar — ADR candidate).

### 3. Authenticated read without write-first path

Persona tries `listTodos` (`safety: read`) with Bearer env set.

**Result**: HTTP **401 SESSION-CLOSED**, `isError: true`. NeNe ignores Bearer on todo routes.

**Finding (F-3)**: **medium** — [integrate-nene](https://hideyukimori.github.io/nene-mcp/howto/integrate-nene) does not warn that NeNe sample TODO module requires **cookie session**, while nene-mcp is **Bearer-only, stateless**. Persona cannot complete the stated business goal without reading NeNe source. **Decision: document** (#36).

### 4. createTodo after login

With Bearer + prior `sessionLogin` in separate `tools/call`: `createTodo` → **401 SESSION-CLOSED** (no cookie/CSRF forwarded).

Confirms F-2/F-3 — multi-step MCP workflows on cookie-auth APIs need explicit documentation of the gap.

### 5. Subdirectory / wrong base URL (URI_ROOT theme)

Persona deploys NeNe under `/mybiz/` mentally; sets `NENE_MCP_API_BASE_URL=http://localhost:8080/mybiz` while catalog paths stay `/health/index`.

**Result**: HTTP **404** on health; MCP returns structured 404 with `isError: true` (not JSON-RPC transport error).

**Finding (F-4)**: **medium** — no docs site guidance on aligning `NENE_MCP_API_BASE_URL` with NeNe `URI_ROOT` / reverse-proxy path prefix. Persona must read NeNe deployment docs (outside nene-mcp). **Decision: document** — cross-link on integrate-nene (#36).

### 6. Chicken-and-egg: login tool requires Bearer

NeNe `/session/login` accepts unauthenticated POST, but nene-mcp **blocks** `sessionLogin` unless `NENE_MCP_BEARER_TOKEN` is set (write fail-closed).

Persona must set a **placeholder Bearer** to reach login — docs do not explain this bootstrap pattern for cookie-based hosts.

**Finding (F-5)**: **medium** — operational papercut for cookie-auth hosts. **Decision: document** (#36).

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| `getHealthCheck` | HTTP 200 | 200 | Pass |
| `listTodos` with Bearer | Business list | 401 SESSION-CLOSED | **Fail** (auth model gap) |
| `sessionLogin` without Bearer | Fail-closed | JSON-RPC error, no HTTP | Pass |
| `sessionLogin` with Bearer | HTTP 200 | 200 + csrfToken in body | Pass |
| `listTodos` after login (separate call) | 200 list | 401 SESSION-CLOSED | **Fail** (no cookie jar) |
| `createTodo` with Bearer, no session | 401 or success | 401 SESSION-CLOSED | Expected API behavior |
| `getTodoById` path `/todo/item/{id}` | 200 | 405 | **Fail** (NeNe path convention) |
| Base URL `…/mybiz` + `/health/index` | Degraded/404 | 404, isError | Pass (detectable) |
| Duplicate tool names | Reject catalog | N/A this FT | N/A |

## Friction Summary

| ID | Location | Severity | Kind | Decision |
| --- | --- | --- | --- | --- |
| F-1 | NeNe `id_{id}` vs catalog `{id}` | high | docs-gap | document (#36) |
| F-2 | Bearer docs vs NeNe sessionCookie | high | design-trade-off | document (#36); ADR if cookie jar rejected |
| F-3 | integrate-nene silent on cookie auth | medium | docs-gap | document (#36) |
| F-4 | URI_ROOT / base URL alignment | medium | docs-gap | document (#36) |
| F-5 | Write fail-closed vs unauthenticated login endpoint | medium | docs-gap | document (#36) |

**Friction count: 5 (all actionable).** FT201 was too simple (health + 404 fake order); this FT blocked the persona on real business auth — **by design** for difficulty ramp.

## Recommendations

### Immediate (documentation)

1. **F-1 — NeNe path parameters**: Add howto example using `/todo/item/id_{id}` in catalog `path`.
2. **F-2/F-3 — Session vs Bearer**: Correct write-tools-bearer NeNe bullet; add integrate-nene callout: nene-mcp is stateless Bearer-only; NeNe TODO sample requires cookies — authenticated MCP on NeNe needs host-side Bearer support or a different auth scheme.
3. **F-4 — Base URL**: Document `NENE_MCP_API_BASE_URL` must include deployment path prefix when NeNe uses `URI_ROOT`.
4. **F-5 — Login bootstrap**: Note that write-marked login tools still require env Bearer even when the HTTP endpoint is public.

### Suggested (package change)

None for this FT — cookie persistence is a deliberate scope boundary unless ADR approves a jar.

### Trade-offs (ADR or cross-repo)

1. **F-2 — Stateless proxy vs cookie jar**: nene-mcp could add optional cookie store per MCP process; cost: state, CSRF, security review. Alternative: NeNe adds Bearer-compatible auth for API agents (NeNe repo).

## Security Review (required when N % 3 == 0)

FT204 — `204 % 3 == 0`.

### SSRF and URL control

- [x] Catalog paths cannot target hosts outside `NENE_MCP_API_BASE_URL`
- [x] Redirect following disabled (`follow_location: 0`)
- **Result**: Pass — subdirectory mistake stays on configured host, returns 404.

### Secret handling

- [x] Bearer not in catalog or `nene_mcp_about`
- [x] `sessionLogin` response includes `csrfToken` in MCP tool body (expected API data, not env leak)
- [ ] **Note**: Login `user_pass` travels in MCP `arguments` → agent transcript risk — document for operators
- **Result**: Conditional — no env leak; credential-in-arguments is integrator hygiene (#36 doc note).

### Write tools

- [x] Write tools without Bearer fail closed (no HTTP)
- [x] Placeholder Bearer does not bypass NeNe session checks on todo writes
- **Result**: Pass — API enforces session; bridge does not silently write.

### JSON-RPC / protocol

- [x] 401/405 returned as structured tool errors, not process crash
- **Result**: Pass

**Security summary**: **conditional** — bridge fail-closed behavior good; document credential handling in MCP transcripts and NeNe session limitation (#36).

## Follow-up Issues

| Priority | Issue | Decision |
| --- | --- | --- |
| high | [#36](https://github.com/hideyukiMORI/nene-mcp/issues/36) | document — PR `docs/36-nene-auth-path-uri` |
| high | (NeNe, optional) | fix-in-host — Bearer auth for agent API surface → [NeNe #380](https://github.com/hideyukiMORI/NeNe/issues/380) |

## Overall Impression

FT201–203 **did have friction** (version pin, ja lag, JSON-RPC vs HTTP errors) but the business scenario was too shallow. FT204 surfaces a **real integrator wall**: cookie-session NeNe + Bearer-only stateless nene-mcp. Docs that say "session Bearer" for NeNe are misleading. Difficulty ramp should continue toward multi-locale parity and optional NeNe/host auth alignment.

## Next FT gate

- [ ] #36 closed before FT205
- [ ] Consider FT205: fr/zh locale parity **or** Laravel/non-NeNe Bearer-native host to contrast F-2
