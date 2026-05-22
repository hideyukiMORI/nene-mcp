# Field Trials

A **Field Trial (FT)** is a small, time-boxed exercise where nene-mcp is integrated from a fresh setup—typically a NeNe app, another PHP stack, or a minimal MCP bridge repo—and used with a real MCP host (Cursor, Claude Desktop, etc.). Every point of confusion or friction is recorded with a stable identifier (`F-1`, `F-2`, …) and converted into GitHub Issues that drive package and documentation changes.

The goal is **not** to ship the trial application. The goal is to learn what nene-mcp assumes but does not document, how NENE2-compatible catalogs feel in practice, and where MCP stdio + HTTP proxy behavior surprises integrators or AI agents.

This methodology is inherited from [NeNe ADR 0002](https://github.com/hideyukiMORI/NeNe/blob/main/docs/adr/0002-adopt-field-trial-methodology.md), [NENE2 field trials](https://github.com/hideyukiMORI/NENE2/tree/main/docs/field-trials), and [nene2-python field trials](https://github.com/hideyukiMORI/nene2-python/tree/main/docs/field-trials)—adapted for a **Composer MCP bridge**, not a full application framework.

## When to Run a Field Trial

Run a new FT when one or more of the following is true:

- A release or integration doc rewrite should be verified end to end.
- MCP wire behavior, env vars, or catalog schema changed incompatibly.
- A new host scenario (NeNe, Laravel, vanilla PHP, non-PHP API bridge) needs first-time validation.
- Security-sensitive MCP features (write tools, Bearer, new HTTP surfaces) ship.
- Roadmap or milestone explicitly schedules a trial.

One focused trial beats a long speculative improvement list.

## Trial Layout

Field trials use **external clone directories** next to this repository—not commits inside `nene-mcp` itself.

```text
~/github/   (or your workspace root)
├── nene-mcp/                  # this repository (the package)
└── nene-mcp-FT/
    ├── ft1-neNe-health/       # FT1 working tree
    ├── ft2-vanilla-bridge/    # FT2 working tree
    └── ...
```

Typical FT1 bootstrap (NeNe + MCP):

```bash
mkdir -p ../nene-mcp-FT
git clone git@github.com:hideyukiMORI/NeNe.git ../nene-mcp-FT/ft1-neNe-health
cd ../nene-mcp-FT/ft1-neNe-health
composer require hideyukimori/nene-mcp
# add docs/mcp/tools.json, configure MCP host env, run docker compose up
```

For non-NeNe trials, the FT directory may be a minimal Composer bridge repo or an existing API project—document the baseline in the report.

**Rule:** trial `.env`, MCP host tokens, and local MCP client config stay in the FT directory. Only the **report** and framework/package fixes return to `hideyukiMORI/nene-mcp` (or the host repo) via normal Issues and PRs.

## Naming and Numbering

- Reports live in `docs/field-trials/` as `YYYY-MM-field-trial-{N}.md`. `{N}` increases monotonically across all trials (no resets).
- FT directories are named `ft{N}-{topic}` (lowercase, hyphenated). `N` matches the report number.
- One trial → one report file. Follow-up work is tracked through Issues, not by rewriting the report after merge.

## What to Record

Reports must be readable cold by someone who was not present. Use `docs/templates/field-trial-report.md`.

Required themes for nene-mcp trials:

- **Baseline** — nene-mcp version (tag/commit), PHP version, host app (NeNe / other), MCP client, env var names used.
- **Goal** — one or two sentences (e.g. "verify health catalog + Cursor stdio from NeNe clone").
- **Steps Taken** — actual flow with inline `Finding (F-N)` at friction points.
- **MCP verification** — `tools/list`, representative `tools/call`, HTTP response shape, error paths.
- **Friction Summary** — table with severity, kind, decision.
- **Recommendations** — immediate (docs), suggested (package), trade-offs (ADR).
- **Follow-up Issues** — filed Issue numbers.

### Friction kinds

| Kind | Meaning |
| --- | --- |
| `docs-gap` | Behavior is correct but undocumented or hard to find. |
| `feature-gap` | A small extension would noticeably reduce integration cost. |
| `design-trade-off` | Intentional cost worth documenting; change needs discussion. |
| `process-gap` | Workflow, checklist, or tooling is missing. |
| `security-gap` | Unsafe default, leak, or missing guard—file urgently. |

nene-mcp has no `legacy-preserved` kind (this package is new). Host frameworks (NeNe) may use that in their own trials.

### Decisions

| Decision | Meaning |
| --- | --- |
| `fix-in-package` | Change nene-mcp code, CLI, or defaults. |
| `document` | Documentation only. |
| `fix-in-host` | Change belongs in NeNe / app repo, not nene-mcp. |
| `defer` | Real friction, not worth acting on yet. |

## Security Reviews (inherited cadence)

Following nene2-python practice:

- **Every FT where `N % 3 == 0`** includes an MCP-focused **security review** section in the report (see template).
- Themes: SSRF via catalog/base URL, token leakage in `nene_mcp_about` or logs, write-tool abuse, path traversal in catalog paths, production URL misuse, JSON-RPC error leakage.
- File `security`-labeled Issues for exploitable findings; do not detail exploits in public Issues before fix.

Optional **adversarial pass** (manual attack attempts, not just checklists) on milestone FTs—record in the report when performed.

## Cadence (strict)

Inherited from NENE2 / NeNe:

1. **Do not start FT{N+1} until all actionable Issues from FT{N} are closed** (merged or closed with recorded rationale).
2. Open **one Issue per actionable finding**; reference report + `F-N`.
3. Append `defer` rows to `docs/field-trials/follow-ups.md`.
4. Update `docs/todo/current.md` with a short FT block linking Issues.
5. Delete the FT clone when done unless it serves as a public sample.

A trial **succeeds by recording friction**, not by finishing the demo app.

## What Not to Record

Public repo rules—never include:

- Secrets, Bearer tokens, session cookies, or raw `.env` contents.
- Production hostnames or customer data.
- Private prompt text from collaboration tools.

See `docs/development/security-policy.md` and `SECURITY.md`.

## Templates and Policies

- Report skeleton: `docs/templates/field-trial-report.md`
- Self-review before publishing report: `docs/review/field-trial-report.md`
- Workflow: `docs/workflow.md`
- ADR: `docs/adr/0001-adopt-field-trial-methodology.md`

## Sibling references

| Repo | FT docs |
| --- | --- |
| NeNe | `docs/field-trials/README.md` |
| NENE2 | `docs/field-trials/` (reports + milestones) |
| nene2-python | `docs/field-trials/INDEX.md`, `docs/templates/field-trial-report.md` |

## Index

| Trial | Date | Topic | Report |
| --- | --- | --- | --- |
| — | — | *(none yet)* | — |

Update this table when the first trial completes.
