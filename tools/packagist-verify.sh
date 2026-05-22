#!/usr/bin/env bash
# Verify hideyukimori/nene-mcp is installable from Packagist at the given version.
# Usage: tools/packagist-verify.sh [version]   (default: latest tag from Package.php)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
VERSION="${1:-$(grep "VERSION = " "$ROOT/src/Package.php" | sed "s/.*'\([^']*\)'.*/\1/")}"
DIR="$(mktemp -d)"
trap 'rm -rf "$DIR"' EXIT

echo "# Packagist verify: hideyukimori/nene-mcp:${VERSION}"

cd "$DIR"
composer init --name=ft/packagist-verify --no-interaction --quiet
composer require "hideyukimori/nene-mcp:${VERSION}" --no-interaction --quiet

INSTALLED="$(grep "VERSION = " vendor/hideyukimori/nene-mcp/src/Package.php | sed "s/.*'\([^']*\)'.*/\1/")"
echo "Installed package version: ${INSTALLED}"

if [[ "$INSTALLED" != "$VERSION" ]]; then
  echo "FAIL: expected ${VERSION}, got ${INSTALLED}" >&2
  exit 1
fi

php vendor/bin/nene-mcp >/dev/null 2>&1 || true
printf '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}\n' \
  | NENE_MCP_API_BASE_URL=http://localhost:8080 php vendor/bin/nene-mcp 2>/dev/null \
  | grep -q 'nene_mcp_about' && echo "PASS tools/list smoke" || { echo "FAIL tools/list"; exit 1; }

echo "PASS packagist verify ${VERSION}"
