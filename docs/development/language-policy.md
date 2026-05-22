# Language Policy

nene-mcp targets an **international audience**. Public project language is **English only**, stricter than NENE2's bilingual local-note allowance.

## Position

- Easy to publish, index, and contribute to from outside Japan.
- Aligns with MCP hosts, OpenAPI, and English-first sibling docs (NeNe public docs, NENE2 API contracts).
- Prevents accidental Japanese drift in README, Issues, or PR templates.

## English required

Use English for:

- `README.md`, `CHANGELOG.md`, `SECURITY.md`, `AGENTS.md`
- All of `docs/` (including `docs/todo/current.md` summaries meant for handoff)
- GitHub Issue titles and bodies
- Pull request titles and descriptions
- Commit messages (see `docs/development/commit-conventions.md`)
- Code identifiers, docblocks meant for API consumers, and MCP error strings
- GitHub Issue/PR templates under `.github/`
- Cursor rule **descriptions** and durable rule bodies in `.cursor/rules/`

## Japanese and mixed language

Japanese is **not** used for durable policy in this repository.

- Do not add Japanese-only policy to `.cursor/rules/` without an English source-of-truth doc in `docs/`.
- Chat, video calls, and maintainer-private notes outside the repo may use any language.
- Historical discussion does not need retroactive translation.

If a contributor opens a Japanese Issue, respond in English and ask for an English title/body when converting to actionable work.

## Source of truth

Policy lives in English under `docs/`.  
`.cursor/rules/` may summarize but must not be the only copy of a rule.

When `.cursor/rules/` and `docs/` conflict, **update `docs/` first**, then sync Cursor rules.

## Non-goals

- Translating sibling repos (NeNe, NENE2, nene2-python) into this policy.
- Blocking Japanese in maintainer chat.
- Localized user-facing UI (this package has no end-user UI).
