# Field Trial Schedule

Long-horizon plan for nene-mcp field trials. **Goal:** raise product quality, DX, and integrator confidence—not ship demo apps.

Trials start **simple and happy-path**, then ramp through **breadth**, **auth/write surfaces**, **cross-platform hosts**, and **adversarial / agent-only** scenarios. Each phase assumes prior FT Issues are closed before the next trial starts (strict cadence in [`README.md`](README.md)).

## Principles

| Principle | Meaning |
| --- | --- |
| **Quality over demo** | A trial that finds friction is success; green-checking a rehearsed path is not. |
| **Ramp difficulty** | Do not run FT17-style agent-only trials before FT2 documents a working golden path. |
| **Adversarial on purpose** | Misconfiguration, error paths, and hostile-env probes are scheduled—not accidental. |
| **Security cadence** | Every FT where **`N % 3 == 0`** includes the full security review section in the report. |
| **Cross-repo honesty** | Host bootstrap gaps → Issues/PRs in NeNe or the app repo; nene-mcp records links. |
| **Tag baselines** | Each FT cites `vX.Y.Z` (preferred) or commit hash in the report. |

## Release gates (between trials)

| Gate | When | Action |
| --- | --- | --- |
| **G0** | Before FT1 | ✅ `v0.1.0` tagged |
| **G1** | After FT1 | ✅ Packagist live; `composer require hideyukimori/nene-mcp` |
| **G2** | After FT6 | Evaluate `v0.2.0` need (catalog/env breaking changes) |
| **G3** | After FT12 | Milestone reflection; consider `0.3.0` or stabilize toward `1.0.0` criteria |
| **G4** | After FT18 | Full-series reflection; publish 1.0 readiness checklist or extend schedule |

Packagist follows [`../development/release-policy.md`](../development/release-policy.md): FT1 complete + actionable Issues closed.

---

## Phase 0 — Bootstrap (complete)

| FT | Status | Topic | Focus | Adversarial level |
| --- | --- | --- | --- | --- |
| **FT1** | ✅ Done | NeNe health catalog + stdio MCP | Read-only `getHealthCheck`, fresh clone, pre-Packagist Composer | Low (stdio smoke; host bootstrap friction recorded) |

