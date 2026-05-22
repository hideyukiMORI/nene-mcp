#!/usr/bin/env bash
# Run a batch of field trial automation suites and append results to a log.
# Usage: tools/ft-cycle.sh <start_ft> <end_ft>
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
RUNNER="$ROOT/tools/ft-runner.sh"
LOG="${FT_CYCLE_LOG:-/tmp/ft-cycle.log}"
START="${1:-5}"
END="${2:-100}"

export NENE_MCP_API_BASE_URL="${NENE_MCP_API_BASE_URL:-http://localhost:8080}"
unset NENE_MCP_BIN

FT5_CATALOG="${FT5_CATALOG:-/home/xi/docker/nene-mcp-FT/ft5-nene-multi-read/docs/mcp/tools.json}"

run_ft() {
  local n="$1"
  echo "======== FT$n $(date -Iseconds) ========" | tee -a "$LOG"
  case $(( n % 10 )) in
    9) "$RUNNER" security-catalog 2>&1 | tee -a "$LOG" || true ;;
    0) "$RUNNER" packagist 2>&1 | tee -a "$LOG" || true ;;
    1) "$RUNNER" multi-read "$FT5_CATALOG" 2>&1 | tee -a "$LOG" || true ;;
    2) "$RUNNER" about-only 2>&1 | tee -a "$LOG" || true ;;
    3) NENE_MCP_TOOLS_JSON=/nonexistent/tools.json "$RUNNER" smoke "$FT5_CATALOG" 2>&1 | tee -a "$LOG" || true ;;
    4) "$RUNNER" write-failclosed 2>&1 | tee -a "$LOG" || true ;;
    5) "$RUNNER" security-catalog 2>&1 | tee -a "$LOG" || true ;;
    6) "$RUNNER" smoke "$FT5_CATALOG" 2>&1 | tee -a "$LOG" || true ;;
    7) "$RUNNER" packagist 2>&1 | tee -a "$LOG" || true ;;
    8) "$RUNNER" about-only 2>&1 | tee -a "$LOG"; "$RUNNER" multi-read "$FT5_CATALOG" 2>&1 | tee -a "$LOG" || true ;;
  esac
  if (( n % 3 == 0 )); then
    "$RUNNER" write-failclosed 2>&1 | tee -a "$LOG" || true
  fi
}

: > "$LOG"
for (( n=START; n<=END; n++ )); do
  run_ft "$n"
done
echo "Done. Log: $LOG"
