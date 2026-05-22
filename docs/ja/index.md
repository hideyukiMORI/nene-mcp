---
layout: home
hero:
  name: 'nene-mcp'
  text: 'NeNe & HTTP API 向け MCP ブリッジ'
  tagline: スタンドアロン Composer stdio MCP — NENE2 互換カタログ、書き込み fail-closed、Packagist 公開済み。
  actions:
    - theme: brand
      text: はじめる →
      link: /ja/tutorial/getting-started
    - theme: alt
      text: Packagist
      link: https://packagist.org/packages/hideyukimori/nene-mcp
    - theme: alt
      text: NENE2 (PHP)
      link: https://hideyukimori.github.io/NENE2/ja/
features:
  - icon: 📦
    title: Composer インストール
    details: composer require hideyukimori/nene-mcp — NeNe フォーク不要。vendor/bin/nene-mcp を Cursor 等が stdio で起動。
  - icon: 🔌
    title: NENE2 互換カタログ
    details: docs/mcp/tools.json で OpenAPI 操作を MCP ツールに映射。NENE2_LOCAL_* エイリアス対応。
  - icon: 🛡️
    title: 安全なデフォルト
    details: 書き込みツールは Bearer なしで fail-closed。リダイレクト追従なし。重複ツール名は拒否。
  - icon: ⚡
    title: 最小 surface
    details: Day-0 は nene_mcp_about のみ。カタログは HTTP ツールの準備ができてから。
  - icon: 🔗
    title: エコシステム
    details: PHP は NENE2/NeNe、TS クライアントは nene2-js、MCP はこのパッケージ。
  - icon: 🔬
    title: フィールドトライアル駆動
    details: 品質ファースト FT、個別レポート、PHPUnit、CI 回帰。
---
