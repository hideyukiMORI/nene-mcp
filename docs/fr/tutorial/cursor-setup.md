# Configuration Cursor / MCP

Configurez le hôte MCP pour lancer `vendor/bin/nene-mcp` en stdio. **Chemins absolus** obligatoires.

## Avec catalogue (typique)

```json
{
  "mcpServers": {
    "nene-mcp": {
      "command": "php",
      "args": ["/CHEMIN/ABS/vendor/bin/nene-mcp"],
      "env": {
        "NENE_MCP_API_BASE_URL": "http://localhost:8080",
        "NENE_MCP_TOOLS_JSON": "/CHEMIN/ABS/your-app/docs/mcp/tools.json"
      }
    }
  }
}
```

## Smoke sans catalogue

Omettez `NENE_MCP_TOOLS_JSON` tant que le fichier n’existe pas.

::: tip Chemins relatifs — piège cwd
Un chemin relatif peut marcher **si** le cwd du host MCP = racine du projet. Autre cwd (sous-dossier, CI) → catalogue introuvable. Préférez les **chemins absolus** dans `.cursor/mcp.json` commité.
:::

## Outils d’écriture

Bearer uniquement dans le bloc `env` du hôte MCP — jamais dans git. Voir [Outils d’écriture & Bearer](/fr/howto/write-tools-bearer).

## Vérifier

1. Démarrage sans stack trace stderr
2. `tools/list` → `nene_mcp_about` (+ outils catalogue)
3. `tools/call` read → status HTTP + JSON

## Équipes frontend / Cursor

`.cursor/mcp.json` dans le repo : **chemins absolus par machine**. Remplacez `/CHEMIN/ABS` ou documentez la procédure.

## Voir aussi

- [Intégrer avec NeNe](/fr/howto/integrate-nene)
- [Motifs catalogue NeNe](/fr/howto/neene-catalog-patterns)
