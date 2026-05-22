# Field Trial 8 — Packagist-only install regression

## Date

2026-05-22

## Baseline

- nene-mcp ref: `v0.1.2` via Packagist only

## Goal

Validate G1 — no VCS stanza in fresh directory.

## Results

`tools/ft-runner.sh packagist` → install + about-only pass.

No friction. G1 regression clean.

## Follow-up Issues

None.
