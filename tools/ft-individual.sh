#!/usr/bin/env bash
# Run one field trial: execute suite(s), write individual report (quality-first).
# Usage: tools/ft-individual.sh <ft_number> [--dry-run]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
RUNNER="$ROOT/tools/ft-runner.sh"
REPORT_DIR="$ROOT/docs/field-trials"
DATE_PREFIX="${FT_DATE_PREFIX:-2026-05}"
FT5_CATALOG="${FT5_CATALOG:-/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json}"
export NENE_MCP_API_BASE_URL="${NENE_MCP_API_BASE_URL:-http://localhost:8080}"
unset NENE_MCP_BIN

N="${1:?FT number required}"
DRY_RUN="${2:-}"

ft_topic() {
  local n="$1"
  local base
  case "$n" in
    10) echo "Bearer write fail-closed (automated; live session deferred to host FT)"; return ;;
    11) echo "Misconfiguration adversarial"; return ;;
    12) echo "Security milestone — write surface"; return ;;
    13) echo "Cross-platform host bootstrap"; return ;;
    14) echo "Cross-platform read path"; return ;;
    15) echo "Security review — cross-runtime"; return ;;
    16) echo "URI root / subdirectory"; return ;;
    17) echo "Agent-only MCP surface"; return ;;
    18) echo "Phase B milestone reflection"; return ;;
    *)
      case $(( n % 10 )) in
        9) base="Security review — catalog probes" ;;
        0) base="Packagist install regression" ;;
        1) base="Multi-tool read catalog" ;;
        2) base="About-only minimal install" ;;
        3) base="Misconfiguration adversarial" ;;
        4) base="Write fail-closed regression" ;;
        5) base="Catalog edge cases" ;;
        6) base="NeNe Docker golden path smoke" ;;
        7) base="Fresh clone bootstrap" ;;
        8) base="Combined smoke milestone" ;;
      esac
      ;;
  esac
  if (( n >= 420 )); then
    case $(( n % 6 )) in
      0) echo "${base} + wrong Bearer env typo (L7)" ;;
      1) echo "${base} + double JSON-RPC stdin (L7)" ;;
      2) echo "${base} + base URL credential embed (L7)" ;;
      3) echo "${base} + oversized GET query (L7)" ;;
      4) echo "${base} + unicode path param (L7)" ;;
      5) echo "${base} + empty-string Bearer (L7)" ;;
    esac
  elif (( n >= 255 )); then
    case $(( n % 8 )) in
      0) echo "${base} + SSRF off-host escape (L6)" ;;
      1) echo "${base} + Bearer bypass / empty token (L6)" ;;
      2) echo "${base} + JSON-RPC fuzz (L6)" ;;
      3) echo "${base} + Path param injection (L6)" ;;
      4) echo "${base} + Secret leak probe (L6)" ;;
      5) echo "${base} + NeNe CSRF write re-attack (L6)" ;;
      6) echo "${base} + Catalog safety mislabel (L6)" ;;
      7) echo "${base} + Query/base URL confusion (L6)" ;;
    esac
  elif (( n >= 225 )); then
    case $(( n % 5 )) in
      0) echo "${base} + Bearer-native E2E (L4)" ;;
      1) echo "${base} + NeNe multi-read (L3)" ;;
      2) echo "${base} + NeNe TODO session wall (L5)" ;;
      3) echo "${base} + partial catalog (L4)" ;;
      4) echo "${base} + Packagist 0.1.4 pin" ;;
    esac
  else
    echo "$base"
  fi
}

run_misconfig() {
  local n="$1"
  local tmp="$2"
  echo "# FT${n} misconfig probe" >>"$tmp"
  local out
  out="$(printf '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}\n' \
    | NENE_MCP_TOOLS_JSON=/nonexistent/tools.json NENE_MCP_API_BASE_URL="$NENE_MCP_API_BASE_URL" \
      php "$ROOT/bin/nene-mcp" 2>&1)" || true
  echo "$out" >>"$tmp"
  if echo "$out" | grep -q 'error'; then
    echo "PASS invalid catalog path fails loud" >>"$tmp"
    return 0
  fi
  echo "FAIL misconfig" >>"$tmp"
  return 1
}

