# MCP Server Self-Review

Use for changes to `src/`, `bin/nene-mcp`, catalog fixtures, or MCP-facing behavior.

Source policies:

- `docs/development/coding-standards.md`
- `docs/development/security-policy.md`
- `SECURITY.md`
- `docs/workflow.md`

## Checklist

- [ ] GitHub Issue exists and branch name follows `type/issue-number-summary`.
- [ ] Change scope is limited to MCP bridge behavior (no unrelated cleanup).
- [ ] `declare(strict_types=1);` preserved on touched PHP files.
- [ ] Secrets, tokens, and local absolute paths are not committed.
- [ ] `getenv()` / env access stays in `McpEnvironment` (or documented config boundary).
- [ ] MCP responses do not leak stack traces, paths, env values, or Authorization headers.
- [ ] JSON-RPC errors use safe messages; unknown methods return `-32601`.
- [ ] Catalog changes align with NENE2-compatible `tools.json` shape.
- [ ] HTTP calls stay within configured base URL + catalog paths.
- [ ] Bearer auth reads env only—not catalog JSON or hardcoded strings.
- [ ] `nene_mcp_about` remains read-only and secret-free.
- [ ] Unit tests added or updated for behavior changes.
- [ ] `composer test` passes locally.
- [ ] Docs updated when env vars, wire behavior, or catalog contract changed.
- [ ] ADR considered if protocol, env names, or catalog schema changed incompatibly.

## Verification

```bash
composer test
```

When `composer check` exists, run it instead of test alone.
