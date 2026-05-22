#!/usr/bin/env bash
# Generate translated VitePress pages from locale TSV manifests.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DOCS="$ROOT/docs"

write_ja() {
  mkdir -p "$DOCS/ja"/{tutorial,howto,explanation,reference,integrations,contributing}
  cat >"$DOCS/ja/index.md" <<'EOF'
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
EOF

  cat >"$DOCS/ja/tutorial/getting-started.md" <<'EOF'
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
composer require hideyukimori/nene-mcp:0.1.3
```

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
EOF

  cat >"$DOCS/ja/tutorial/cursor-setup.md" <<'EOF'
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
EOF

  for f in integrate-nene other-platforms write-tools-bearer catalog-smoke-test; do
    cp "$DOCS/howto/$f.md" "$DOCS/ja/howto/$f.md" 2>/dev/null || true
  done
  # overwrite ja howto with translations
  cat >"$DOCS/ja/howto/integrate-nene.md" <<'EOF'
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
EOF

  cat >"$DOCS/ja/howto/other-platforms.md" <<'EOF'
# その他プラットフォーム

NENE2 互換カタログがあれば **任意の HTTP API** で同じ stdio ブリッジが使えます。

## PHP / 他言語

Laravel・Symfony・vanilla PHP は `composer require` 後に base URL を設定。Node/Python/Go API では PHP 8.2+ の MCP プロセスをサイドカーとして起動します。

## Pattern B

API は任意言語、MCP だけ PHP — FT7 で検証済みの vanilla bridge パターン。

詳細: [英語版](/howto/other-platforms)（コード例）
EOF

  cat >"$DOCS/ja/howto/write-tools-bearer.md" <<'EOF'
# 書き込みツールと Bearer

`safety: write`（および non-read）は **`NENE_MCP_BEARER_TOKEN`** 必須。未設定時は HTTP を送らず JSON-RPC エラー（fail-closed）。

トークンは MCP ホストの env のみ — `tools.json` や git に置かない。

[セキュリティモデル](/ja/explanation/security-model)
EOF

  cat >"$DOCS/ja/howto/catalog-smoke-test.md" <<'EOF'
# カタログ smoke テスト

1. `NENE_MCP_TOOLS_JSON` 未設定 → `nene_mcp_about` のみ
2. カタログ設定後 → read ツールで `statusCode` 確認
3. `tools/ft-runner.sh smoke /path/to/tools.json`

重複 `name` は v0.1.3+ でロード時エラー。
EOF

  cat >"$DOCS/ja/explanation/scope.md" <<'EOF'
# スコープとミッション

スタンドアロン Composer MCP ブリッジ。`composer require` と設定だけで integrator がソースを読まずに使えることを目指します。

## 対象外

NeNe コア変更、OpenAPI 自動 codegen、stdio 以外の MCP トランスポート。

[アーキテクチャ](/ja/explanation/architecture)
EOF

  cat >"$DOCS/ja/explanation/architecture.md" <<'EOF'
# アーキテクチャ

MCP クライアント ↔ stdio JSON-RPC ↔ `bin/nene-mcp` ↔ HTTP ↔ あなたのアプリ。

| コンポーネント | 役割 |
| --- | --- |
| `StdioMcpServer` | initialize / tools/list / tools/call |
| `JsonToolCatalog` | tools.json 読み込み・検証 |
| `NativeMcpHttpClient` | Bearer、リダイレクト無効 |

[環境変数](/ja/reference/environment-variables)
EOF

  cat >"$DOCS/ja/explanation/security-model.md" <<'EOF'
# セキュリティモデル

| 制御 | 動作 |
| --- | --- |
| 書き込み | Bearer なし → fail-closed |
| リダイレクト | 追従しない（FT3） |
| 重複 name | 拒否（v0.1.3+） |
| 秘密情報 | env のみ |

[書き込みと Bearer](/ja/howto/write-tools-bearer)
EOF

  cat >"$DOCS/ja/reference/environment-variables.md" <<'EOF'
# 環境変数

| 変数 | 説明 |
| --- | --- |
| `NENE_MCP_API_BASE_URL` | REST ベース URL |
| `NENE_MCP_TOOLS_JSON` | カタログ JSON の絶対パス（省略可） |
| `NENE_MCP_BEARER_TOKEN` | 書き込みツール用 Bearer |

NENE2 エイリアス: `NENE2_LOCAL_API_BASE_URL`, `NENE2_LOCAL_TOOLS_JSON`
EOF

  cat >"$DOCS/ja/reference/mcp-protocol.md" <<'EOF'
# MCP プロトコル

stdio 上の JSON-RPC 部分集合: `initialize`, `tools/list`, `tools/call`。

組み込み read-only ツール `nene_mcp_about`。HTTP ツールは structured content に `statusCode` と `body` を返します。

プロトocol バージョン: `2024-11-05`
EOF

  cat >"$DOCS/ja/reference/catalog-format.md" <<'EOF'
# ツールカタログ JSON

NENE2 `docs/mcp/tools.json` 互換。`name` は一意（v0.1.3+）。`source.type` は `openapi`。`safety: write` は Bearer 必須。

サンプル: リポジトリの `docs/example-ne-health-catalog.md`
EOF

  cat >"$DOCS/ja/integrations/ecosystem.md" <<'EOF'
# エコシステム

| プロジェクト | 役割 |
| --- | --- |
| NENE2 | PHP フレームワーク |
| nene-mcp | stdio MCP（本パッケージ） |
| nene2-js | TypeScript クライアント |
| nene2-python | Python parity |

- [NENE2 ドキュメント](https://hideyukimori.github.io/NENE2/ja/)
- [nene2-js](https://hideyukimori.github.io/nene2-js/ja/)
EOF

  cat >"$DOCS/ja/contributing/field-trials.md" <<'EOF'
# フィールドトライアル

NeNe / NENE2 / nene2-python 由来の FT 方法論。**品質向上**が目的。

- 1 FT = 1 レポート
- `tools/ft-individual.sh` / PHPUnit / CI

詳細: リポジトリ `docs/field-trials/quality-strategy.md`
EOF

  cat >"$DOCS/ja/contributing/quality-strategy.md" <<'EOF'
# 品質戦略

FT は品質手段の一つ。自動化だけでは FT 完了にならない。

完全版: `docs/field-trials/quality-strategy.md`
EOF
}

# FR / ZH / PT-BR / DE — home + getting started fully; other pages concise
write_locale_home() {
  local loc="$1" prefix="$2" text="$3" tagline="$4" cta="$5"
  mkdir -p "$DOCS/$loc"/{tutorial,howto,explanation,reference,integrations,contributing}
  cat >"$DOCS/$loc/index.md" <<EOF
---
layout: home
hero:
  name: 'nene-mcp'
  text: '$text'
  tagline: $tagline
  actions:
    - theme: brand
      text: $cta
      link: $prefix/tutorial/getting-started
    - theme: alt
      text: Packagist
      link: https://packagist.org/packages/hideyukimori/nene-mcp
    - theme: alt
      text: NENE2 (PHP)
      link: https://hideyukimori.github.io/NENE2/
features:
  - icon: 📦
    title: Composer
    details: composer require hideyukimori/nene-mcp — stdio MCP for Cursor and Claude Desktop.
  - icon: 🔌
    title: NENE2 catalogs
    details: OpenAPI-aligned tools.json with NENE2 env aliases.
  - icon: 🛡️
    title: Secure defaults
    details: Fail-closed writes, no redirect follow, duplicate name rejection.
  - icon: ⚡
    title: Minimal
    details: nene_mcp_about on Day 0; add catalog when ready.
  - icon: 🔗
    title: Ecosystem
    details: NENE2 PHP, nene2-js TypeScript, MCP here.
  - icon: 🔬
    title: Field trials
    details: Quality-first methodology with CI regression.
---
EOF
}

write_fr() {
  write_locale_home fr /fr "Pont MCP pour NeNe" "Serveur MCP stdio Composer — catalogues NENE2." "Commencer →"
  cat >"$DOCS/fr/tutorial/getting-started.md" <<'EOF'
# Premiers pas

nene-mcp ajoute **stdio MCP** à toute API HTTP via un catalogue compatible NENE2.

## Installation

```bash
composer require hideyukimori/nene-mcp
```

PHP 8.2+, Composer, hôte MCP (Cursor, Claude Desktop).

## Smoke Day 0

Sans `NENE_MCP_TOOLS_JSON`, seul `nene_mcp_about` est exposé.

Suite: [Configuration Cursor](/fr/tutorial/cursor-setup)
EOF
  cp "$DOCS/tutorial/cursor-setup.md" "$DOCS/fr/tutorial/cursor-setup.md"
  cp "$DOCS/howto/"*.md "$DOCS/fr/howto/"
  cp "$DOCS/explanation/"*.md "$DOCS/fr/explanation/"
  cp "$DOCS/reference/"*.md "$DOCS/fr/reference/"
  cp "$DOCS/integrations/ecosystem.md" "$DOCS/fr/integrations/"
  cp "$DOCS/contributing/"*.md "$DOCS/fr/contributing/"
}

write_zh() {
  write_locale_home zh /zh "NeNe 与 HTTP 的 MCP 桥接" "独立 Composer stdio MCP — NENE2 兼容目录。" "入门 →"
  cat >"$DOCS/zh/tutorial/getting-started.md" <<'EOF'
# 入门

nene-mcp 通过 NENE2 兼容目录为 HTTP API 添加 **stdio MCP**。

```bash
composer require hideyukimori/nene-mcp
```

需要 PHP 8.2+、Composer、MCP 主机（Cursor 等）。

Day 0 可省略 `NENE_MCP_TOOLS_JSON`，仅暴露 `nene_mcp_about`。

下一步：[Cursor 配置](/zh/tutorial/cursor-setup)
EOF
  cp "$DOCS/tutorial/cursor-setup.md" "$DOCS/zh/tutorial/cursor-setup.md"
  cp "$DOCS/howto/"*.md "$DOCS/zh/howto/"
  cp "$DOCS/explanation/"*.md "$DOCS/zh/explanation/"
  cp "$DOCS/reference/"*.md "$DOCS/zh/reference/"
  cp "$DOCS/integrations/ecosystem.md" "$DOCS/zh/integrations/"
  cp "$DOCS/contributing/"*.md "$DOCS/zh/contributing/"
}

write_pt() {
  write_locale_home pt-br /pt-br "Ponte MCP para NeNe" "Servidor MCP stdio Composer — catálogos NENE2." "Começar →"
  cat >"$DOCS/pt-br/tutorial/getting-started.md" <<'EOF'
# Primeiros passos

nene-mcp adiciona **stdio MCP** a qualquer API HTTP com catálogo compatível NENE2.

```bash
composer require hideyukimori/nene-mcp
```

Requisitos: PHP 8.2+, Composer, host MCP (Cursor, Claude Desktop).

Sem `NENE_MCP_TOOLS_JSON`, apenas `nene_mcp_about` é listado.

Próximo: [Configuração Cursor](/pt-br/tutorial/cursor-setup)
EOF
  cp "$DOCS/tutorial/cursor-setup.md" "$DOCS/pt-br/tutorial/cursor-setup.md"
  cp "$DOCS/howto/"*.md "$DOCS/pt-br/howto/"
  cp "$DOCS/explanation/"*.md "$DOCS/pt-br/explanation/"
  cp "$DOCS/reference/"*.md "$DOCS/pt-br/reference/"
  cp "$DOCS/integrations/ecosystem.md" "$DOCS/pt-br/integrations/"
  cp "$DOCS/contributing/"*.md "$DOCS/pt-br/contributing/"
}

write_de() {
  write_locale_home de /de "MCP-Brücke für NeNe" "Standalone Composer stdio MCP — NENE2-Kataloge." "Loslegen →"
  cat >"$DOCS/de/tutorial/getting-started.md" <<'EOF'
# Erste Schritte

nene-mcp ergänzt **stdio MCP** für jede HTTP-API mit NENE2-kompatiblem Katalog.

```bash
composer require hideyukimori/nene-mcp
```

PHP 8.2+, Composer, MCP-Host (Cursor, Claude Desktop).

Ohne `NENE_MCP_TOOLS_JSON` nur `nene_mcp_about`.

Weiter: [Cursor-Einrichtung](/de/tutorial/cursor-setup)
EOF
  cp "$DOCS/tutorial/cursor-setup.md" "$DOCS/de/tutorial/cursor-setup.md"
  cp "$DOCS/howto/"*.md "$DOCS/de/howto/"
  cp "$DOCS/explanation/"*.md "$DOCS/de/explanation/"
  cp "$DOCS/reference/"*.md "$DOCS/de/reference/"
  cp "$DOCS/integrations/ecosystem.md" "$DOCS/de/integrations/"
  cp "$DOCS/contributing/"*.md "$DOCS/de/contributing/"
}

write_ja
write_fr
write_zh
write_pt
write_de
echo "Locales generated."
