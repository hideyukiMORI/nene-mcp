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

## Safety-Label vs HTTP-Methode

Fail-closed nur bei `safety` ≠ `read`. Bearer-geschütztes **POST** als `"safety": "read"` → HTTP ohne env Bearer, API **401** (kein JSON-RPC-Fehler). Mutierende Bearer-Routen: **`write`** verwenden. Siehe [Schreib-Tools](/de/howto/write-tools-bearer).

Session-Cookie-Hosts: [NeNe-Katalogmuster](/de/howto/neene-catalog-patterns).

## Weiter

- [Sicherheitsmodell](/de/explanation/security-model)
- [Umgebungsvariablen](/de/reference/environment-variables)
