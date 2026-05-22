# カタログ smoke テスト

1. `NENE_MCP_TOOLS_JSON` 未設定 → `nene_mcp_about` のみ
2. カタログ設定後 → read ツールで `statusCode` 確認
3. `tools/ft-runner.sh smoke /path/to/tools.json`

重複 `name` は v0.1.3+ でロード時エラー。
