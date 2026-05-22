# Quality Tools Policy

Quality checks are explicit, fast, and required before merge. Policy inherits [NENE2 quality-tools](https://github.com/hideyukiMORI/NENE2/blob/main/docs/development/quality-tools.md) at library scale.

## Position

- Tools make strict coding standards enforceable—not optional.
- Commands must be documented before they become required in CI.
- Do not add a tool to `composer check` until config is committed and verified locally.

## Current baseline

| Tool | Status | Purpose |
| --- | --- | --- |
| PHPUnit | **Adopted** | Unit tests (`composer test`) |
| PHPStan | **Adopted** | Static analysis level 8 (`composer analyse`) |
| PHP-CS-Fixer | **Planned** | PSR-12 formatting (`@PSR12`, `declare_strict_types`) |

CI today (`.github/workflows/ci.yml`): `composer check` (`@test` + `@analyse`) on PHP 8.2 and 8.4.

## Target composer scripts

Current scripts:

```json
{
  "scripts": {
    "test": "phpunit --configuration phpunit.dist.xml",
    "analyse": "phpstan analyse --configuration=phpstan.neon.dist --memory-limit=256M",
    "check": ["@test", "@analyse"]
  }
}
```

When PHP-CS-Fixer lands, extend `check` with `@cs`.

Until then, **`composer check` is mandatory** before every PR.

## Introduction checklist

Before marking a tool **Adopted**:

1. Open a GitHub Issue.
2. Commit config (`phpstan.neon.dist`, `.php-cs-fixer.php`, etc.).
3. Fix or baseline existing violations in the same PR or a focused predecessor PR.
4. Update this document and `docs/review/release-ci.md`.
5. Add the command to CI and `composer check`.

## PHPStan

- Start at level **6** minimum; aim for **8** on new code.
- Use `@phpstan-type` for catalog and JSON-RPC shapes (see `JsonToolCatalog`, `StdioMcpServer`).
- No `@phpstan-ignore` without Issue justification and inline reason comment.

## PHP-CS-Fixer

- `@PSR12` + `declare_strict_types` (risky fixer—`setRiskyAllowed(true)` and `--allow-risky=yes`).
- Run `composer cs:fix` before commit when the tool is adopted.

## Non-goals

- Phan, Rector, or Psalm unless an Issue compares them to PHPStan for this repo size.
- Requiring tools that are not yet configured.
- Network-dependent tests in default `composer test`.

## Sibling reference

nene2-python equivalent gate:

```bash
uv run pytest && uv run mypy src/ && uv run ruff check src/ tests/ && uv run ruff format --check src/ tests/
```

nene-mcp equivalent target:

```bash
composer check
```
