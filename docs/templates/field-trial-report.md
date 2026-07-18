# Field Trial {N} — {topic}

Copy to the private mirror `nene-origin/internal-docs/mcp/field-trials/YYYY-MM-field-trial-{N}.md`. Keep it factual. Full direction: private `nene-origin/internal-docs/mcp/field-trials/README.md`.

Before committing, confirm no secrets, Bearer tokens, raw `.env`, production URLs, or private prompts.

## Date

YYYY-MM-DD

## Baseline

- nene-mcp ref: {tag or commit}
- FT clone path: `../nene-mcp-FT/ft{N}-{topic}/`
- Host app: {NeNe / Laravel / vanilla bridge / Node API + bridge}
- PHP: {version for `nene-mcp` process}
- MCP client: {Cursor / Claude Desktop / other}
- Env: `NENE_MCP_API_BASE_URL`, `NENE_MCP_TOOLS_JSON` paths (redact secrets)

## Goal

One or two sentences. Example: verify NeNe health catalog end to end from `composer require` through Cursor `tools/call`.

## Integration Built

- Catalog: {path to `tools.json`, tool count}
- HTTP surface exercised: {e.g. GET /health/index}
- MCP methods verified: initialize / tools/list / tools/call

## Steps Taken

Embed `**Finding (F-N)**` inline at friction points.

### 1. {step title}

{what happened}

**Finding (F-1)**: {friction description}

### 2. {next step}

...

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| MCP server starts | stdio process healthy | | Pass / Fail |
| `tools/list` | `nene_mcp_about` + catalog tools | | |
| `tools/call` (read) | HTTP 2xx + JSON body | | |
| `tools/call` (error path) | Safe JSON-RPC error, no leak | | |
| Write tool + Bearer | 401 without token; success with env token | | N/A |

## Friction Summary

| ID | Location | Severity | Kind | Decision |
| --- | --- | --- | --- | --- |
| F-1 | {doc / env / catalog / code} | high / medium / low | docs-gap / feature-gap / design-trade-off / process-gap / security-gap | fix-in-package / document / fix-in-host / defer |

Severity:

- **high** — new integrator likely stalls without reading source or asking maintainer
- **medium** — recoverable with trial and error
- **low** — papercut

## Recommendations

### Immediate (documentation)

1. **F-N — title**: {change}

### Suggested (package change)

1. **F-N — title**: {smallest reasonable scope}

### Trade-offs (ADR or cross-repo)

1. **F-N — title**: {trade-off; no side picked here}

Write "None." for empty sections.

## Security Review (required when N % 3 == 0)

Skip this section when `N % 3 != 0`. Write "N/A — security review scheduled for FT{next multiple of 3}."

When required, cover MCP-specific threats:

### SSRF and URL control

- [ ] Catalog paths cannot target hosts outside `NENE_MCP_API_BASE_URL`
- [ ] Redirect following does not escape intended host
- **Result**:

### Secret handling

- [ ] Bearer not in catalog, repo, or `nene_mcp_about`
- [ ] stderr / JSON-RPC errors do not leak tokens or env
- **Result**:

### Write tools

- [ ] `safety: write` tools require explicit Bearer when expected
- [ ] Misconfigured env fails closed (no silent anonymous write)
- **Result**:

### JSON-RPC / protocol

- [ ] Malformed stdin does not crash loop or dump stack traces
- [ ] Oversized payloads handled safely
- **Result**:

**Security summary**: pass / conditional / fail — {N issues filed: #…}

## Follow-up Issues

| Priority | Issue | Decision |
| --- | --- | --- |
| high | # | fix-in-package / document / fix-in-host |
| medium | | |
| low | | |

## Overall Impression

Short paragraph for future readers—not marketing.

## Next FT gate

- [ ] All actionable Issues from this FT closed before starting FT{N+1}
