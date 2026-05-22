# Integrar com NeNe

nene-mcp **não tem código NeNe**. NeNe é um host com OpenAPI + `docs/mcp/tools.json`.

## Inicie o NeNe primeiro

1. Clone NeNe: [github.com/hideyukiMORI/NeNe](https://github.com/hideyukiMORI/NeNe)
2. `composer install` na raiz
3. Inicie o app — Docker ou PHP host; veja NeNe `docs/development/docker.md`
4. Confirme HTTP (`GET /health/index`)

Depois:

```bash
composer require hideyukimori/nene-mcp:^0.1
```

## Passos

1. REST com OpenAPI (convenção NeNe)
2. Commit `docs/mcp/tools.json` — formato NENE2 ([referência](/pt-br/reference/catalog-format))
3. Caminhos **absolutos** no host MCP ([Cursor](/pt-br/tutorial/cursor-setup))
4. Smoke read antes de write — [teste smoke](/pt-br/howto/catalog-smoke-test)
5. TODO NeNe / sessão: [Padrões de catálogo NeNe](/pt-br/howto/neene-catalog-patterns)

::: warning Caminho absoluto do catálogo
`NENE_MCP_TOOLS_JSON` deve ser **absoluto**.
:::

::: info Limite session cookie NeNe
O exemplo NeNe protege `/todo/*` com **cookies de sessão**. nene-mcp é **proxy Bearer stateless** — fluxo login → lista → criar **não** completa sem auth no host. [Padrões NeNe](/pt-br/howto/neene-catalog-patterns).
:::

## URL base

`NENE_MCP_API_BASE_URL` deve incluir prefixo `URI_ROOT` se aplicável.

## Relacionado

- [Exemplo bridge Bearer-native](/pt-br/howto/bearer-native-bridge-example)
- [Ecossistema](/pt-br/integrations/ecosystem)
