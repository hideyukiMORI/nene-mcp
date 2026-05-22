# Tool-Katalog JSON

NENE2-kompatibles Format für `docs/mcp/tools.json`.

| Feld | Regel |
| --- | --- |
| `name` | Eindeutig (v0.1.3+) |
| `safety` | `read` oder `write` |
| `source.path` | Relativ zur Basis-URL |

## Pfadparameter

`{param}` in `path`. **NeNe:** `/todo/item/id_{id}` — [NeNe-Katalogmuster](/de/howto/neene-catalog-patterns).

## Beispiel

[NeNe Health-Katalog](/de/howto/health-catalog-example)
