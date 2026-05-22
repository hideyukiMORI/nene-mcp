# カタログ smoke テスト

MCP 配線を書き込みツールの前に確認します。

## 1. about のみ

```bash
unset NENE_MCP_TOOLS_JSON
export NENE_MCP_API_BASE_URL=http://localhost:8080
printf '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}\n' | php vendor/bin/nene-mcp
```

`nene_mcp_about` のみであること。

## 2. カタログあり

```bash
export NENE_MCP_TOOLS_JSON=/ABS/PATH/docs/mcp/tools.json
printf '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"getHealthCheck","arguments":{}}}\n' \
  | php vendor/bin/nene-mcp
```

structured content に `statusCode` があること。

## 3. よくある失敗

| 症状 | 原因 |
| --- | --- |
| `tools/list` エラー | カタログパス不正・ファイル不存在 |
| connection refused | アプリ未起動または base URL 誤り |
| duplicate name | 同一 `name` が重複（v0.1.3+） |

[English](/howto/catalog-smoke-test)
