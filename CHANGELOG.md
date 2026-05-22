# Changelog

All notable changes to this project will be documented in this file.

Format based on [Keep a Changelog](https://keepachangelog.com/).

## [Unreleased]

## 0.1.0 — 2026-05-22

First integration-preview release. Baseline for field trial FT1.

### Added

- stdio MCP server (`bin/nene-mcp`): `initialize`, `tools/list`, `tools/call`
- Built-in read-only tool `nene_mcp_about`
- Optional NENE2-compatible `tools.json` catalog with HTTP proxy to documented REST APIs
- Environment variables `NENE_MCP_*` with `NENE2_LOCAL_*` aliases
- Bearer token support via `NENE_MCP_BEARER_TOKEN`
- PHPUnit suite and CI on PHP 8.2 / 8.4
- English documentation: NeNe integration, other platforms, governance, field trials
- Release and package policy (`docs/development/release-policy.md`)

### Notes

- `0.x` integration preview — not a long-term stability promise
- Install via VCS until Packagist publication after early field trials
