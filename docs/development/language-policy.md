# Language Policy

nene-mcp targets an **international audience**. Public surfaces use **English as the primary source language**, with **translated user documentation** on the VitePress site (same six locales as NENE2 and nene2-js).

## Documentation site (VitePress)

Published at [hideyukimori.github.io/nene-mcp](https://hideyukimori.github.io/nene-mcp/).

| Locale | Path | Role |
| --- | --- | --- |
| English | `/` | Source-of-truth integrator docs |
| 日本語 | `/ja/` | Full integrator translation |
| Français | `/fr/` | Integrator translation |
| 中文 | `/zh/` | Integrator translation |
| Português (Brasil) | `/pt-br/` | Integrator translation |
| Deutsch | `/de/` | Integrator translation |

Build locally:

```bash
npm ci
npm run docs:dev    # http://localhost:5176
npm run docs:build
```

Contributor-only paths (`docs/development/`, raw field-trial reports, ADRs) stay **English only** and are excluded from the public site build.

## English required (repository governance)

Use English for:

- Root `README.md`, `CHANGELOG.md`, `SECURITY.md`, `AGENTS.md`
- GitHub Issue titles and bodies
- Pull request titles and descriptions
- Commit messages (see `docs/development/commit-conventions.md`)
- Code identifiers, consumer-facing docblocks, MCP error strings
- GitHub Issue/PR templates under `.github/`
- Cursor rule **descriptions** and durable rule bodies in `.cursor/rules/`
- Contributor docs: `docs/development/`, `docs/field-trials/` reports, ADRs

## Translations

- Integrator-facing VitePress pages (`docs/tutorial/`, `docs/howto/`, etc.) may be translated per locale directories (`docs/ja/`, …).
- When English integrator docs change, update translations in the same PR when practical, or file a follow-up Issue.
- Do not translate MCP wire error strings or code identifiers for localization alone.

## Japanese and mixed language

Japanese is welcome in **translated docs** and maintainer chat. Do not add Japanese-only **policy** to `.cursor/rules/` without an English source-of-truth in `docs/`.

## Source of truth

- **Integrator UX:** English pages under `docs/` (VitePress root locale)
- **Governance / FT / ADR:** English files excluded from or linked from the site
- `.cursor/rules/` summarizes but must not be the only copy of a rule

When `.cursor/rules/` and `docs/` conflict, **update `docs/` first**, then sync Cursor rules.

## Non-goals

- Translating every historical field-trial report
- Localized MCP runtime error strings
- Blocking Japanese in maintainer chat