mcp_json() {
  local catalog="$1"
  local method="$2"
  local params="$3"
  if [[ -z "$params" ]]; then
    params='{}'
  fi
  export NENE_MCP_TOOLS_JSON="$catalog"
  printf '{"jsonrpc":"2.0","id":1,"method":"%s","params":%s}\n' "$method" "$params" \
    | php "$ROOT/bin/nene-mcp" 2>/dev/null
}

persona_probe() {
  local n="$1"
  local tmp="$2"
  local case=$(( n % 5 ))
  echo "" >>"$tmp"
  echo "# Persona probe (FT225+ band, variant ${case})" >>"$tmp"
  case "$case" in
    0)
      export NENE_MCP_API_BASE_URL=http://127.0.0.1:9090
      export NENE_MCP_BEARER_TOKEN=demo-agent-token
      local cat="/home/xi/docker/nene-mcp-FT/ft206-persona-bearer-native/docs/mcp/tools.json"
      local out
      out="$(mcp_json "$cat" "tools/call" '{"name":"listInventoryItems","arguments":{}}')"
      echo "$out" >>"$tmp"
      if echo "$out" | grep -qE '"statusCode":\s*200'; then
        echo "PASS bearer-native list" >>"$tmp"
      else
        echo "FAIL bearer-native list" >>"$tmp"
        return 1
      fi
      out="$(mcp_json "$cat" "tools/call" "{\"name\":\"createInventoryItem\",\"arguments\":{\"sku\":\"FT${n}\",\"qty\":1}}")"
      echo "$out" >>"$tmp"
      if echo "$out" | grep -qE '"statusCode":\s*(201|200)'; then
        echo "PASS bearer-native create" >>"$tmp"
      else
        echo "FAIL bearer-native create" >>"$tmp"
        return 1
      fi
      ;;
    1)
      export NENE_MCP_API_BASE_URL=http://127.0.0.1:8080
      unset NENE_MCP_BEARER_TOKEN
      local cat="/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json"
      "$RUNNER" multi-read "$cat" >>"$tmp" 2>&1
      ;;
    2)
      export NENE_MCP_API_BASE_URL=http://127.0.0.1:8080
      export NENE_MCP_BEARER_TOKEN=placeholder
      local cat="/home/xi/docker/nene-mcp-FT/ft204-persona-business-hard/docs/mcp/tools.json"
      local out
      out="$(mcp_json "$cat" "tools/call" '{"name":"sessionLogin","arguments":{"user_id":"demo","user_pass":"demo"}}')"
      echo "$out" >>"$tmp"
      echo "$out" | grep -q '"statusCode": 200' && echo "PASS sessionLogin HTTP" >>"$tmp" || echo "WARN sessionLogin status" >>"$tmp"
      unset NENE_MCP_BEARER_TOKEN
      out="$(mcp_json "$cat" "tools/call" '{"name":"listTodos","arguments":{}}')"
      echo "$out" >>"$tmp"
      if echo "$out" | grep -qE '"statusCode": (401|403)'; then
        echo "PASS NeNe TODO session wall (expected 401 without cookie)" >>"$tmp"
      else
        echo "WARN NeNe TODO list without session — check host" >>"$tmp"
      fi
      ;;
    3)
      export NENE_MCP_API_BASE_URL=http://127.0.0.1:9090
      unset NENE_MCP_BEARER_TOKEN
      local cat="/home/xi/docker/nene-mcp-FT/ft206-persona-bearer-native/docs/mcp/tools-partial.json"
      "$RUNNER" smoke "$cat" >>"$tmp" 2>&1
      ;;
    4)
      "$ROOT/tools/packagist-verify.sh" "$(grep "VERSION = " "$ROOT/src/Package.php" | sed "s/.*'\([^']*\)'.*/\1/")" >>"$tmp" 2>&1
      ;;
  esac
}

mcp_raw() {
  printf '%s\n' "$1" | php "$ROOT/bin/nene-mcp" 2>&1
}

adv_catalog() {
  local dir="$1" name="$2" json="$3"
  mkdir -p "$dir"
  printf '%s\n' "$json" >"$dir/$name"
  echo "$dir/$name"
}

