# NeNe #380 confirmation gate (cross-repo)

When [NeNe #380](https://github.com/hideyukiMORI/NeNe/issues/380) / [#395](https://github.com/hideyukiMORI/NeNe/issues/395) is **closed with merged fix** on NeNe `main`, run **FT450** before closing nene-mcp cross-repo tracking.

## Preconditions

- NeNe Docker (or FT sandbox) on `http://127.0.0.1:8080`
- nene-mcp `v0.1.6+` on Packagist
- Catalog: `../nene-mcp-FT/ft204-persona-business-hard/docs/mcp/tools.json`
- Env: `NENE_MCP_BEARER_TOKEN=<NeNe-documented agent token>`

## Confirmation matrix

| Tool | MCP call | Expectation |
| --- | --- | --- |
| getHealthCheck | `{}` | HTTP 200 |
| listTodos | `{}` (no prior login call) | HTTP **200** + todo list |
| getTodoById | `{ "id": "<valid>" }` | HTTP 200 (path `/todo/item/id_{id}`) |
| createTodo | `{ "title": "FT450 confirm" }` | HTTP **2xx** |
| createTodo without Bearer | unset token | nene-mcp JSON-RPC fail-closed **or** HTTP 401 |

## Regression

- Browser session + cookie + CSRF path still works (NeNe repo tests)
- nene-mcp L6 band still green

## Report

- `docs/field-trials/2026-05-field-trial-450.md`
- Update `follow-ups.md` — close NeNe cross-repo defer row
- Optional: nene-mcp doc tweak if OpenAPI/catalog examples change

## Until then

nene-mcp continues **L8** adversarial band (FT451+) and does **not** block on NeNe. Run **`tools/ft-individual.sh 450`** after merge — harness auto-runs full matrix when `listTodos` returns 200.

NeNe assignment: implementation checklist [#395](https://github.com/hideyukiMORI/NeNe/issues/395).
