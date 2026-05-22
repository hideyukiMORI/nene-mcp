# NeNe カタログパターン

`docs/api/openapi.yaml` を `docs/mcp/tools.json` に映射するときの NeNe 固有の規約。nene-mcp に NeNe 専用コードはありません。

## パスパラメータ（`id_{param}`）

NeNe は OpenAPI の `{param}` だけでなく **key-value 形式のパス** を使うことがあります。

| OpenAPI path | カタログ `path` | `tools/call` 引数 |
| --- | --- | --- |
| `/todo/item/id_{id}` | `/todo/item/id_{id}` | `{ "id": "42" }` → HTTP `/todo/item/id_42` |

nene-mcp は `path` 内の `{name}` を引数で URL エンコードして置換します。

**よくある誤り:** 汎用 OpenAPI 風の `/todo/item/{id}` をそのまま使う → NeNe は `id_{id}` を期待するため **405**。

## ベース URL と `URI_ROOT`

`NENE_MCP_API_BASE_URL` は NeNe が HTTP を提供する **オリジン + デプロイ prefix**。カタログ `path` が後ろに付きます。

| NeNe デプロイ | `NENE_MCP_API_BASE_URL` | カタログ path |
| --- | --- | --- |
| ルート | `http://localhost:8080` | `/health/index` |
| `URI_ROOT=/mybiz/` | `http://localhost:8080/mybiz` | `/health/index` |

**不一致の症状:** health や業務 API が **404**（`isError: true`）— NeNe の `URI_ROOT` とリバースプロキシ prefix を確認。

## セッション Cookie 認証（TODO サンプル）

NeNe OpenAPI は `/todo/*` に **`sessionCookie`** を宣言 — Bearer ではありません。

nene-mcp は現状:

- `NENE_MCP_BEARER_TOKEN` があるとき **`Authorization: Bearer …`** を送信
- MCP 呼び出し間で **`Set-Cookie` を保持しない**（ステートレス HTTP）

そのため **login → listTodos → createTodo** の多段フローは、標準 NeNe サンプルだけでは MCP 上 **完結しません**。

| 目的 | 現実的な方法 |
| --- | --- |
| health 等の公開 read | ドキュメント通り MCP で可 |
| NeNe TODO を MCP 化 | NeNe 側で Bearer 対応を追加、または Bearer 前提の API を使う |

## 書き込みツールと login ブートストラップ

`safety: write` は env に Bearer 必須（fail-closed）。NeNe `/session/login` は未認証 POST 可だが、カタログ上 login ツールも Bearer なしでは **HTTP 前に拒否**されます。Cookie ホストでは **プレースホルダ Bearer** で fail-closed を満たす運用があります。

**MCP 引数の資格情報:** `user_id` / `user_pass` はエージェント transcript に残ります。dev 専用アカウントを使い、git に載せないでください。

## 関連

- [NeNe 連携](/ja/howto/integrate-nene)
- [書き込みツールと Bearer](/ja/howto/write-tools-bearer)
- [NeNe health カタログ例](/ja/howto/health-catalog-example)