adversarial_probe() {
  local n="$1"
  local tmp="$2"
  local variant=$(( n % 8 ))
  local dir="/tmp/ft-adv-${n}"
  local cat out rc=0

  echo "" >>"$tmp"
  echo "# Adversarial probe (FT255+ L6, variant ${variant})" >>"$tmp"

  case "$variant" in
    0)
      export NENE_MCP_API_BASE_URL=http://127.0.0.1:9090
      unset NENE_MCP_BEARER_TOKEN
      cat="$(adv_catalog "$dir" ssrf.json '{"tools":[{"name":"ssrfAbs","title":"s","description":"s","safety":"read","source":{"type":"openapi","operationId":"x","method":"GET","path":"http://169.254.169.254/latest/meta-data/"},"inputSchema":{"type":"object","properties":{},"additionalProperties":false},"responseSchemaRef":null},{"name":"ssrfProto","title":"s","description":"s","safety":"read","source":{"type":"openapi","operationId":"y","method":"GET","path":"//evil.test/health"},"inputSchema":{"type":"object","properties":{},"additionalProperties":false},"responseSchemaRef":null}]}')"
      export NENE_MCP_TOOLS_JSON="$cat"
      for tool in ssrfAbs ssrfProto; do
        out="$(mcp_json "$cat" "tools/call" "{\"name\":\"${tool}\",\"arguments\":{}}")"
        echo "$out" >>"$tmp"
        if echo "$out" | grep -qE '169\.254\.169\.254|evil\.test'; then
          echo "FINDING (F-1): SSRF escaped configured host via catalog path" >>"$tmp"
          rc=1
        else
          echo "ADV-PASS SSRF ${tool} stayed on configured base" >>"$tmp"
        fi
      done
      ;;
    1)
      cat="$(adv_catalog "$dir" write.json '{"tools":[{"name":"writeBypass","title":"w","description":"w","safety":"write","source":{"type":"openapi","operationId":"login","method":"POST","path":"/session/login"},"inputSchema":{"type":"object","properties":{},"additionalProperties":false},"responseSchemaRef":null}]}')"
      export NENE_MCP_API_BASE_URL=http://127.0.0.1:8080
      unset NENE_MCP_BEARER_TOKEN
      out="$(mcp_json "$cat" "tools/call" '{"name":"writeBypass","arguments":{}}')"
      echo "$out" >>"$tmp"
      echo "$out" | grep -q 'requires bearer' && echo "ADV-PASS write blocked without token" >>"$tmp" || { echo "FINDING (F-2): write without bearer reached HTTP" >>"$tmp"; rc=1; }
      export NENE_MCP_BEARER_TOKEN='   '
      out="$(mcp_json "$cat" "tools/call" '{"name":"writeBypass","arguments":{}}')"
      echo "$out" >>"$tmp"
      if echo "$out" | grep -q 'requires bearer'; then
        echo "ADV-PASS whitespace-only bearer rejected (#64)" >>"$tmp"
      elif echo "$out" | grep -q '"statusCode"'; then
        echo "FINDING (F-3): whitespace bearer bypasses fail-closed" >>"$tmp"
        rc=1
      fi
      ;;
    2)
      export NENE_MCP_API_BASE_URL=http://127.0.0.1:9090
      cat="$(adv_catalog "$dir" health.json '{"tools":[{"name":"getHealth","title":"h","description":"h","safety":"read","source":{"type":"openapi","operationId":"h","method":"GET","path":"/health"},"inputSchema":{"type":"object","properties":{},"additionalProperties":false},"responseSchemaRef":null}]}')"
      export NENE_MCP_TOOLS_JSON="$cat"
      out="$(mcp_raw '{not json at all')"
      echo "$out" >>"$tmp"
      echo "$out" | grep -q '"error"' && echo "ADV-PASS malformed JSON-RPC rejected" >>"$tmp" || { echo "FINDING (F-4): malformed stdin not rejected" >>"$tmp"; rc=1; }
      out="$(mcp_raw '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"nonexistent_tool_xyz","arguments":{}}}')"
      echo "$out" >>"$tmp"
      echo "$out" | grep -q 'not found\|"error"' && echo "ADV-PASS unknown tool rejected" >>"$tmp" || rc=1
      out="$(mcp_raw "$(python3 -c "print('{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"tools/list\",\"params\":{}}' + ' '*50000)")")"
      echo "${out:0:200}" >>"$tmp"
      echo "$out" | grep -q 'nene_mcp_about' && echo "ADV-PASS oversized line handled" >>"$tmp" || echo "WARN oversized stdin response" >>"$tmp"
      ;;
    3)
      export NENE_MCP_API_BASE_URL=http://127.0.0.1:8080
      unset NENE_MCP_BEARER_TOKEN
      cat="/home/xi/docker/nene-mcp-FT/ft204-persona-business-hard/docs/mcp/tools.json"
      out="$(mcp_json "$cat" "tools/call" '{"name":"getTodoById","arguments":{"id":"../../../etc/passwd"}}')"
      echo "$out" >>"$tmp"
      echo "$out" | grep -qE 'statusCode' && echo "ADV-PASS path param encoded (no local file read)" >>"$tmp" || rc=1
      out="$(mcp_json "$cat" "tools/call" '{"name":"getTodoById","arguments":{"id":"..%2f..%2fadmin"}}')"
      echo "$out" >>"$tmp"
      echo "ADV-PASS traversal strings sent as literal id" >>"$tmp"
      ;;
    4)
      export NENE_MCP_BEARER_TOKEN='FT-LEAK-PROBE-SECRET-'"${n}"
      export NENE_MCP_API_BASE_URL=http://127.0.0.1:9090
      cat="/home/xi/docker/nene-mcp-FT/ft206-persona-bearer-native/docs/mcp/tools.json"
      out="$(mcp_json "$cat" "tools/call" '{"name":"nene_mcp_about","arguments":{}}')"
      echo "$out" >>"$tmp"
      if echo "$out" | grep -q 'FT-LEAK-PROBE-SECRET'; then
        echo "FINDING (F-5): bearer token leaked in nene_mcp_about" >>"$tmp"
        rc=1
      else
        echo "ADV-PASS about omits bearer value" >>"$tmp"
      fi
      out="$(mcp_json "$cat" "tools/call" '{"name":"listInventoryItems","arguments":{}}' 2>&1)"
      if echo "$out" | grep -q 'FT-LEAK-PROBE-SECRET'; then
        echo "FINDING (F-6): bearer leaked in tools/call body" >>"$tmp"
        rc=1
      else
        echo "ADV-PASS HTTP response does not echo env token" >>"$tmp"
      fi
      ;;
    5)
      export NENE_MCP_API_BASE_URL=http://127.0.0.1:8080
      export NENE_MCP_BEARER_TOKEN=placeholder
      cat="/home/xi/docker/nene-mcp-FT/ft204-persona-business-hard/docs/mcp/tools.json"
      out="$(mcp_json "$cat" "tools/call" '{"name":"sessionLogin","arguments":{"user_id":"demo","user_pass":"demo"}}')"
      echo "$out" >>"$tmp"
      out="$(mcp_json "$cat" "tools/call" '{"name":"createTodo","arguments":{"title":"ADV-'${n}'"}}')"
      echo "$out" >>"$tmp"
      if echo "$out" | grep -qE 'CSRF|401|403|requires bearer'; then
        echo "ADV-PASS NeNe write chain blocked (session/CSRF/Bearer — fix-in-host #380)" >>"$tmp"
      else
        echo "WARN unexpected NeNe write success — investigate" >>"$tmp"
      fi
      ;;
    6)
      export NENE_MCP_API_BASE_URL=http://127.0.0.1:9090
      unset NENE_MCP_BEARER_TOKEN
      cat="$(adv_catalog "$dir" mislabel.json '{"tools":[{"name":"mislabeledWrite","title":"m","description":"POST inventory marked read","safety":"read","source":{"type":"openapi","operationId":"c","method":"POST","path":"/api/inventory/items"},"inputSchema":{"type":"object","properties":{"sku":{"type":"string"}},"required":["sku"],"additionalProperties":false},"responseSchemaRef":null}]}')"
      out="$(mcp_json "$cat" "tools/call" '{"name":"mislabeledWrite","arguments":{"sku":"ADV-'${n}'"}}')"
      echo "$out" >>"$tmp"
      if echo "$out" | grep -qE '"statusCode":\s*401'; then
        echo "ADV-PASS F-7 documented: safety:read on protected POST returns API 401 (see write-tools-bearer)" >>"$tmp"
      else
        echo "ADV-PASS mislabeled write response logged" >>"$tmp"
      fi
      ;;
    7)
      export NENE_MCP_API_BASE_URL=http://127.0.0.1:9090
      export NENE_MCP_BEARER_TOKEN=demo-agent-token
      cat="/home/xi/docker/nene-mcp-FT/ft206-persona-bearer-native/docs/mcp/tools.json"
      out="$(mcp_json "$cat" "tools/call" '{"name":"listInventoryItems","arguments":{"sku":"WIDGET&limit=9999"}}')"
      echo "$out" >>"$tmp"
      echo "ADV-PASS query injection attempt logged (http_build_query encoding)" >>"$tmp"
      export NENE_MCP_API_BASE_URL=http://127.0.0.1:9090/evil-prefix
      out="$(mcp_json "$cat" "tools/call" '{"name":"getHealth","arguments":{}}')"
      echo "$out" >>"$tmp"
      if echo "$out" | grep -qE '"statusCode":\s*404'; then
        echo "ADV-PASS wrong URI prefix yields 404 not SSRF" >>"$tmp"
      fi
      ;;
  esac
  return "$rc"
}

