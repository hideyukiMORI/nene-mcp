# Architecture Decision Records (ADR)

Lightweight ADR policy inherited from NENE2 `docs/development/adr.md`.

## When to write an ADR

Create `docs/adr/NNNN-short-title.md` when a decision:

- Changes MCP wire protocol or JSON-RPC method behavior
- Changes environment variable names or compatibility aliases
- Changes `tools.json` / catalog schema incompatibly
- Adds a new outbound capability (filesystem, shell, non-HTTP tools)
- Adopts a new required quality tool or CI gate
- Chooses a dependency that affects security posture

Skip ADRs for:

- Bug fixes that restore documented behavior
- README or typo fixes
- Adding tests for existing behavior
- Patch dependency bumps with no behavior change

## Format

```markdown
# NNNN. Title

Date: YYYY-MM-DD
Status: accepted | superseded

## Context

## Decision

## Consequences
```

Number sequentially from `0001`. Index in `docs/adr/README.md`.

## Process

1. Open GitHub Issue.
2. Draft ADR on the feature branch **before** or **with** the implementation PR.
3. Link ADR from Issue/PR.
4. If superseded, mark old ADR `superseded` and point to the replacement—do not delete history.

## Non-goals

- ADRs for every small refactor
- Duplicating full text from `docs/development/coding-standards.md`
