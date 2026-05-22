# NeNe 連携

nene-mcp に NeNe 専用コードはありません。NeNe は OpenAPI + `docs/mcp/tools.json` を提供するホストの一つです。

## 手順

1. OpenAPI 付き REST を公開
2. NENE2 形式の `docs/mcp/tools.json` をコミット
3. [Cursor 設定](/ja/tutorial/cursor-setup)（絶対パス）
4. 読み取りツールを smoke してから書き込みを有効化

## エイリアス

| nene-mcp | NENE2 |
| --- | --- |
| `NENE_MCP_API_BASE_URL` | `NENE2_LOCAL_API_BASE_URL` |
| `NENE_MCP_TOOLS_JSON` | `NENE2_LOCAL_TOOLS_JSON` |

NeNe 側の bootstrap 不足は **NeNe リポジトリ** に Issue を起票してください。