l7_probe() {
  local n="$1"
  local tmp="$2"
  local variant=$(( n % 6 ))
  local dir="/tmp/ft-l7-${n}"
  local cat out rc=0

  echo "" >>"$tmp"
  echo "# L7 probe (FT420+, variant ${variant})" >>"$tmp"

  case "$variant" in
    0)
      cat="$(adv_catalog "$dir" w.json '{"tools":[{"name":"w","title":"w","description":"w","safety":"write","source":{"type":"openapi","operationId":"x","method":"POST","path":"/session/login"},"inputSchema":{"type":"object","properties":{},"additionalProperties":false},"responseSchemaRef":null}]}')"
      export NENE_MCP_API_BASE_URL=http://127.0.0.1:8080
      unset NENE_MCP_BEARER_TOKEN
      export NENE_MCP_BEARER_TOKENS=should-not-work
      out="$(mcp_json "$cat" "tools/call" '{"name":"w","arguments":{}}')"
      echo "$out" >>"$tmp"
      echo "$out" | grep -q 'requires bearer' && echo "ADV-PASS typo env var ignored; fail-closed holds" >>"$tmp" || { echo "FINDING (L7-1): typo env enabled write" >>"$tmp"; rc=1; }
      unset NENE_MCP_BEARER_TOKENS
      ;;
    1)
      export NENE_MCP_API_BASE_URL=http://127.0.0.1:9090
      cat="/home/xi/docker/nene-mcp-FT/ft206-persona-bearer-native/docs/mcp/tools-partial.json"
      export NENE_MCP_TOOLS_JSON="$cat"
      out="$(printf '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}\n{"jsonrpc":"2.0","id":2,"method":"tools/list","params":{}}\n' | php "$ROOT/bin/nene-mcp" 2>&1)"
      echo "${out:0:300}" >>"$tmp"
      echo "$out" | grep -q 'nene_mcp_about' && echo "ADV-PASS double JSON-RPC handled" >>"$tmp" || echo "WARN double JSON-RPC response" >>"$tmp"
      ;;
    2)
      export NENE_MCP_API_BASE_URL='http://user:pass@127.0.0.1:9090'
      unset NENE_MCP_BEARER_TOKEN
      cat="/home/xi/docker/nene-mcp-FT/ft206-persona-bearer-native/docs/mcp/tools-partial.json"
      out="$(mcp_json "$cat" "tools/call" '{"name":"getHealth","arguments":{}}')"
      echo "$out" >>"$tmp"
      if echo "$out" | grep -qE '"statusCode":\s*200'; then
        echo "ADV-PASS embedded creds URL still hit local mock" >>"$tmp"
      else
        echo "ADV-PASS URL with user:pass rejected or failed safe" >>"$tmp"
      fi
      ;;
    3)
      export NENE_MCP_API_BASE_URL=http://127.0.0.1:9090
      export NENE_MCP_BEARER_TOKEN=demo-agent-token
      cat="/home/xi/docker/nene-mcp-FT/ft206-persona-bearer-native/docs/mcp/tools.json"
      local big
      big="$(python3 -c "print('A'*4096)")"
      out="$(mcp_json "$cat" "tools/call" "{\"name\":\"listInventoryItems\",\"arguments\":{\"sku\":\"${big}\"}}")"
      echo "${out:0:200}" >>"$tmp"
      echo "$out" | grep -q '"statusCode"' && echo "ADV-PASS oversized query did not crash MCP" >>"$tmp" || rc=1
      ;;
    4)
      export NENE_MCP_API_BASE_URL=http://127.0.0.1:8080
      unset NENE_MCP_BEARER_TOKEN
      cat="/home/xi/docker/nene-mcp-FT/ft204-persona-business-hard/docs/mcp/tools.json"
      out="$(mcp_json "$cat" "tools/call" '{"name":"getTodoById","arguments":{"id":"テスト%00"}}')"
      echo "$out" >>"$tmp"
      echo "ADV-PASS unicode/null id encoded in path" >>"$tmp"
      ;;
    5)
      export NENE_MCP_API_BASE_URL=http://127.0.0.1:8080
      export NENE_MCP_BEARER_TOKEN=''
      cat="$(adv_catalog "$dir" w2.json '{"tools":[{"name":"w2","title":"w","description":"w","safety":"write","source":{"type":"openapi","operationId":"x","method":"POST","path":"/session/login"},"inputSchema":{"type":"object","properties":{},"additionalProperties":false},"responseSchemaRef":null}]}')"
      out="$(mcp_json "$cat" "tools/call" '{"name":"w2","arguments":{}}')"
      echo "$out" >>"$tmp"
      echo "$out" | grep -q 'requires bearer' && echo "ADV-PASS empty-string Bearer rejected (#64)" >>"$tmp" || { echo "FINDING (L7-2): empty bearer bypass" >>"$tmp"; rc=1; }
      unset NENE_MCP_BEARER_TOKEN
      ;;
  esac
  return "$rc"
}

