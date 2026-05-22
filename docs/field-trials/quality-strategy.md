# Quality Strategy

Field trials are one **quality instrument**. The **goal is better product quality and assurance**—not completing FT numbers, batch logs, or green automation counters.

## Primary goal

Integrators and AI agents can add `composer require hideyukimori/nene-mcp`, configure MCP, and trust read/write HTTP proxy behavior **without reading source**.

Quality means:

- Correct MCP wire behavior under misconfiguration
- Safe defaults (fail-closed write, no redirect SSRF, no secret leaks)
- Honest documentation matching observed behavior
- Regressions caught by automated tests and CI—not only manual FT

## Instruments (use all that apply)

| Instrument | When | Output |
| --- | --- | --- |
| **Field trial (individual report)** | New surface, host scenario, security cadence (`N % 3 == 0`) | `docs/field-trials/YYYY-MM-field-trial-{N}.md` |
| **GitHub Issue** | Actionable friction (`F-N`) | fix-in-package / document / fix-in-host |
| **PR + code fix** | feature-gap, security-gap | Package or host repo |
| **PHPUnit** | Behavior that must not regress | `tests/` |
| **`tools/ft-runner.sh`** | Repeatable smoke after FT proves a path | CI or local |
| **ADR** | Durable trade-off | `docs/adr/` |
| **Release tag** | Security or contract fix | SemVer patch/minor |
| **NeNe / host PR** | Bootstrap gaps outside nene-mcp | Cross-repo link in FT report |

**Automation regression (`ft-cycle.sh`) supplements FT—it does not replace individual reports or Issue closure.**

## Field trial rules (strict)

1. **One FT → one report file** using `docs/templates/field-trial-report.md`.
2. **FT{N+1} starts only when every Issue opened for FT{N} is closed** with a merged fix, verified resolution, or an explicit defer row in [`follow-ups.md`](follow-ups.md) (deferral is exceptional—not the default).
3. **nene-mcp repo:** zero open Issues tied to the FT before the next FT starts.
4. **Cross-repo (NeNe / host):** fix-in-host Issues must be **closed in the host repository** (merged PR or verified won't-fix) before the next FT—not merely filed.
5. **Batch milestone docs** aggregate metrics only—they never mark an FT “done” without its own report.
6. **Finding friction is success**; zero findings on a complex FT is a signal to increase adversarial scope.

## Persona FT difficulty ramp (FT201+)

Docs-only persona trials start simple and **increase scope until the persona stalls** on a realistic integrator task—not until automation passes.

| Tier | Example FT | Business / auth scope | Expected friction |
| --- | --- | --- | --- |
| **L1** | FT201 | Health + one fake read (404) | Install pin, bootstrap links, catalog examples |
| **L2** | FT202–203 | Write fail-closed, locale/host setup | Security JSON-RPC edges, i18n doc lag |
| **L3** | FT204 | Multi-tool TODO module: login, list, create, path params, URI_ROOT | Session cookie vs Bearer, path conventions, base URL |
| **L4+** | FT205+ | Cross-locale parity, Bearer-native hosts, CSRF write chains, partial catalogs | Host-specific auth, operator mistakes |

**Rules:**

- Do **not** report “zero friction” when only L1 checks ran—say what was *not* exercised yet.
- When an FT completes with fewer than two actionable findings, **raise tier** (more tools, auth, deployment) before the next persona FT.
- Shallow pass (health-only) does not satisfy “business app integrated”—escalate catalog and verification table accordingly.

## What “FT complete” means

An FT is complete when:

- [ ] Report merged on `main`
- [ ] Friction table filled; security section when `N % 3 == 0`
- [ ] Actionable Issues filed and **closed** (fix merged, Packagist verified, or explicit defer in `follow-ups.md`)
- [ ] Package/host fixes merged where decided
- [ ] Tests added when behavior must not regress

## Relation to schedule FT5–100

[`schedule-ft5-100.md`](schedule-ft5-100.md) lists **planned topics**. Completing a topic requires the checklist above—not merely passing `ft-cycle.sh`.

The 2026-05 FT19–FT100 batch log was an **automation regression run**, retroactively labeled; **individual reports resume at FT9**.

FT10–FT200 individual reports: [`index-ft10-200.md`](index-ft10-200.md), schedule [`schedule-ft100-200.md`](schedule-ft100-200.md).

## Related

- [`README.md`](README.md) — methodology
- [`automation.md`](automation.md) — harness
- [`../adr/0001-adopt-field-trial-methodology.md`](../adr/0001-adopt-field-trial-methodology.md)
- [`../development/security-policy.md`](../development/security-policy.md)
