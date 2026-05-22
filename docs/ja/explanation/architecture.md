# アーキテクチャ

MCP クライアント ↔ stdio JSON-RPC ↔ `bin/nene-mcp` ↔ HTTP ↔ あなたのアプリ。

| コンポーネント | 役割 |
| --- | --- |
| `StdioMcpServer` | initialize / tools/list / tools/call |
| `JsonToolCatalog` | tools.json 読み込み・検証 |
| `NativeMcpHttpClient` | Bearer、リダイレクト無効 |

[環境変数](/ja/reference/environment-variables)