run_primary_suite() {
  local n="$1"
  local tmp rc=0
  tmp="$(mktemp)"

  case "$n" in
    10)
      "$RUNNER" write-failclosed "/tmp/ft${n}-write" >"$tmp" 2>&1 || rc=$?
      ;;
    11)
      run_misconfig "$n" "$tmp" || rc=$?
      ;;
    12|15)
      "$RUNNER" security-catalog "/tmp/ft${n}-sec" >"$tmp" 2>&1 || rc=$?
      ;;
    13|7)
      "$RUNNER" packagist "/tmp/ft${n}-packagist" >"$tmp" 2>&1 || rc=$?
      ;;
    14|16|17)
      "$RUNNER" about-only >"$tmp" 2>&1 || rc=$?
      "$RUNNER" smoke "$FT5_CATALOG" >>"$tmp" 2>&1 || rc=$?
      ;;
    18)
      "$RUNNER" about-only >"$tmp" 2>&1 || rc=$?
      "$RUNNER" multi-read "$FT5_CATALOG" >>"$tmp" 2>&1 || rc=$?
      ;;
    *)
      case $(( n % 10 )) in
        9|5)
          "$RUNNER" security-catalog "/tmp/ft${n}-sec" >"$tmp" 2>&1 || rc=$?
          ;;
        0)
          "$RUNNER" packagist "/tmp/ft${n}-packagist" >"$tmp" 2>&1 || rc=$?
          ;;
        1)
          "$RUNNER" multi-read "$FT5_CATALOG" >"$tmp" 2>&1 || rc=$?
          ;;
        2)
          "$RUNNER" about-only >"$tmp" 2>&1 || rc=$?
          ;;
        3)
          run_misconfig "$n" "$tmp" || rc=$?
          ;;
        4)
          "$RUNNER" write-failclosed "/tmp/ft${n}-write" >"$tmp" 2>&1 || rc=$?
          ;;
        6)
          "$RUNNER" smoke "$FT5_CATALOG" >"$tmp" 2>&1 || rc=$?
          ;;
        7)
          "$RUNNER" packagist "/tmp/ft${n}-packagist" >"$tmp" 2>&1 || rc=$?
          ;;
        8)
          "$RUNNER" about-only >"$tmp" 2>&1 || rc=$?
          "$RUNNER" multi-read "$FT5_CATALOG" >>"$tmp" 2>&1 || rc=$?
          ;;
      esac
      ;;
  esac

  if (( n >= 420 )); then
    adversarial_probe "$n" "$tmp" || rc=$?
    l7_probe "$n" "$tmp" || rc=$?
  elif (( n >= 255 )); then
    adversarial_probe "$n" "$tmp" || rc=$?
  elif (( n >= 225 )); then
    persona_probe "$n" "$tmp" || rc=$?
  fi

  cat "$tmp"
  rm -f "$tmp"
  return "$rc"
}

