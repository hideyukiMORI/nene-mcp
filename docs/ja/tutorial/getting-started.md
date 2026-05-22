# はじめに

nene-mcp は NENE2 互換ツールカタログで **stdio MCP** を HTTP API に追加します。

## 要件

- PHP **8.2+**
- [Composer](https://getcomposer.org/)
- MCP ホスト（Cursor、Claude Desktop 等）

## インストール

```bash
composer require hideyukimori/nene-mcp
```

[Packagist](https://packagist.org/packages/hideyukimori/nene-mcp) 公開済み。再現性のためバージョン固定:

```bash
composer require hideyukimori/nene-mcp:^0.1
```

最新タグは [Packagist](https://packagist.org/packages/hideyukimori/nene-mcp) または [GitHub Releases](https://github.com/hideyukiMORI/nene-mcp/releases) を確認してください。ドキュメントのバージョンより Packagist が古い場合は、公開済みの最新タグを使ってください。

## Day 0 — about のみ

`tools.json` 完成前は `NENE_MCP_TOOLS_JSON` を省略。組み込み read-only ツール `nene_mcp_about` のみ:

```bash
export NENE_MCP_API_BASE_URL=http://localhost:8080
printf '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}\n' | php vendor/bin/nene-mcp
```

## 次のステップ

- [Cursor / MCP 設定](/ja/tutorial/cursor-setup)
- [NeNe 連携](/ja/howto/integrate-nene)
- [環境変数](/ja/reference/environment-variables)
