# Cursor / MCP クライアント設定

MCP ホスト（Cursor 等）から stdio で `vendor/bin/nene-mcp` を起動します。**パスは絶対パス**を使ってください。

## カタログあり（通常）

`php` の args と `NENE_MCP_TOOLS_JSON` に **絶対パス**:

```json
{
  "mcpServers": {
    "nene-mcp": {
      "command": "php",
      "args": ["/ABS/PATH/vendor/bin/nene-mcp"],
      "env": {
        "NENE_MCP_API_BASE_URL": "http://localhost:8080",
        "NENE_MCP_TOOLS_JSON": "/ABS/PATH/your-app/docs/mcp/tools.json"
      }
    }
  }
}
```

## カタログなし smoke

`tools.json` ができるまで `NENE_MCP_TOOLS_JSON` を省略:

```json
{
  "mcpServers": {
    "nene-mcp": {
      "command": "php",
      "args": ["/ABS/PATH/vendor/bin/nene-mcp"],
      "env": {
        "NENE_MCP_API_BASE_URL": "http://localhost:8080"
      }
    }
  }
}
```

プレースホルダパスを `NENE_MCP_TOOLS_JSON` に設定しないでください — ファイルが無いと `tools/list` 全体が失敗します。

::: tip 相対パスが動くことがある — それでも避ける
MCP ホストの cwd がプロジェクトルートのとき、`docs/mcp/tools.json` が **一時的に** 解決することがあります。サブフォルダ起動・monorepo・CI では **catalog not found** になります。コミットする `.cursor/mcp.json` には **絶対パス** を使うか、開発者ごとの置換手順を書いてください。
:::

## 書き込みツール

カタログに `"safety": "write"` がある場合、MCP ホストの env にのみ Bearer を設定（git 不可）:

```json
"env": {
  "NENE_MCP_API_BASE_URL": "http://localhost:8080",
  "NENE_MCP_TOOLS_JSON": "/ABS/PATH/docs/mcp/tools.json",
  "NENE_MCP_BEARER_TOKEN": "your-session-token"
}
```

詳細: [書き込みと Bearer](/ja/howto/write-tools-bearer)

## 確認

1. MCP サーバーが stderr にスタックトレースを出さず起動する
2. `tools/list` が `nene_mcp_about`（+ カタログ設定時は HTTP ツール）を返す
3. 読み取りツールの `tools/call` が HTTP status と JSON body を返す

## フロントエンド / Cursor チーム向け

`.cursor/mcp.json` をリポジトリに置く場合も **各開発者マシン上の絶対パス** が必要です。`/ABS/PATH` を環境ごとに置換するか、ドキュメントに置換手順を書いてください。相対パスは Cursor の cwd 次第で壊れます。
