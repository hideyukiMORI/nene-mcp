# 書き込みツールと Bearer

カタログで `"safety": "write"`（または non-read）のエントリは、MCP サーバー環境に **`NENE_MCP_BEARER_TOKEN`** が必要です。

## Fail-closed デフォルト

Bearer なしでは `tools/call` は JSON-RPC エラーを返し **HTTP を送信しません**:

```text
Write tool "myTool" requires bearer authentication. Set NENE_MCP_BEARER_TOKEN in the MCP server environment.
```

## トークンの置き場所

| OK | NG |
| --- | --- |
| MCP ホストの `env`（Cursor 等） | `tools.json` |
| MCP プロセスの OS 環境 | git コミット |
| シークレットマネージャ → 実行時 env | `nene_mcp_about` 出力 |

## トークンの取得

**OpenAPI の security scheme** に従います:

- **Bearer / JWT API**: 通常の auth フローで発行
- **NeNe TODO サンプル**: OpenAPI は **`sessionCookie`** — [NeNe カタログパターン](/ja/howto/neene-catalog-patterns) を参照（MCP  alone では認証 TODO 不可）
- **`write` の login ツール**: HTTP login が公開でも env Bearer 必須 — Cookie ホストでは **プレースホルダ** で fail-closed を満たす場合あり

nene-mcp は env が設定されていれば `Authorization: Bearer …` を HTTP に付与します。

## MCP 引数の資格情報

`tools/call` の `user_id` / `user_pass` は **MCP ログとエージェント transcript** に残ります。dev 専用アカウントを使い、git に載せないでください。

## 読み取りツール

`safety: read` は nene-mcp 上 Bearer 不要（env を設定した場合は GET にも Bearer 送信）。

**Bearer 必須 GET:** read でも API が **401** を返すなら `NENE_MCP_BEARER_TOKEN` を設定 — fail-closed 前に HTTP が飛ぶ。[Bearer-native 例](/ja/howto/bearer-native-bridge-example)

## safety ラベルと HTTP メソッド

fail-closed は **`safety` が `read` でないとき** のみ。OpenAPI の security からは推論しません。

| 誤り | 症状 |
| --- | --- |
| Bearer 必須 **POST** を `"safety": "read"` | env Bearer なしで HTTP → **401**（JSON-RPC fail-closed なし） |
| 同じルートを `"safety": "write"` | env Bearer なし → JSON-RPC エラー（HTTP 送信前） |

**ルール:** ミューティングで Bearer 必須なら `write` を使う（または read のまま env Bearer を設定）。FT262+ F-7 参照。

GET に session cookie が必要なホストは Bearer だけでは不足 — [NeNe カタログパターン](/ja/howto/neene-catalog-patterns)。

## 関連

- [セキュリティモデル](/ja/explanation/security-model)
- [環境変数](/ja/reference/environment-variables)
- [NeNe カタログパターン](/ja/howto/neene-catalog-patterns)