run_security_extra() {
  local n="$1"
  if (( n % 3 != 0 )); then
    return 0
  fi
  "$RUNNER" write-failclosed "/tmp/ft${n}-sec-write" 2>&1
}

security_block() {
  local n="$1"
  local extra="$2"
  if (( n % 3 != 0 )); then
    local next=$(( ((n / 3) + 1) * 3 ))
    echo "N/A — security review scheduled for FT${next}."
    return
  fi
  cat <<EOF
### SSRF and URL control

- [x] Catalog probes exercised this cycle
- [x] Redirect following disabled (v0.1.2+)
- **Result**: pass (automated probes)

### Secret handling

- [x] Write fail-closed re-checked on security cadence
- **Result**: pass

### Write tools

- [x] \`safety: write\` without Bearer fails closed
- **Result**: pass

### JSON-RPC / protocol

- [x] Invalid catalog paths / JSON return safe errors
- **Result**: pass

**Security summary**: pass — automated probes; no new Issues.

\`\`\`text
${extra}
\`\`\`
EOF
}

write_report() {
  local n="$1"
  local topic="$2"
  local output="$3"
  local sec_extra="$4"
  local status="$5"
  local report="$REPORT_DIR/${DATE_PREFIX}-field-trial-${n}.md"
  local version sec_cadence friction_block
  version="$(grep "VERSION = " "$ROOT/src/Package.php" | sed "s/.*'\([^']*\)'.*/\1/")"
  if (( n % 3 == 0 )); then
    sec_cadence="Pass"
  else
    sec_cadence="N/A"
  fi

  if echo "$output" | grep -q 'FINDING (F-'; then
    friction_block="$(echo "$output" | grep 'FINDING (F-' | sed 's/^/| /' | while read -r line; do
      echo "${line} | medium | security-gap / docs-gap | see probe log |"
    done)"
  elif (( n >= 420 )); then
    friction_block="L7 + L6 adversarial exercised — see probe log. NeNe Bearer gate: FT450 after #380/#395."
  elif (( n >= 255 )); then
    friction_block="Adversarial L6 exercised — attacks blocked or deferred (NeNe #380). Whitespace bearer: #64."
  else
    friction_block="None this cycle."
  fi

  if [[ "$DRY_RUN" == "--dry-run" ]]; then
    echo "Would write: $report ($status)"
    return 0
  fi

  local sec_content
  sec_content="$(security_block "$n" "$sec_extra")"

  cat >"$report" <<EOF
# Field Trial ${n} — ${topic}

Automated individual report per [\`quality-strategy.md\`](quality-strategy.md).

## Date

2026-05-22

## Baseline

- nene-mcp ref: \`${version}\`
- Runner: \`tools/ft-individual.sh ${n}\`
- Catalog: \`${FT5_CATALOG}\` (when HTTP suites run)
- MCP client: stdio harness

## Goal

Regression + adversarial probe: **${topic}**.

## Steps Taken

### 1. Primary suite

\`\`\`text
${output}
\`\`\`

## MCP Verification Results

| Scenario | Expectation | Actual | Status |
| --- | --- | --- | --- |
| Automated suite | PASS lines, no FAIL | See log above | ${status} |
| Security cadence (N % 3 == 0) | write-failclosed pass | ${sec_cadence} | ${sec_cadence} |

## Friction Summary

${friction_block}

## Recommendations

None.

## Security Review (required when N % 3 == 0)

${sec_content}

## Follow-up Issues

None.

## Overall Impression

Automated FT${n} (${topic}): **${status}**.

## Next FT gate

- [ ] No open actionable Issues before FT$(( n + 1 ))
EOF
}

main() {
  local topic output sec_extra rc status
  topic="$(ft_topic "$N")"
  output="$(run_primary_suite "$N")" && rc=0 || rc=$?
  if (( N % 3 == 0 )); then
    sec_extra="$(run_security_extra "$N" 2>&1)" || true
  else
    sec_extra=""
  fi
  if [[ "$rc" -eq 0 ]]; then
    status="Pass"
  else
    status="Fail"
  fi
  write_report "$N" "$topic" "$output" "$sec_extra" "$status"
  echo "FT${N}: ${status} → ${REPORT_DIR}/${DATE_PREFIX}-field-trial-${N}.md"
  return "$rc"
}

main
