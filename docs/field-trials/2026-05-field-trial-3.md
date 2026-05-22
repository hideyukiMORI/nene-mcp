# Field Trial 3 — Security review (read-only baseline)

## Date

2026-05-22

## Baseline

- nene-mcp ref: `v0.1.1` (Packagist); fix validated on working tree → **v0.1.2**
- FT clone path: `../nene-mcp-FT/ft3-security-readonly/` (catalog probes); NeNe stack from `../nene-mcp-FT/ft2-nene-cursor-docker/`
- Host app: NeNe Docker MySQL (`http://localhost:8080`)
- PHP: 8.4.21
- MCP client: stdio adversarial probes (scripted JSON-RPC)
- Env: standard `NENE_MCP_*`; Bearer probe `super-secret-token-ft3-probe` (synthetic, not committed)

## Goal

FT3 (`N % 3 == 0`): adversarial security review of read-only MCP path—SSRF, secret leakage, write fail-closed, JSON-RPC robustness.

## Integration Built

- Catalog probes under `ft3-security-readonly/catalogs/` (health baseline, SSRF paths, write tool, redirect probe)
- NeNe Docker from FT2 (golden path reuse)

## Steps Taken

### 1. Golden path replay

Confirmed `getHealthCheck` → HTTP 200 / MySQL health (same as FT2).

### 2. SSRF and URL control (adversarial catalog paths)

Injected malicious `source.path` values while `NENE_MCP_API_BASE_URL=http://localhost:8080`:

| Path pattern | Constructed URL | Observed |
| --- | --- | --- |
| `/health/index` | normal | 200 health JSON |
| `http://127.0.0.1:8081/` | `http://localhost:8080http://127.0.0.1:8081/` | 400 Bad Request — no escape |
| `//127.0.0.1:8081/` | `http://localhost:8080//127.0.0.1:8081/` | 200 NeNe HTML on same host — no cross-port reach |
| `/health/../../../etc/passwd` | dot segments | 400 Bad Request |

**Finding (F-1)**: Catalog does not require paths to start with `/`. No cross-host escape was observed in path concatenation alone; document or validate in a future FT.

### 3. HTTP redirect following (adversarial)

Mock API on `127.0.0.1:9998` returned `302 Location: http://127.0.0.1:8081/` (phpMyAdmin).

Before fix: MCP client followed redirect; response **body contained phpMyAdmin HTML** while `statusCode` remained `302`.

**Finding (F-2)**: `NativeMcpHttpClient` used default PHP redirect following — **internal SSRF** when the trusted base URL returns redirects to other local ports. **Severity: medium** (`security-gap`, `fix-in-package`).

Fix applied: `follow_location => 0`, `max_redirects => 0` in stream context. Re-test: body no longer contains phpMyAdmin content.

### 4. Secret handling

- `nene_mcp_about` with Bearer set → exposes `hasBearerTokenConfigured: true` only; **token string absent** from stdout
- JSON-RPC errors on HTTP failure → message includes URL (`http://127.0.0.1:59999/health/index`) but **not** Bearer token
- stderr empty across probes

Pass.

### 5. Write tools (fail-closed probe)

Catalog entry with `safety: write`, no `NENE_MCP_BEARER_TOKEN`:

→ JSON-RPC `-32603`: `Write tool "writeProbe" requires bearer authentication…`

Pass (write surface deferred to FT9–FT10).

### 6. JSON-RPC / protocol

| Probe | Result |
| --- | --- |
| Malformed stdin (`not-json`) | `-32700` Syntax error; process exit 0 |
| ~512 KB line | `-32700` (invalid JSON at scale); no stack trace |
| Invalid catalog (`source.type: builtin` in JSON) | `-32603` safe catalog error |
| Unknown method | `-32601` |

Pass. No crash or stderr stack traces.

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Read tool baseline | 200 + JSON | Pass | Pass |
| SSRF via absolute path in catalog | No third-party fetch | Malformed URL / same host | Pass |
| Redirect to internal port | Must not follow | **Fail before fix**; pass after `follow_location=0` | Fixed |
| Bearer in about/errors | No leak | Pass | Pass |
| Write without Bearer | Fail closed | Pass | Pass |
| Malformed JSON-RPC | Safe error | Pass | Pass |

## Friction Summary

| ID | Location | Severity | Kind | Decision |
| --- | --- | --- | --- | --- |
| F-1 | Catalog path validation | low | design-trade-off | defer |
| F-2 | HTTP redirect following | medium | security-gap | fix-in-package → **v0.1.2** |

## Recommendations

### Immediate (documentation)

1. **F-1**: Note in security policy that catalog paths should be OpenAPI-relative (`/…`); optional schema validation in a later FT.

### Suggested (package change)

1. **F-2**: ✅ Disable redirect following in `NativeMcpHttpClient` (shipped in v0.1.2).

### Trade-offs

None.

## Security Review (required when N % 3 == 0)

### SSRF and URL control

- [x] Catalog paths cannot target hosts outside `NENE_MCP_API_BASE_URL` via simple concatenation
- [ ] Redirect following does not escape intended host — **failed pre-fix; fixed in v0.1.2**
- **Result**: conditional pass after patch

### Secret handling

- [x] Bearer not in catalog, repo, or `nene_mcp_about`
- [x] stderr / JSON-RPC errors do not leak tokens
- **Result**: pass

### Write tools

- [x] `safety: write` tools require explicit Bearer when expected
- [x] Misconfigured env fails closed
- **Result**: pass (single probe; deep review FT9)

### JSON-RPC / protocol

- [x] Malformed stdin does not crash loop or dump stack traces
- [x] Oversized payloads handled safely (syntax error, no crash)
- **Result**: pass

**Security summary**: **conditional pass** — 1 issue fixed in-package (redirect following). No public security advisory required (local-dev SSRF chain; fix shipped).

## Follow-up Issues

| Priority | Issue | Decision |
| --- | --- | --- |
| medium | #19 (redirect fix PR) | fix-in-package |

F-1 deferred → `docs/field-trials/follow-ups.md`

## Overall Impression

Read-only MCP surface is sober: secrets stay out of wire output, write tools fail closed, JSON-RPC errors are safe. The meaningful gap was **HTTP redirect following**—a compromised or misconfigured local API could pivot MCP to other localhost services (e.g. phpMyAdmin on `:8081`). Disabling redirects is the right default for a fixed-base-url bridge.

## Next FT gate

- [ ] Merge v0.1.2 + FT3 report before FT4
