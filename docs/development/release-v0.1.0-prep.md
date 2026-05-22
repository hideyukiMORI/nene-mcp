# v0.1.0 Release Preparation

This document records the **first tag candidate**. It does **not** create a tag by itself.

Policy: [`release-policy.md`](release-policy.md)  
Checklist: [`release-checklist.md`](release-checklist.md)

## Position

Tag **`v0.1.0`** before **FT1** so field trials share a stable Composer baseline. Packagist publication remains **after** early FTs (see release policy Phase B).

## Candidate scope (already on `main`)

Included in `v0.1.0`:

- stdio MCP server (`bin/nene-mcp`): `initialize`, `tools/list`, `tools/call`
- Built-in read-only `nene_mcp_about`
- Optional NENE2-compatible `tools.json` catalog + HTTP proxy
- Environment variables `NENE_MCP_*` and `NENE2_*` aliases
- PHPUnit suite (5 tests); CI on PHP 8.2 / 8.4
- English docs, governance, field trial methodology

Explicitly **not** in `v0.1.0 support promise:

- Packagist discoverability (VCS / path install during FT period)
- PHPStan / PHP-CS-Fixer (`composer check`)
- Field trial validation reports
- NeNe repo merge of cross-link PR (separate repo)

## Before tagging v0.1.0

1. Merge release policy docs (this preparation track).
2. Confirm `Package::VERSION === '0.1.0'` and `CHANGELOG.md` has `0.1.0` section.
3. Run [`release-checklist.md`](release-checklist.md).
4. Maintainer approval on the release Issue.
5. Create `v0.1.0` tag + GitHub Release from `main`.

## Composer consumption for FT1

After tag exists:

```bash
composer require hideyukimori/nene-mcp:0.1.0
```

With VCS repository block if Packagist is not yet live—record exact constraint in FT1 baseline.

## After v0.1.0

- Run **FT1** (NeNe + health catalog + Cursor); baseline `v0.1.0`.
- Patch findings as `v0.1.1`, `v0.1.2`, … per [`release-policy.md`](release-policy.md).
- Revisit Packagist after FT1 (and optionally FT2) Issues are closed.

## Non-goals

- Waiting for all planned FTs before any tag
- Publishing to Packagist in the same step as `v0.1.0` without FT baseline
