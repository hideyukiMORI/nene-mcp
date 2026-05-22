# Field Trial 7 — Vanilla PHP bridge (Pattern B)

## Date

2026-05-22

## Baseline

- nene-mcp ref: `v0.1.2` (Packagist)
- FT path: `../nene-mcp-FT/ft7-vanilla-bridge/`
- Host API: NeNe Docker (external URL only)

## Goal

Separate Composer bridge directory pointing at NeNe HTTP API.

## Results

`composer require hideyukimori/nene-mcp:^0.1.2` + shared catalog → `ft-runner.sh smoke` pass.

No friction.

## Follow-up Issues

None.
