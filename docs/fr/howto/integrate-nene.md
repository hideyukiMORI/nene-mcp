# Intégrer avec NeNe

nene-mcp n’a **aucun code NeNe**. NeNe est un hôte qui fournit OpenAPI + `docs/mcp/tools.json`.

## Démarrer NeNe d’abord

Les docs nene-mcp supposent une **app NeNe HTTP en marche**. Sinon :

1. Cloner NeNe : [github.com/hideyukiMORI/NeNe](https://github.com/hideyukiMORI/NeNe)
2. `composer install` à la racine
3. Démarrer l’app — Docker (`compose.yaml`) ou PHP hôte ; voir NeNe `docs/development/docker.md`
4. Vérifier HTTP (ex. `GET /health/index` sur votre URL de base)

Puis ajouter nene-mcp au **même projet** :

```bash
composer require hideyukimori/nene-mcp:^0.1
```

## Prérequis

- NeNe local (Docker ou PHP hôte)
- PHP **ext-intl** avec les images Docker NeNe
- Chemins **absolus** dans la config MCP ([Configuration Cursor](/fr/tutorial/cursor-setup))

## Étapes

1. Exposer des REST documentés OpenAPI (convention NeNe).
2. Commiter `docs/mcp/tools.json` — format NENE2 ([référence catalogue](/fr/reference/catalog-format)). Commencer par [exemple health](/fr/howto/health-catalog-example).
3. Configurer le hôte MCP avec chemins absolus vers `vendor/bin/nene-mcp` et `tools.json`.
4. **Smoke** les outils read ([test smoke](/fr/howto/catalog-smoke-test)) avant les write.
5. Pour TODO / session NeNe : [Motifs catalogue NeNe](/fr/howto/neene-catalog-patterns).

::: warning Chemin catalogue absolu
Utilisez un chemin **absolu** pour `NENE_MCP_TOOLS_JSON`. Les chemins relatifs dépendent du cwd du processus MCP.
:::

::: info Limite session cookie NeNe
L’échantillon NeNe protège `/todo/*` par **cookies de session**. nene-mcp est un **proxy Bearer stateless** — pas de cookies entre appels MCP. Health OK ; **login → liste → création** impossible sans changement auth hôte. Détails : [Motifs catalogue NeNe](/fr/howto/neene-catalog-patterns).
:::

## URL de base (`NENE_MCP_API_BASE_URL`)

Doit correspondre à l’URL réelle de NeNe (prefix `URI_ROOT` ou reverse proxy inclus). Ex. `http://localhost:8080/mybiz` + path `/health/index`. Mauvais prefix → **404**. Voir [Motifs catalogue NeNe](/fr/howto/neene-catalog-patterns).

## Alias d’environnement

| nene-mcp | NENE2 |
| --- | --- |
| `NENE_MCP_API_BASE_URL` | `NENE2_LOCAL_API_BASE_URL` |
| `NENE_MCP_TOOLS_JSON` | `NENE2_LOCAL_TOOLS_JSON` |

## Lacunes bootstrap

Bloquer sur Docker NeNe ou extensions → Issues dans le **dépôt NeNe**.

## Voir aussi

- [Autres plateformes](/fr/howto/other-platforms)
- [Écosystème](/fr/integrations/ecosystem)
- [Motifs catalogue NeNe](/fr/howto/neene-catalog-patterns)