Report: [2026-05-field-trial-1.md](2026-05-field-trial-1.md)  
Host follow-up: [NeNe PR #310](https://github.com/hideyukiMORI/NeNe/pull/310) (merged).

**Before FT2:** run **G1** (Packagist + `v0.1.1` if doc-only release helps baselines).

---

## Phase A — Golden path (simple)

Validate the documented happy path with standard tooling. Minimal intentional breakage.

| FT | Topic | Host / client | Primary verification | Adversarial level |
| --- | --- | --- | --- | --- |
| **FT2** | ✅ Done | NeNe + Docker + Cursor config | [2026-05-field-trial-2.md](2026-05-field-trial-2.md) |
| **FT3** | ✅ Done | Security review read-only | [2026-05-field-trial-3.md](2026-05-field-trial-3.md) |
| **FT4** | ✅ Done | Catalog-free minimal install | [2026-05-field-trial-4.md](2026-05-field-trial-4.md) |

**Phase outcome:** A new user with Docker + Cursor can integrate without reading source.

---

## Phase B — Breadth (moderate)

More tools, more install paths, first non-NeNe host.

| FT | Topic | Host / client | Primary verification | Adversarial level |
| --- | --- | --- | --- | --- |
| **FT5** | Multi-tool **read** catalog | NeNe OpenAPI (e.g. health + todo list + session read) | Catalog ↔ OpenAPI alignment; 3+ `tools/call` successes | **Low–medium** — wrong `operationId` probe once |
| **FT6** | **Security review** — catalog mistakes | NeNe or FT5 clone | Invalid catalog JSON; duplicate tool names; path outside base URL intent | **Medium** |
| **FT7** | **Vanilla PHP bridge** (Pattern B) | Separate `mcp-bridge/` repo → small PHP API | [`other-platforms.md`](../integration/other-platforms.md) § separate bridge | **Medium** — API repo has no Composer |
| **FT8** | **Packagist-only** install | Fresh NeNe clone | `composer require` with **no** VCS stanza; README path only | **Low** — validates G1 |

**Phase outcome:** Install works from Packagist; non-NeNe and multi-tool catalogs are proven.

---

## Phase C — Auth and write surfaces (harder)

Write tools, Bearer, fail-closed behavior—where MCP bridges usually break.

| FT | Topic | Host / client | Primary verification | Adversarial level |
| --- | --- | --- | --- | --- |
| **FT9** | **Security review** — write + Bearer | NeNe protected REST | `safety: write` without token fails; no silent anonymous write; stderr clean | **High** |
| **FT10** | Bearer **write** end-to-end | NeNe login/session + write tool | 401 without `NENE_MCP_BEARER_TOKEN`; 2xx with env token | **Medium** — token never in catalog/repo |
| **FT11** | **Misconfiguration** adversarial | Any Phase B host | Wrong `NENE_MCP_API_BASE_URL`; relative catalog path; HTTP vs HTTPS; port drift | **High** |
| **FT12** | **Security review milestone** + write adversarial | FT10 stack | Manual attack pass on write surface; redirect following; error JSON leakage | **High** |

**Phase outcome:** Write path is safe by default; misconfiguration fails loudly and cleanly.

**Gate G2:** cut `v0.2.0` if env/catalog semantics changed; else accumulate `v0.1.x` patches.

---

## Phase D — Cross-platform and deploy shapes (harder)

Framework diversity and real-world URL layouts.

| FT | Topic | Host / client | Primary verification | Adversarial level |
| --- | --- | --- | --- | --- |
| **FT13** | **Laravel or Symfony** minimal app | Framework dev server + nene-mcp | [`other-platforms.md`](../integration/other-platforms.md) PHP frameworks path | **Medium** |
| **FT14** | **Non-PHP API** bridge | Node or Python API + PHP `nene-mcp` on MCP host | Other-languages section; two runtimes | **Medium** |
| **FT15** | **Security review** — cross-runtime | FT14 stack | Bridge machine secrets; base URL points at wrong host; CORS irrelevant to MCP but HTTP client behavior | **High** |
| **FT16** | **URI_ROOT / subdirectory** deploy | NeNe or app under subpath | Catalog `path` + `servers.url` alignment per OpenAPI | **High** — easy to get 404 silently |

**Phase outcome:** Integrators on common stacks and subdirectory deploys have recorded playbooks.

---

## Phase E — Agent realism and milestone (hardest)

Simulate how AI agents and skeptical experts actually use the package.

| FT | Topic | Host / client | Primary verification | Adversarial level |
| --- | --- | --- | --- | --- |
| **FT17** | **Agent-only** integration | Fresh clone; **AGENTS.md + public docs only** | No maintainer hints; time-to-working-MCP; record every doc gap | **Very high** |
| **FT18** | **Security review milestone** + series reflection | Best available stack from prior FTs | Full adversarial pass; compare F-1…F-N across FT1–FT17; 1.0 readiness draft | **Very high** |

**Phase outcome:** Documented evidence for `1.0.0` stability claim or a Phase F extension schedule.

**Gate G4:** publish reflection doc (pattern: NeNe / nene2-python post-series reflections).

---

## Optional Phase F — Post-1.0 (if needed)

Schedule only if FT18 does not meet 1.0 criteria.

| FT | Topic | Notes |
| --- | --- | --- |
| FT19+ | Performance / large catalogs | 50+ tools JSON; `tools/list` payload size |
| FT20+ | Claude Desktop / other MCP hosts | Non-Cursor client matrix |
| FT21+ | CI MCP smoke | Reproducible stdio test harness for integrators |

---

## Calendar sketch (not deadlines)

Rough pacing assuming **one FT every 1–2 weeks** with Issue closure in between:

| Month | Trials | Notes |
| --- | --- | --- |
| 2026-05 | FT1 ✅, G1, FT2 | Packagist after G1 |
| 2026-06 | FT3–FT5 | First security review; multi-tool |
| 2026-07 | FT6–FT8 | Vanilla bridge; Packagist-only |
| 2026-08 | FT9–FT12 | Write + misconfig; **G2** |
| 2026-09 | FT13–FT15 | Cross-platform |
| 2026-10 | FT16–FT18 | Subdirectory + agent-only; **G4** |

Adjust when fix-in-package work spans multiple PRs—**never skip the close-before-next-FT rule**.

---

## FT directory naming (planned)

```text
../nene-mcp-FT/
├── ft1-nene-health/          ✅
├── ft2-nene-cursor-docker/
├── ft3-security-readonly/
├── ft4-about-only/
├── ft5-nene-multi-read/
├── ft6-security-catalog/
├── ft7-vanilla-bridge/
├── ft8-packagist-install/
├── ft9-security-write/
├── ft10-nene-bearer-write/
├── ft11-misconfig-adversarial/
├── ft12-security-write-milestone/
├── ft13-laravel-or-symfony/
├── ft14-node-api-bridge/
├── ft15-security-cross-runtime/
├── ft16-uri-root-subdir/
├── ft17-agent-only/
└── ft18-security-milestone/
```

---

## How to use this schedule

1. Pick the **lowest-numbered open FT**; do not skip ahead.
2. Open a GitHub Issue when starting an FT (optional but recommended for tracking).
3. Copy [`../templates/field-trial-report.md`](../templates/field-trial-report.md) into `docs/field-trials/YYYY-MM-field-trial-{N}.md`.
4. Update the [index table](README.md#index) when the report merges.
5. Revise this schedule only via PR when scope changes—note the date and reason in the commit message.

## Related

- Methodology: [`README.md`](README.md)
- ADR: [`../adr/0001-adopt-field-trial-methodology.md`](../adr/0001-adopt-field-trial-methodology.md)
- Release gates: [`../development/release-policy.md`](../development/release-policy.md)
- Current focus: [`../todo/current.md`](../todo/current.md)
