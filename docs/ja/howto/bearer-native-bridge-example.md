# Bearer ネイティブ bridge 例

[NeNe カタログパターン](/ja/howto/neene-catalog-patterns) との対比: API が **`Authorization: Bearer`** を使う場合、env トークンで **認証付き read/write** を MCP 越しに実行できます。

## 要点

1. [その他プラットフォーム](/ja/howto/other-platforms) の sidecar bridge 構成
2. トークンは **MCP host env** のみ（`tools.json` / git 不可）
3. **`safety: read` でも API が Bearer 必須なら** `NENE_MCP_BEARER_TOKEN` を設定（401 のとき）
4. トークン発行 API を `write` にした場合は fail-closed — [English 全文](/howto/bearer-native-bridge-example)

## 関連

- [書き込みツールと Bearer](/ja/howto/write-tools-bearer)
- [カタログ smoke テスト](/ja/howto/catalog-smoke-test)
