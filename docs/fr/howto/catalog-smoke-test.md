# Test smoke du catalogue

Vérifier le câblage MCP avant d'exposer les outils d'écriture.

## 1. About-only

```bash
unset NENE_MCP_TOOLS_JSON
export NENE_MCP_API_BASE_URL=http://localhost:8080
printf '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}\n' | php vendor/bin/nene-mcp
```

Attendu : un seul outil `nene_mcp_about`.

## 2. Avec catalogue

```bash
export NENE_MCP_TOOLS_JSON=/CHEMIN/ABS/docs/mcp/tools.json
printf '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"getHealthCheck","arguments":{}}}\n' \
  | php vendor/bin/nene-mcp
```

Attendu : `statusCode` et JSON `body`.

## 2b. Nombre d'outils (catalogue partiel)

Après `tools/list`, confirmez que **tous** les outils métier attendus sont présents — pas seulement health. [Exemple bridge Bearer-native](/fr/howto/bearer-native-bridge-example).

## 3. Harness d'automation

```bash
tools/ft-runner.sh smoke /path/to/tools.json
tools/ft-runner.sh write-failclosed /tmp/ft-write
```

## Échecs fréquents

| Symptôme | Cause |
| --- | --- |
| Erreur `tools/list` | Chemin catalogue invalide |
| Connexion refusée | App arrêtée ou mauvaise URL |
| Nom dupliqué | Deux tools avec le même `name` |
| Read HTTP 401 | GET Bearer — `NENE_MCP_BEARER_TOKEN` |
| Outil manquant | Catalogue partiel — §2b |
