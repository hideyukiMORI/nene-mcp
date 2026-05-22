# Release and Package Policy

Versioning, tagging, and Composer distribution for nene-mcp. Inherited from [NENE2 release-ci](https://github.com/hideyukiMORI/NENE2/blob/main/docs/development/release-ci.md) at library scale.

**Establish this policy before running field trials at scale** so FT reports record stable baselines (tag or commit) and `composer require` paths stay consistent.

## Position

- nene-mcp is a **Composer library** (`type: library`), not an application repo.
- **Git tags on `main`** are the release source of truth.
- **GitHub Releases** publish human-readable notes and trigger Packagist webhooks later.
- **Packagist** is a goal after early field trials—not a blocker for FT1.
- During `0.x.y`, public contracts (MCP wire, env vars, catalog schema) may still change; document breaking changes in CHANGELOG and ADRs.

## Versioning (SemVer)

Use [Semantic Versioning](https://semver.org/) with a **`v` prefix** on tags: `v0.1.0`, `v0.1.1`, `v0.2.0`.

| Phase | Version | Meaning |
| --- | --- | --- |
| Early integration | `0.x.y` | Contracts still forming; breaking changes allowed with notice |
| Patch | `0.1.z` | Bug fixes, docs that clarify behavior, small DX improvements |
| Minor | `0.y.0` | New tools behavior, env aliases, catalog features—may break integrators |
| Major | `1.0.0` | Declared stable MCP wire + env + catalog schema for external users |

**Single version source:** keep `HideyukiMori\NeneMcp\Package::VERSION` aligned with the latest release tag when tagging (update in the same release PR or immediately before tag).

Do **not** promise long-term API stability on `0.x.y` releases.

## What counts as breaking (0.x)

Treat as breaking and note in CHANGELOG + consider ADR:

- JSON-RPC method behavior changes
- Renamed or removed environment variables
- Incompatible `tools.json` / catalog schema changes
- CLI exit codes or stdio wire format changes
- Minimum PHP version bumps

Non-breaking: documentation-only fixes, new optional env aliases, additive catalog fields.

## Release flow

1. Complete work on `main` via Issue-linked PRs.
2. Update `CHANGELOG.md` under `[Unreleased]` or the target version section.
3. Run [`release-checklist.md`](release-checklist.md).
4. Get **explicit maintainer approval** before creating a tag (no drive-by releases).
5. Tag from current `main` only—never unmerged PR branches.
6. Push tag and create **GitHub Release** (required for Packagist webhook later).
7. Field trials after a release should cite the **tag** in baseline (fallback: commit hash).

```bash
git switch main
git pull --ff-only origin main
# update Package::VERSION + CHANGELOG if not already done
git tag vX.Y.Z
git push origin vX.Y.Z
gh release create vX.Y.Z --title "vX.Y.Z — short title" --notes-file ...
```

## Composer install paths (by phase)

### Phase A — Before Packagist (FT period)

Preferred for field trials and early adopters:

```bash
composer require hideyukimori/nene-mcp:^0.1
```

When Packagist is not yet published, use VCS until Packagist is live:

```json
{
  "repositories": [
    {
      "type": "vcs",
      "url": "https://github.com/hideyukiMORI/nene-mcp"
    }
  ],
  "require": {
    "hideyukimori/nene-mcp": "^0.1"
  }
}
```

Or pin a tag for FT baselines:

```bash
composer require hideyukimori/nene-mcp:0.1.0
```

Document the path used in each FT report baseline.

### Phase B — Packagist publication

Publish to Packagist when **all** are true:

- At least **FT1 completed** and actionable Issues closed or deferred with rationale
- `composer.json` metadata accurate (name, license, description, bin)
- README install section matches reality
- Tags follow this policy; `v0.1.0` (or later) exists with GitHub Release
- Support expectations stated in release notes (0.x = integration preview)

Packagist setup (maintainer):

1. Submit `hideyukimori/nene-mcp` on packagist.org
2. Enable GitHub webhook (GitHub Release creation is the reliable trigger)
3. Update README to drop VCS-only instructions when stable

## Relationship to field trials

| When | Release action |
| --- | --- |
| **Before FT1** | This policy + checklist; tag **`v0.1.0`** as integration baseline |
| **During FTs** | Patch releases (`v0.1.x`) for fix-in-package findings |
| **After several FTs** | Evaluate Packagist + whether `0.2.0` is needed |
| **Before FT{N+1}** | Close prior FT Issues (unchanged cadence) |

FT reports must record: `nene-mcp ref: vX.Y.Z` or full commit hash.

## GitHub Releases and CHANGELOG

- `CHANGELOG.md` follows [Keep a Changelog](https://keepachangelog.com/) style.
- GitHub Release notes can summarize CHANGELOG; link Issues and FT reports when relevant.
- Do not tag without release notes.

## CI gate

Before any tag:

- GitHub Actions `composer check` green on `main` for PHP 8.2 and 8.4 (PHPUnit + PHPStan L8)

See [`quality-tools.md`](quality-tools.md) and [`../review/release-ci.md`](../review/release-ci.md).

## Non-goals

- Automatic release on every merged PR
- Packagist before first field trial baseline exists
- Tagging from feature branches
- Claiming `1.0.0` stability during initial FT series

## Related

- Checklist: [`release-checklist.md`](release-checklist.md)
- First tag prep: [`release-v0.1.0-prep.md`](release-v0.1.0-prep.md)
- FT methodology: [`../field-trials/README.md`](../field-trials/README.md)
- ADR policy: [`adr.md`](adr.md)
