# Commit conventions

This project uses **Conventional Commits**, aligned with NeNe and NENE2.

**All commit messages, Issues, and PRs must be written in English** (`docs/development/language-policy.md`).

Before committing, complete the relevant self-review checklist (`docs/development/self-review.md`).

## Format

```text
<type>(<scope>): <summary> (#<issue>)

<body>
```

Rules:

- Use English for `type`, optional `scope`, summary, and body.
- One coherent change set per PR.
- Reference the GitHub Issue in the summary or body (`#123` or `Closes #123` in PR description when fully resolved).
- Common types: `feat`, `fix`, `docs`, `build`, `ci`, `test`, `chore`.

Examples:

```text
docs: add NeNe integration guide (#12)

fix(http): normalize trailing slash on base URL (#34)
```

## Breaking changes

Use message footers (`BREAKING CHANGE:` or `feat!`) when binaries, CLI, environment variables, JSON catalog schema, or wire protocol behavior changes incompatibly for consumers.
