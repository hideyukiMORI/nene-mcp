# Getting started

nene-mcp adds **stdio MCP** to any HTTP API using a NENE2-compatible tool catalog.

## Requirements

- PHP **8.2+**
- [Composer](https://getcomposer.org/)
- An MCP host (Cursor, Claude Desktop, etc.)

## Install

```bash
composer require hideyukimori/nene-mcp
```

Published on [Packagist](https://packagist.org/packages/hideyukimori/nene-mcp). Pin a version for reproducible field trials:

```bash
composer require hideyukimori/nene-mcp:0.1.3
```

## Development clone

```bash
git clone https://github.com/hideyukiMORI/nene-mcp.git
cd nene-mcp
composer install
composer test
```

## Day 0 — about-only smoke

Before `tools.json` exists, omit `NENE_MCP_TOOLS_JSON`. MCP starts with only the built-in read-only tool `nene_mcp_about`:

```bash
export NENE_MCP_API_BASE_URL=http://localhost:8080
printf '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}\n' | php vendor/bin/nene-mcp
```

## Next steps

- [Cursor / MCP client setup](/tutorial/cursor-setup)
- [Integrate with NeNe](/howto/integrate-nene)
- [Environment variables](/reference/environment-variables)
