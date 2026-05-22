# Integrate with NeNe

nene-mcp has **no NeNe-specific code**. NeNe is one host that ships OpenAPI + `docs/mcp/tools.json`.

## Bootstrap NeNe first

The nene-mcp docs assume a **running NeNe HTTP app**. If you do not have one yet:

1. Clone NeNe: [github.com/hideyukiMORI/NeNe](https://github.com/hideyukiMORI/NeNe)
2. `composer install` in the project root
3. Start the app — Docker (`compose.yaml`) or your host PHP stack; see NeNe `docs/development/docker.md`
4. Confirm HTTP works (e.g. `GET /health/index` on your base URL)

Then add nene-mcp to the **same project** (or a bridge repo with access to the same `vendor/`):

```bash
composer require hideyukimori/nene-mcp:^0.1
```

## Prerequisites

- NeNe app running locally (Docker or host PHP)
- PHP **ext-intl** on the NeNe host when using NeNe Docker images
- Absolute paths in MCP host config ([Cursor setup](/tutorial/cursor-setup))

## Steps

1. **Expose REST endpoints** with OpenAPI documentation (NeNe convention).
2. **Commit** `docs/mcp/tools.json` — NENE2-compatible format ([catalog reference](/reference/catalog-format)). Start from [NeNe health catalog example](/howto/health-catalog-example).
3. **Configure MCP host** with absolute paths to `vendor/bin/nene-mcp` and `tools.json`.
4. **Smoke** read tools ([catalog smoke test](/howto/catalog-smoke-test)) before enabling write tools.
5. For NeNe TODO / session routes, read [NeNe catalog patterns](/howto/neene-catalog-patterns) (path params, `URI_ROOT`, session vs Bearer).

::: warning Absolute catalog path
Use an **absolute** path for `NENE_MCP_TOOLS_JSON`. Relative paths depend on the MCP process working directory — Cursor may start with a cwd where `docs/mcp/tools.json` does not resolve.
:::

::: info NeNe session cookie limitation
The stock NeNe sample secures `/todo/*` with **session cookies**. nene-mcp is a **stateless Bearer proxy** — it does not keep cookies between MCP calls. Health and other public reads work; multi-step login → list → create on the sample TODO module **does not** work end-to-end without host auth changes. Details: [NeNe catalog patterns](/howto/neene-catalog-patterns).
:::

## Base URL (`NENE_MCP_API_BASE_URL`)

Must match where NeNe actually serves HTTP (including `URI_ROOT` or reverse-proxy prefix). Example: app at `http://localhost:8080/mybiz/…` → set `NENE_MCP_API_BASE_URL=http://localhost:8080/mybiz` and keep catalog paths like `/health/index`. Wrong prefix → HTTP 404. See [NeNe catalog patterns](/howto/neene-catalog-patterns).

## Environment aliases

| nene-mcp | NENE2 alias |
| --- | --- |
| `NENE_MCP_API_BASE_URL` | `NENE2_LOCAL_API_BASE_URL` |
| `NENE_MCP_TOOLS_JSON` | `NENE2_LOCAL_TOOLS_JSON` |

## Bootstrap gaps

If NeNe Docker or extension prerequisites block integration, file Issues in the **NeNe** repository — nene-mcp documents the bridge only.

## Related

- [Other platforms](/howto/other-platforms)
- [Ecosystem map](/integrations/ecosystem)
- [NeNe catalog patterns](/howto/neene-catalog-patterns)
