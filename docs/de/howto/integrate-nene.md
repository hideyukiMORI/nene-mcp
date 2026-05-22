# NeNe integrieren

nene-mcp enthält **keinen NeNe-spezifischen Code**. NeNe ist ein Host mit OpenAPI + `docs/mcp/tools.json`.

## NeNe zuerst starten

Die nene-mcp-Docs setzen eine **laufende NeNe-HTTP-App** voraus:

1. NeNe klonen: [github.com/hideyukiMORI/NeNe](https://github.com/hideyukiMORI/NeNe)
2. `composer install` im Projektroot
3. App starten — Docker (`compose.yaml`) oder Host-PHP; siehe NeNe `docs/development/docker.md`
4. HTTP prüfen (z. B. `GET /health/index` auf Ihrer Basis-URL)

Dann nene-mcp im **selben Projekt** hinzufügen:

```bash
composer require hideyukimori/nene-mcp:^0.1
```

## Voraussetzungen

- NeNe lokal (Docker oder Host-PHP)
- PHP **ext-intl** mit NeNe-Docker-Images
- **Absolute Pfade** in der MCP-Host-Konfiguration ([Cursor-Einrichtung](/de/tutorial/cursor-setup))

## Schritte

1. REST-Endpunkte mit OpenAPI dokumentieren (NeNe-Konvention).
2. `docs/mcp/tools.json` committen — NENE2-Format ([Katalog-Referenz](/de/reference/catalog-format)). Start: [Health-Katalog-Beispiel](/de/howto/health-catalog-example).
3. MCP-Host mit absoluten Pfaden zu `vendor/bin/nene-mcp` und `tools.json` konfigurieren.
4. Read-Tools [smoke-testen](/de/howto/catalog-smoke-test), dann Write-Tools aktivieren.
5. NeNe TODO / Session: [NeNe-Katalogmuster](/de/howto/neene-catalog-patterns).

::: warning Absoluter Katalogpfad
`NENE_MCP_TOOLS_JSON` muss ein **absoluter Pfad** sein. Relative Pfade hängen vom cwd des MCP-Prozesses ab.
:::

::: info NeNe Session-Cookie-Grenze
Das NeNe-Beispiel schützt `/todo/*` mit **Session-Cookies**. nene-mcp ist ein **zustandsloser Bearer-Proxy** — keine Cookies zwischen MCP-Aufrufen. Health funktioniert; **Login → Liste → Erstellen** ohne Host-Auth-Änderung nicht. Details: [NeNe-Katalogmuster](/de/howto/neene-catalog-patterns).
:::

## Basis-URL (`NENE_MCP_API_BASE_URL`)

Muss der tatsächlichen NeNe-HTTP-URL entsprechen (inkl. `URI_ROOT` / Reverse-Proxy-Prefix). Siehe [NeNe-Katalogmuster](/de/howto/neene-catalog-patterns).

## Umgebungs-Aliase

| nene-mcp | NENE2 |
| --- | --- |
| `NENE_MCP_API_BASE_URL` | `NENE2_LOCAL_API_BASE_URL` |
| `NENE_MCP_TOOLS_JSON` | `NENE2_LOCAL_TOOLS_JSON` |

## Weiter

- [Andere Plattformen](/de/howto/other-platforms)
- [Bearer-native Bridge-Beispiel](/de/howto/bearer-native-bridge-example)
- [Ökosystem](/de/integrations/ecosystem)
