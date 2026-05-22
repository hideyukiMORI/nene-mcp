# Configuração Cursor / MCP

Use caminhos **absolutos** para `vendor/bin/nene-mcp` e `NENE_MCP_TOOLS_JSON`.

Bearer para write apenas no `env` do host — [Ferramentas de escrita](/pt-br/howto/write-tools-bearer).

## Relacionado

- [Integrar NeNe](/pt-br/howto/integrate-nene)

::: tip Caminhos relativos — armadilha de cwd
Relativo pode funcionar se cwd = raiz do projeto. Outros contextos falham. Use **caminhos absolutos** em `.cursor/mcp.json`.
:::
