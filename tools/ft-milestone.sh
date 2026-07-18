#!/usr/bin/env bash
# Build milestone regression summary from ft-range summary TSV.
# Usage: tools/ft-milestone.sh <start> <end> <output_md>
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
START="${1:?start}"
END="${2:?end}"
OUT="${3:?output markdown path}"
SUMMARY="${FT_RANGE_SUMMARY:-/tmp/ft-range-${START}-${END}-summary.tsv}"

if [[ ! -f "$SUMMARY" ]]; then
  echo "Summary not found: $SUMMARY" >&2
  exit 1
fi

pass=$(tail -n +2 "$SUMMARY" | awk -F'\t' '$2=="pass"' | wc -l)
fail=$(tail -n +2 "$SUMMARY" | awk -F'\t' '$2=="fail"' | wc -l)
total=$(( pass + fail ))

cat >"$OUT" <<EOF
# Milestone batch — FT${START}–FT${END} (regression summary)

> **Not FT completion records.** Each FT has an individual report under the private mirror \`nene-origin/internal-docs/mcp/field-trials/2026-05-field-trial-{N}.md\`. This file aggregates pass/fail counts only.

## Date

2026-05-22

## Summary

| Metric | Count |
| --- | --- |
| Total | ${total} |
| Pass | ${pass} |
| Fail | ${fail} |

## Failures

EOF

if [[ "$fail" -eq 0 ]]; then
  echo "None." >>"$OUT"
else
  tail -n +2 "$SUMMARY" | awk -F'\t' '$2=="fail" {print "- FT" $1 ": " $3}' >>"$OUT"
fi

cat >>"$OUT" <<EOF

## Related

- [\`quality-strategy.md\`](../quality-strategy.md)
- [\`index-ft10-200.md\`](../index-ft10-200.md)
EOF

echo "Wrote $OUT (pass=${pass} fail=${fail})"
