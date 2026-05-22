# Premiers pas

nene-mcp ajoute **stdio MCP** à toute API HTTP via un catalogue compatible NENE2.

## Prérequis

- PHP **8.2+**
- [Composer](https://getcomposer.org/)
- Hôte MCP (Cursor, Claude Desktop, etc.)

## Installation

```bash
composer require hideyukimori/nene-mcp
```

Publié sur [Packagist](https://packagist.org/packages/hideyukimori/nene-mcp). Épingler une version :

```bash
composer require hideyukimori/nene-mcp:^0.1
```

Consultez [Packagist](https://packagist.org/packages/hideyukimori/nene-mcp) ou [GitHub Releases](https://github.com/hideyukiMORI/nene-mcp/releases). Si les docs affichent une version plus récente que Packagist, utilisez le **dernier tag publié** jusqu’à synchronisation.

## Day 0 — about uniquement

Sans `NENE_MCP_TOOLS_JSON`, seul `nene_mcp_about` :

```bash
export NENE_MCP_API_BASE_URL=http://localhost:8080
printf '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}\n' | php vendor/bin/nene-mcp
```

## Suite

- [Configuration Cursor](/fr/tutorial/cursor-setup)
- [Intégrer avec NeNe](/fr/howto/integrate-nene)
