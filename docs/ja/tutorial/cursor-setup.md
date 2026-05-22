# Cursor / MCP クライアント設定

MCP ホストから stdio で `vendor/bin/nene-mcp` を起動します。**パスは絶対パス**で。

## カタログあり（通常）

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

`NENE_MCP_TOOLS_JSON` を省略。存在しないパスを指定すると `tools/list` 全体が失敗します。

## 書き込みツール

`safety: write` には MCP ホストの env にのみ Bearer を設定（git 不可）。詳細: [書き込みと Bearer](/ja/howto/write-tools-bearer)。
