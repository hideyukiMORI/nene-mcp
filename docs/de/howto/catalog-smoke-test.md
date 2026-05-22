# Katalog-Smoke-Test

MCP-Verkabelung prüfen, bevor Write-Tools freigegeben werden.

## 1. Nur about

```bash
unset NENE_MCP_TOOLS_JSON
export NENE_MCP_API_BASE_URL=http://localhost:8080
printf '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}\n' | php vendor/bin/nene-mcp
```

Erwartet: genau `nene_mcp_about`.

## 2. Mit Katalog

Read-Tool `tools/call` → `statusCode` + JSON `body`.

## 2b. Tool-Anzahl (partieller Katalog)

Nach `tools/list` prüfen, ob **alle** erwarteten Business-Tools gelistet sind — nicht nur Health. Fehlende Tools können Agents nicht aufrufen. Siehe [Bearer-native Bridge](/de/howto/bearer-native-bridge-example).

## Häufige Fehler

| Symptom | Ursache |
| --- | --- |
| Read-Tool HTTP 401 | Bearer-geschütztes GET — `NENE_MCP_BEARER_TOKEN` setzen |
| Agent „Tool fehlt“ | Partieller Katalog — Tool-Liste prüfen (§2b) |
| Doppelter Name | Zwei Tools mit gleichem `name` |
