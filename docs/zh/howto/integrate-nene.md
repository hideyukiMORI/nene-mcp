# Integrate with NeNe

nene-mcp has **no NeNe-specific code**. NeNe is one host that ships OpenAPI + `docs/mcp/tools.json`.

## Prerequisites

- NeNe app running locally (Docker or host PHP)
- PHP **ext-intl** on the NeNe host when using NeNe Docker images
- `composer require hideyukimori/nene-mcp` in your NeNe project (or a bridge repo)

## Steps

1. **Expose REST endpoints** with OpenAPI documentation (NeNe convention).
2. **Commit** `docs/mcp/tools.json` — NENE2-compatible format ([catalog reference](/reference/catalog-format)).
3. **Configure MCP host** with absolute paths ([Cursor setup](/tutorial/cursor-setup)).
4. **Smoke** read tools before enabling write tools.

## Environment aliases

For quick alignment with NENE2 docs:

| nene-mcp | NENE2 alias |
| --- | --- |
| `NENE_MCP_API_BASE_URL` | `NENE2_LOCAL_API_BASE_URL` |
| `NENE_MCP_TOOLS_JSON` | `NENE2_LOCAL_TOOLS_JSON` |

## Health catalog example

See the repository file `docs/example-ne-health-catalog.md` for a minimal NeNe health `tools.json` sample.

## Bootstrap gaps

If NeNe Docker or extension prerequisites block integration, file Issues in the **NeNe** repository — nene-mcp documents the bridge only.

## Related

- [Other platforms](/howto/other-platforms)
- [Ecosystem map](/integrations/ecosystem)
