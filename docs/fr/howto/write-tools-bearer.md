# Outils d’écriture & Bearer

Les entrées `"safety": "write"` exigent **`NENE_MCP_BEARER_TOKEN`** dans l’environnement du serveur MCP.

## Fail-closed

Sans Bearer, `tools/call` renvoie une erreur JSON-RPC **sans HTTP** :

```text
Write tool "myTool" requires bearer authentication. Set NENE_MCP_BEARER_TOKEN in the MCP server environment.
```

## Où mettre le token

| OK | Interdit |
| --- | --- |
| Bloc `env` du hôte MCP | `tools.json` |
| Environnement OS du processus MCP | Commits git |
| Secret manager → env runtime | Sortie `nene_mcp_about` |

## Obtenir un token

Suivre le **schéma de sécurité OpenAPI** :

- **API Bearer / JWT** : flux auth habituel
- **Module TODO NeNe** : OpenAPI utilise **`sessionCookie`** — voir [Motifs catalogue NeNe](/fr/howto/neene-catalog-patterns)
- **Login marqué `write`** : Bearer env requis même si la route HTTP est publique — **placeholder** possible sur hôtes cookie

nene-mcp envoie `Authorization: Bearer …` quand la variable est définie.

## Identifiants dans les arguments MCP

Mots de passe dans `tools/call` → **logs MCP et transcripts agent**. Comptes dev uniquement.

## Outils read

`safety: read` n’exige pas Bearer dans nene-mcp. GET Bearer-protégé → **401** sans env : définir `NENE_MCP_BEARER_TOKEN`. Voir [exemple Bearer-native](/fr/howto/bearer-native-bridge-example).

## Libellé safety vs méthode HTTP

Fail-closed seulement si `safety` ≠ `read`. **POST** Bearer-protégé en `"safety": "read"` → HTTP sans Bearer env, **401** API. Routes mutantes Bearer : utiliser **`write`**. F-7 / FT262+.

Cookies session sur GET : [Motifs catalogue NeNe](/fr/howto/neene-catalog-patterns).

## Voir aussi

- [Modèle de sécurité](/fr/explanation/security-model)
- [Variables d’environnement](/fr/reference/environment-variables)
- [Motifs catalogue NeNe](/fr/howto/neene-catalog-patterns)
