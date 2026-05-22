# Cursor / MCP-Client einrichten

MCP-Host startet `vendor/bin/nene-mcp` per stdio. **Absolute Pfade** verwenden.

## Mit Katalog

```json
{
  "mcpServers": {
    "nene-mcp": {
      "command": "php",
      "args": ["/ABS/PFAD/vendor/bin/nene-mcp"],
      "env": {
        "NENE_MCP_API_BASE_URL": "http://localhost:8080",
        "NENE_MCP_TOOLS_JSON": "/ABS/PFAD/docs/mcp/tools.json"
      }
    }
  }
}
```

::: tip Relative Pfade — cwd-Falle
Relativ kann funktionieren, wenn MCP-cwd = Projektroot. Sonst Katalog fehlt. **Absolute Pfade** in `.cursor/mcp.json`.
:::

## Schreib-Tools

Bearer nur im MCP-`env`-Block. Siehe [Schreib-Tools & Bearer](/de/howto/write-tools-bearer).

## Prüfen

1. Start ohne stderr-Stacktrace
2. `tools/list` → `nene_mcp_about` (+ Katalog-Tools)
3. Read-`tools/call` → HTTP-Status + JSON

## Weiter

- [NeNe integrieren](/de/howto/integrate-nene)
- [Bearer-native Bridge](/de/howto/bearer-native-bridge-example)
