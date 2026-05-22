#!/usr/bin/env bash
# Field trial automation harness for nene-mcp stdio MCP smoke and security probes.
# Usage: tools/ft-runner.sh <suite> [args...]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
NENE_MCP_BIN="${NENE_MCP_BIN:-}"

resolve_bin() {
  if [[ -x "$ROOT/bin/nene-mcp" ]]; then
    echo "$ROOT/bin/nene-mcp"
    return
  fi
  if [[ -x "$ROOT/vendor/bin/nene-mcp" ]]; then
    echo "$ROOT/vendor/bin/nene-mcp"
    return
  fi
  if [[ -n "$NENE_MCP_BIN" && -x "$NENE_MCP_BIN" ]]; then
    echo "$NENE_MCP_BIN"
    return
  fi
  echo "nene-mcp binary not found. Set NENE_MCP_BIN or run composer install." >&2
  exit 1
}

mcp_call() {
  local catalog="$1"
  local method="$2"
  local params="${3:-\{\}}"
  export NENE_MCP_API_BASE_URL="${NENE_MCP_API_BASE_URL:-http://localhost:8080}"
  export NENE_MCP_TOOLS_JSON="$catalog"
  printf '{"jsonrpc":"2.0","id":1,"method":"%s","params":%s}\n' "$method" "$params" \
    | php "$(resolve_bin)" 2>/dev/null
}

mcp_tool_call() {
  local catalog="$1"
  local tool="$2"
  mcp_call "$catalog" "tools/call" "{\"name\":\"$tool\",\"arguments\":{}}"
}

suite_smoke() {
  local catalog="$1"
  echo "# FT smoke: $catalog"
  mcp_call "$catalog" "initialize" "{}" | grep -q 'nene-mcp' && echo "PASS initialize" || { echo "FAIL initialize"; return 1; }
  local list
  list="$(mcp_call "$catalog" "tools/list" "{}")"
  echo "$list" | grep -q 'nene_mcp_about' && echo "PASS tools/list about" || { echo "FAIL tools/list about"; return 1; }
  echo "$list" | python3 -c "import sys,json; d=json.load(sys.stdin); print('tools:', [t['name'] for t in d['result']['tools']])"
}

suite_multi_read() {
  local catalog="$1"
  suite_smoke "$catalog"
  for tool in getHealthCheck listTodos; do
    local out
    out="$(mcp_tool_call "$catalog" "$tool")"
    if echo "$out" | grep -q '"statusCode"'; then
      echo "PASS tools/call $tool (HTTP response returned)"
    else
      echo "FAIL tools/call $tool"
      echo "$out"
      return 1
    fi
  done
}

suite_security_catalog() {
  local dir="${1:-/tmp/ft6-catalogs}"
  mkdir -p "$dir"
  echo "# FT security catalog probes"

  echo '{"tools":[{"name":"dup","title":"a","description":"a","safety":"read","source":{"type":"openapi","operationId":"a","method":"GET","path":"/health/index"},"inputSchema":{"type":"object","properties":{},"additionalProperties":false},"responseSchemaRef":null},{"name":"dup","title":"b","description":"b","safety":"read","source":{"type":"openapi","operationId":"b","method":"GET","path":"/health/index"},"inputSchema":{"type":"object","properties":{},"additionalProperties":false},"responseSchemaRef":null}]}' > "$dir/dup.json"
  local out
  out="$(mcp_call "$dir/dup.json" "tools/list" "{}" 2>&1)" || true
  echo "$out" | grep -q 'duplicated' && echo "PASS duplicate names rejected" || { echo "FAIL duplicate names"; echo "$out"; return 1; }

  echo '{bad json' > "$dir/invalid.json"
  out="$(mcp_call "$dir/invalid.json" "tools/list" "{}" 2>&1)" || true
  echo "$out" | grep -q 'error' && echo "PASS invalid JSON rejected" || echo "WARN invalid JSON handling"

  echo '{"tools":[{"name":"bad","title":"x","description":"x","safety":"read","source":{"type":"openapi","operationId":"x","method":"GET","path":"http://evil.test/"},"inputSchema":{"type":"object","properties":{},"additionalProperties":false},"responseSchemaRef":null}]}' > "$dir/abs-path.json"
  out="$(mcp_tool_call "$dir/abs-path.json" "bad")"
  echo "$out" | head -c 200
  echo
}

suite_about_only() {
  export NENE_MCP_API_BASE_URL="${NENE_MCP_API_BASE_URL:-http://localhost:8080}"
  unset NENE_MCP_TOOLS_JSON
  printf '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}\n' | php "$(resolve_bin)" \
    | python3 -c "import sys,json; t=json.load(sys.stdin)['result']['tools']; assert len(t)==1 and t[0]['name']=='nene_mcp_about'; print('PASS about-only', t)"
}

suite_packagist() {
  local dir="${1:-/tmp/ft8-packagist}"
  rm -rf "$dir" && mkdir -p "$dir" && cd "$dir"
  curl -sS https://getcomposer.org/download/latest-stable/composer.phar -o composer.phar
  php composer.phar init --name=ft/packagist-smoke --no-interaction --quiet
  php composer.phar require hideyukimori/nene-mcp:^0.1 --no-interaction --quiet
  NENE_MCP_BIN="$dir/vendor/bin/nene-mcp" suite_about_only
}

suite_write_failclosed() {
  local dir="${1:-/tmp/ft9-write}"
  mkdir -p "$dir"
  echo '{"tools":[{"name":"writeProbe","title":"w","description":"w","safety":"write","source":{"type":"openapi","operationId":"login","method":"POST","path":"/session/login"},"inputSchema":{"type":"object","properties":{},"additionalProperties":false},"responseSchemaRef":null}]}' > "$dir/write.json"
  unset NENE_MCP_BEARER_TOKEN
  local out
  out="$(mcp_call "$dir/write.json" "tools/call" '{"name":"writeProbe","arguments":{}}')"
  echo "$out" | grep -q 'requires bearer' && echo "PASS write fail-closed" || { echo "FAIL write fail-closed"; echo "$out"; return 1; }
}

main() {
  local suite="${1:-help}"
  shift || true
  case "$suite" in
    smoke) suite_smoke "$@" ;;
    multi-read) suite_multi_read "$@" ;;
    security-catalog) suite_security_catalog "$@" ;;
    about-only) suite_about_only "$@" ;;
    packagist) suite_packagist "$@" ;;
    write-failclosed) suite_write_failclosed "$@" ;;
    help|*)
      echo "Usage: ft-runner.sh {smoke|multi-read|security-catalog|about-only|packagist|write-failclosed} [args]"
      ;;
  esac
}

main "$@"
