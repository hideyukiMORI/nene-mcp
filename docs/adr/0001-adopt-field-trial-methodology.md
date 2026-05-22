# ADR 0001: Adopt Field Trial Methodology

## Status

Accepted

## Context

nene-mcp is a small Composer MCP bridge. Its value depends on what a fresh integrator (human or AI agent) experiences when adding `composer require hideyukimori/nene-mcp`, wiring `tools.json`, configuring a MCP host, and calling local HTTP APIs through stdio MCP.

Internal unit tests cannot observe:

- Cursor / Claude Desktop MCP client configuration friction
- Absolute-path env requirements
- Catalog ↔ OpenAPI alignment mistakes
- Bearer token setup for write tools
- Security mistakes (pointing MCP at production, leaking tokens in `nene_mcp_about`)

Sibling projects **NeNe**, **NENE2**, and **nene2-python** converged on field trials: build a small realistic integration externally, record friction as `F-N`, file Issues, close them before the next trial. NeNe recorded this in [ADR 0002](https://github.com/hideyukiMORI/NeNe/blob/main/docs/adr/0002-adopt-field-trial-methodology.md). nene2-python ran 190+ trials with security review cadence on multiples of 3.

nene-mcp inherits the same **continuous quality practice** at package scale, with an explicit **critical/adversarial** stance: trials exist to improve DX and integrator confidence, not to green-check a happy path.

## Decision

Adopt field trials as documented in `docs/field-trials/README.md`.

Specifically:

- Trials run from external directories under `../nene-mcp-FT/ft{N}-{topic}/` (or documented equivalent).
- Reports live at `docs/field-trials/YYYY-MM-field-trial-{N}.md` using `docs/templates/field-trial-report.md`.
- Friction uses stable `F-N` identifiers and a summary table (severity, kind, decision).
- Actionable findings become focused GitHub Issues; **`fix-in-package`**, **`document`**, and **`fix-in-host`** are explicit.
- **`fix-in-host`** findings get Issues and PRs in the host repository (NeNe, app repo); nene-mcp records links in the FT report.
- Trials apply **critical and adversarial probes** (fresh clone, misconfiguration, error paths, security themes)—see `docs/field-trials/README.md`.
- **FT{N+1} does not start until FT{N} Issues are closed.**
- FT numbers where **`N % 3 == 0`** include MCP security review (see template).
- Reports and durable policy are **English** (`docs/development/language-policy.md`).

This ADR does not change runtime code. It commits the project to run, record, and close field trials.

## Consequences

- Integration and documentation gaps surface from real MCP host usage, not speculation.
- Security-sensitive MCP behavior gets periodic review cadence aligned with nene2-python.
- Post-trial Issue bursts (often 3–7 PRs) are expected; bundle only when findings are independent.
- FT clones under `../nene-mcp-FT/` should be deleted after closure unless kept as samples.
- Host-repo fixes (NeNe docs, sample catalogs) may be filed in those repos—trials can span packages.

## Related

- `docs/field-trials/README.md`
- `docs/templates/field-trial-report.md`
- NeNe ADR 0002 — upstream methodology
- nene2-python `docs/field-trials/INDEX.md` — scale reference
