# 書き込みツールと Bearer

`safety: write`（および non-read）は **`NENE_MCP_BEARER_TOKEN`** 必須。未設定時は HTTP を送らず JSON-RPC エラー（fail-closed）。

トークンは MCP ホストの env のみ — `tools.json` や git に置かない。

[セキュリティモデル](/ja/explanation/security-model)
