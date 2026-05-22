# カタログ smoke テスト

書き込みツール公開前に MCP 配線を検証します。

## 1. about のみ

`NENE_MCP_TOOLS_JSON` 未設定 → `nene_mcp_about` のみ。

## 2. カタログあり

read ツールの `tools/call` で `statusCode` と JSON `body` を確認。

## 2b. ツール数チェック（部分カタログ防止）

`tools/list` 後、health だけでなく **期待する業務ツール名がすべて並ぶか** 確認。欠けていれば agents は呼べません。[Bearer ネイティブ bridge 例](/ja/howto/bearer-native-bridge-example)。

## よくある失敗

| 症状 | 原因 |
| --- | --- |
| read が HTTP 401 | Bearer 必須 GET — `NENE_MCP_BEARER_TOKEN` を設定 |
| エージェントがツール不在 | 部分デプロイ — §2b を実行 |

詳細コマンド: [English catalog smoke test](/howto/catalog-smoke-test)
