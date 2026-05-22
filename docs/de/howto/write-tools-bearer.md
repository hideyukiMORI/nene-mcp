# Schreib-Tools & Bearer

Katalogeinträge mit `"safety": "write"` erfordern **`NENE_MCP_BEARER_TOKEN`** in der MCP-Server-Umgebung.

## Fail-closed

Ohne Bearer: JSON-RPC-Fehler, **kein HTTP**.

## Token-Quelle

- **Bearer-/JWT-APIs**: üblicher Auth-Flow
- **NeNe TODO-Beispiel**: OpenAPI nutzt **`sessionCookie`** — [NeNe-Katalogmuster](/de/howto/neene-catalog-patterns)
- **Öffentlicher Login als `write`**: ggf. **Platzhalter-Bearer** für fail-closed

## Geschützte GET (Read-Tools)

`safety: read` erfordert in nene-mcp kein Bearer, aber Ihre API kann GET mit Bearer schützen → **401** ohne env. Dann `NENE_MCP_BEARER_TOKEN` setzen. Siehe [Bearer-native Bridge-Beispiel](/de/howto/bearer-native-bridge-example).

Session-Cookie-Hosts: [NeNe-Katalogmuster](/de/howto/neene-catalog-patterns).

## Weiter

- [Sicherheitsmodell](/de/explanation/security-model)
- [Umgebungsvariablen](/de/reference/environment-variables)
