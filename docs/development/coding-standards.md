# Coding Standards

nene-mcp is a small, strict PHP library. These rules inherit the spirit of [NENE2](https://github.com/hideyukiMORI/NENE2) and [nene2-python](https://github.com/hideyukiMORI/nene2-python): explicit boundaries, typed surfaces, tests before merge, and AI-readable structure.

## PHP baseline

- Target PHP `^8.2` (library minimum). Develop and CI-verify on 8.2 and 8.4.
- Every PHP file must start with `declare(strict_types=1);`.
- Follow PSR-12 unless a narrower project rule overrides it.
- Use native types, `readonly` classes/properties, and small DTO-like arrays only at JSON boundaries—not as a substitute for typed objects inside the library.
- Prefer `final` classes when extension is not an intentional extension point.
- No file-level copyright banners.
- Public docs, error messages exposed to MCP clients, and catalog-facing text are **English**. See `docs/development/language-policy.md`.

## Package architecture

nene-mcp is not a framework. Keep layers narrow:

```text
bin/nene-mcp              → bootstrap only
src/Bootstrap/            → env wiring, stdio loop
src/StdioMcpServer.php    → JSON-RPC surface (initialize / tools/list / tools/call)
src/Catalog/              → tool definitions (builtin + JSON catalog)
src/Http/                 → HTTP proxy to documented REST APIs
src/Exception/            → library-specific failures
```

Rules:

- **Stdio MCP loop** owns protocol parsing and response encoding only.
- **Catalog** owns tool metadata and validation of catalog shape—not HTTP transport.
- **HTTP client** owns outbound requests to `NENE_MCP_API_BASE_URL`; depend on `McpHttpClientInterface` in tests.
- Do not import NeNe, NENE2, or host-application code into this package.
- Do not add host-framework magic (container service location, autowiring, hidden globals).
- Keep `getenv()` access inside `McpEnvironment` (config boundary).
- Never put secrets, bearer tokens, or raw `.env` contents into `runtimeContext`, logs, or MCP tool results.

## MCP wire policy

- Wire format: newline-delimited JSON-RPC 2.0.
- Supported methods: `initialize`, `tools/list`, `tools/call` (NENE2 local MCP compatible).
- Notifications (messages without `id`) receive no stdout response.
- Unknown methods return JSON-RPC `-32601`.
- Protocol or catalog failures return JSON-RPC `-32603` with a safe message—no stack traces, paths, or tokens.
- Built-in `nene_mcp_about` is **read-only** metadata.
- Catalog HTTP tools must map to **documented** REST endpoints described in committed `tools.json` / OpenAPI-aligned entries.
- Do not add tools that read arbitrary filesystem paths, shell out, or bypass the HTTP catalog without an Issue and security review.

## HTTP proxy policy

- Base URL comes from environment only.
- Respect catalog `method`, `path`, and declared `safety`.
- Bearer auth uses `NENE_MCP_BEARER_TOKEN` from environment—not from catalog JSON or source code.
- Do not follow redirects to unexpected hosts without an explicit design Issue.
- Treat local development URLs as the default; documenting production MCP targeting requires explicit security review.

## Error handling

- Use `McpRuntimeException` (or narrower library exceptions) for expected failures callers can surface safely.
- Do not swallow exceptions silently.
- Do not leak SQL, stack traces, filesystem paths, env values, or tokens in MCP responses or stderr in normal operation.

## Testing

Testing is part of design—not an afterthought.

- Unit-test protocol handling, catalog merge logic, and HTTP client behavior with fakes (`RecordingHttpClient`, fixtures).
- Add regression tests for every bug fix.
- Keep tests deterministic; no network in unit tests unless explicitly marked integration and gated.
- Prefer small fixtures (`tests/fixtures/`) over inline giant JSON blobs.
- Run `composer test` before every PR; run full `composer check` when quality tools are configured.

## Documentation comments

- PHPDoc public classes, interfaces, and non-obvious array shapes (`@phpstan-type`, `@param array<string, mixed>` when needed).
- Do not restate native types in PHPDoc.
- Record architectural decisions in `docs/development/adr.md` when wire protocol, env vars, or catalog schema change incompatibly.

## AI readability

Inherited from NENE2 / nene2-python:

- Name files and classes after their role (`JsonToolCatalog`, not `Helper`).
- Keep functions short enough to inspect in one screen; split when logic branches multiply.
- Prefer explicit `match` / early returns over deep nesting.
- Use self-review checklists before push or PR. See `docs/development/self-review.md`.

## Size guidance

This library should stay small. Soft limits (split when exceeded without good reason):

| Unit | Guideline |
| --- | --- |
| One method | ~40 lines |
| One class | ~250 lines |
| One file | ~300 lines |

## Sibling references

| Repo | Reuse |
| --- | --- |
| NENE2 `docs/development/coding-standards.md` | Strict typing, thin boundaries, English public surface |
| nene2-python `CLAUDE.md` | Issue-driven flow, pre-PR checks, security bans |
| NeNe `docs/development/coding-standards.md` | Reviewable small-service mindset |

Do not copy full-framework rules (PSR-7 stack, use-case layers, Phinx) into this package—they do not apply here.
