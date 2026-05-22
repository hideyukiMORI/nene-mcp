# Field Trial 215 — L5 NeNe CSRF write chain

## Date

2026-05-22

## Baseline

- nene-mcp ref: `main`
- NeNe: `http://localhost:8080` (FT2 Docker)
- Persona: **Backend integrator** cataloging `createTodo` / `updateTodo` after FT204 session-cookie wall
- MCP: stdio + FT204 business catalog

## Goal

Determine whether NeNe TODO **writes** fail only on cookies, or also on **CSRF** — and whether docs mention it.

## Steps

### 1. Native HTTP (curl, cookie jar)

| Step | Result |
| --- | --- |
| `POST /session/login` | 200, `csrfToken` in body |
| `POST /todo/index` with cookie, **no** `X-CSRF-Token` | `CSRF-TOKEN-INVALID` |
| `POST /todo/index` with cookie + `X-CSRF-Token` | **success** |

### 2. MCP path (prior FT204)

`createTodo` via nene-mcp → **401 SESSION-CLOSED** (no cookie). Even with hypothetical cookie persistence, nene-mcp sends **no** `X-CSRF-Token`.

**Finding (F-1)**: **high** — OpenAPI documents `csrfToken` on writes; nene-mcp docs (post-#36) covered cookies but **not CSRF header chain**. Persona assumes login tool body `csrfToken` can feed writes — **not supported**. **Decision: document** (#51).

**Finding (F-2)**: **medium** — design trade-off: catalog has no header/body→header mapping. Defer code; link [NeNe #380](https://github.com/hideyukiMORI/NeNe/issues/380).

## Host matrix (NeNe vs Bearer-native)

| Capability | NeNe sample TODO | FT206 Bearer mock |
| --- | --- | --- |
| Public health read | ✅ | ✅ |
| Auth on GET | session cookie | Bearer |
| MCP stateless calls | ❌ cookie | ✅ Bearer env |
| Write CSRF | `X-CSRF-Token` required | N/A |
| MCP write E2E | ❌ | ✅ |

## Friction Summary

| ID | Severity | Decision |
| --- | --- | --- |
| F-1 | high | document CSRF in neene-catalog-patterns (#51) |
| F-2 | medium | trade-off / NeNe #380 |

## Follow-up

#51 — doc PR

## Next gate

#51 closed before FT216
