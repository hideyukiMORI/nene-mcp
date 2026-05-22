# ツールカタログ JSON

NENE2 `docs/mcp/tools.json` 互換。

## ルール

| フィールド | ルール |
| --- | --- |
| `name` | カタログ内で一意（v0.1.3+） |
| `safety` | `read` または `write`（non-read は Bearer 必須） |
| `source.type` | JSON カタログでは `openapi` |
| `source.path` | ベース URL に連結される相対 path |

## パスパラメータ

`path` 内の `{param}` を `tools/call` 引数で置換。**NeNe** は `/todo/item/id_{id}` 形式 — [NeNe カタログパターン](/ja/howto/neene-catalog-patterns)。

## クエリパラメータ（GET）

GET ツールでは path に使わなかった引数が **クエリ文字列** になります（例: `sku` → `?sku=WIDGET-1`）。POST 等の残り引数は JSON body。

## サンプル

[NeNe health カタログ例](/ja/howto/health-catalog-example)
