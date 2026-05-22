# Changelog

All notable changes to this project will be documented in this file.

Format based on [Keep a Changelog](https://keepachangelog.com/).

## [Unreleased]

## 0.1.4 — 2026-05-22

Docs and regression release from persona field trials FT201–222.

### Added

- Docs site: NeNe catalog patterns (session cookie, CSRF, `id_{id}` paths, URI_ROOT); Bearer-native bridge example; persona band FT201–222 reports.
- PHPUnit: GET query-string args and NeNe-style `id_{id}` path interpolation regression tests (FT219).

### Changed

- Integration README and i18n locales aligned with auth model (no “NeNe session Bearer”); catalog-format query parameter documentation.

## 0.1.3 — 2026-05-22

Quality release from Field Trial 9 and FT6 follow-up #22.

### Added

- Reject duplicate tool `name` values when loading MCP catalog JSON (FT6 F-1 / #22).
- PHPUnit: catalog validation, write fail-closed, duplicate names via JSON-RPC.
- CI: `ft-runner.sh write-failclosed` and `security-catalog` after unit tests.
- Field Trial 9 individual report; [`quality-strategy.md`](docs/field-trials/quality-strategy.md).
- Integration docs: write tools + Bearer fail-closed.
- FT10–FT200 individual reports ([`index-ft10-200.md`](docs/field-trials/index-ft10-200.md)).
- `tools/ft-individual.sh`, `tools/ft-range.sh`, `tools/ft-milestone.sh`.
- Schedule FT100–FT200; G3/G5 milestone gates.

### Changed

- `ft-runner.sh` prefers in-repo `bin/nene-mcp` over stale `NENE_MCP_BIN` from FT clones.
- Milestone batch docs labeled regression-only; FT9+ individual reports required.

### Removed

- Misleading “FT9–100 complete via batch” framing in todo/index docs.

## 0.1.2 — 2026-05-22

Security patch from Field Trial 3.

### Fixed

- Disable HTTP redirect following in `NativeMcpHttpClient` to prevent internal SSRF when a trusted base URL returns redirects to other local ports (FT3 F-2).

### Added

- FT3 security review report (`docs/field-trials/2026-05-field-trial-3.md`)

## 0.1.1 — 2026-05-22

Post-FT1 documentation and FT2 golden-path learnings. No runtime code changes.

### Added

- Field trial schedule FT2–FT18 (`docs/field-trials/schedule.md`)
- Packagist setup guide (`docs/development/packagist-setup.md`)
- FT2 report: NeNe Docker + host MCP + Cursor config

### Changed

- Integration docs: port 8080 conflict note, host MCP vs Docker vendor split
- Adversarial / cross-repo FT policy in field-trial README and ADR 0001

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
