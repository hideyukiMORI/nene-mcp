# NeNe 連携

nene-mcp に NeNe 専用コードはありません。NeNe は OpenAPI + `docs/mcp/tools.json` を提供するホストの一つです。

## 先に NeNe を起動する

nene-mcp のドキュメントは **動作中の NeNe HTTP アプリ** を前提としています。まだ無い場合:

1. NeNe を clone: [github.com/hideyukiMORI/NeNe](https://github.com/hideyukiMORI/NeNe)
2. プロジェクトルートで `composer install`
3. アプリを起動 — Docker（`compose.yaml`）またはホスト PHP。NeNe の `docs/development/docker.md` を参照
4. HTTP が応答することを確認（例: ベース URL で `GET /health/index`）

その後、**同一プロジェクト**（または同じ `vendor/` にアクセスできる bridge リポジトリ）に nene-mcp を追加:

```bash
composer require hideyukimori/nene-mcp:^0.1
```

## 前提

- ローカルで NeNe が動作している（Docker またはホスト PHP）
- NeNe Docker 利用時は PHP **ext-intl**
- MCP ホスト設定は [Cursor 設定](/ja/tutorial/cursor-setup) のとおり **絶対パス**

## 手順

1. OpenAPI 付き REST を公開（NeNe 規約）
2. `docs/mcp/tools.json` をコミット — NENE2 形式（[カタログリファレンス](/ja/reference/catalog-format)）。[health カタログ例](/ja/howto/health-catalog-example) から開始可
3. `vendor/bin/nene-mcp` と `tools.json` への **絶対パス** で MCP ホストを設定
4. 読み取りツールを [smoke テスト](/ja/howto/catalog-smoke-test) してから書き込みを有効化
5. NeNe TODO / セッションルートは [NeNe カタログパターン](/ja/howto/neene-catalog-patterns) を参照（パス、`URI_ROOT`、セッション vs Bearer）

::: warning カタログパスは絶対パス
`NENE_MCP_TOOLS_JSON` は **絶対パス** を使ってください。相対パスは MCP プロセスの cwd に依存し、Cursor 起動時に `docs/mcp/tools.json` が解決しないことがあります。
:::

::: info NeNe セッション Cookie の制限
標準 NeNe サンプルは `/todo/*` を **セッション Cookie** で保護します。nene-mcp は **ステートレス Bearer プロキシ** で、MCP 呼び出し間に Cookie を保持しません。health 等の公開 read は可。**login → 一覧 → 作成** はホスト側 auth 変更なしでは完結しません。詳細: [NeNe カタログパターン](/ja/howto/neene-catalog-patterns)。
:::

## ベース URL（`NENE_MCP_API_BASE_URL`）

NeNe が実際に HTTP を提供する URL（`URI_ROOT` やリバースプロキシ prefix 含む）と一致させます。例: `http://localhost:8080/mybiz/…` → `NENE_MCP_API_BASE_URL=http://localhost:8080/mybiz`、path は `/health/index` のまま。prefix 不一致 → **404**。[NeNe カタログパターン](/ja/howto/neene-catalog-patterns) を参照。

## エイリアス

| nene-mcp | NENE2 |
| --- | --- |
| `NENE_MCP_API_BASE_URL` | `NENE2_LOCAL_API_BASE_URL` |
| `NENE_MCP_TOOLS_JSON` | `NENE2_LOCAL_TOOLS_JSON` |

## Bootstrap の不足

NeNe Docker や拡張の前提で止まった場合は **NeNe リポジトリ** に Issue を起票 — nene-mcp はブリッジのみ文書化します。

## 関連

- [その他プラットフォーム](/ja/howto/other-platforms)
- [エコシステム](/ja/integrations/ecosystem)
- [NeNe カタログパターン](/ja/howto/neene-catalog-patterns)
