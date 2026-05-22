# Motifs catalogue NeNe

Conventions NeNe lors du mapping `docs/api/openapi.yaml` → `docs/mcp/tools.json`. nene-mcp n’a **aucun code NeNe**.

## Paramètres de chemin (`id_{param}`)

NeNe utilise souvent des segments **clé-valeur**, pas seulement `{param}` OpenAPI.

| Chemin OpenAPI | `path` catalogue | Arguments `tools/call` |
| --- | --- | --- |
| `/todo/item/id_{id}` | `/todo/item/id_{id}` | `{ "id": "42" }` → HTTP `/todo/item/id_42` |

**Erreur fréquente :** `/todo/item/{id}` → NeNe répond **405** (route attend `id_{id}`).

## URL de base et `URI_ROOT`

`NENE_MCP_API_BASE_URL` = origine + préfixe de déploiement. Les `path` du catalogue s’y ajoutent.

| Déploiement | `NENE_MCP_API_BASE_URL` | Chemin catalogue |
| --- | --- | --- |
| Racine | `http://localhost:8080` | `/health/index` |
| `URI_ROOT=/mybiz/` | `http://localhost:8080/mybiz` | `/health/index` |

Symptôme de mismatch : **404** sur health ou TODO — vérifier `URI_ROOT` NeNe.

## Auth session cookie (module TODO)

OpenAPI NeNe : **`sessionCookie`** sur `/todo/*`, pas Bearer.

nene-mcp :

- Envoie **`Authorization: Bearer …`** si `NENE_MCP_BEARER_TOKEN` est défini
- **Ne conserve pas** les cookies entre appels MCP

Flux **login → listTodos → createTodo** : **impossible** de bout en bout sur l’échantillon NeNe stock sans auth côté hôte.

## Outils d’écriture et bootstrap login

`safety: write` exige Bearer en env (fail-closed). Pour un login HTTP public, un **Bearer placeholder** peut débloquer fail-closed.

Les identifiants dans les arguments MCP apparaissent dans les **transcripts agent** — comptes dev uniquement.

## Voir aussi

- [Intégrer avec NeNe](/fr/howto/integrate-nene)
- [Outils d’écriture & Bearer](/fr/howto/write-tools-bearer)
- [Exemple catalogue health](/fr/howto/health-catalog-example)
