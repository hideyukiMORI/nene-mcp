#!/usr/bin/env bash
# Run FT start..end with individual reports. Usage: tools/ft-range.sh <start> <end>
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
INDIV="$ROOT/tools/ft-individual.sh"
START="${1:?start FT}"
END="${2:?end FT}"
LOG="${FT_RANGE_LOG:-/tmp/ft-range-${START}-${END}.log}"
SUMMARY="${FT_RANGE_SUMMARY:-/tmp/ft-range-${START}-${END}-summary.tsv}"

: >"$LOG"
echo -e "ft\tstatus\treport" >"$SUMMARY"

pass=0
fail=0

for (( n=START; n<=END; n++ )); do
  echo "======== FT${n} $(date -Iseconds) ========" | tee -a "$LOG"
  if "$INDIV" "$n" >>"$LOG" 2>&1; then
    echo -e "${n}\tpass\t${ROOT}/docs/field-trials/2026-05-field-trial-${n}.md" >>"$SUMMARY"
    pass=$(( pass + 1 ))
  else
    echo -e "${n}\tfail\t${ROOT}/docs/field-trials/2026-05-field-trial-${n}.md" >>"$SUMMARY"
    fail=$(( fail + 1 ))
  fi
done

echo "Done FT${START}–FT${END}: pass=${pass} fail=${fail}"
echo "Log: $LOG"
echo "Summary: $SUMMARY"
