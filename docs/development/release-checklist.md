# Release Checklist

Manual checklist for `v0.x.y` tags until release automation exists. Policy: [`release-policy.md`](release-policy.md).

## Preconditions

- [ ] Release tracked by GitHub Issue (or release prep Issue closed).
- [ ] Release created from **`main`**; working tree clean locally.
- [ ] `main` is up to date with `origin/main`.
- [ ] All Issues intended for this release are merged or explicitly deferred in CHANGELOG.
- [ ] `CHANGELOG.md` updated for this version.
- [ ] `src/Package.php` `VERSION` matches the tag (e.g. `0.1.0` for `v0.1.0`).
- [ ] Public behavior / env / catalog changes documented when applicable.
- [ ] **Explicit maintainer approval** to tag (comment on Issue or recorded ack).

## Verification

```bash
composer validate
composer test
git diff --check
```

When available:

```bash
composer check
```

- [ ] GitHub Actions green on the release commit (PHP 8.2 + 8.4).
- [ ] **Packagist:** `tools/packagist-verify.sh <version>` passes (or Release verify workflow green).
- [ ] No secrets or local paths in committed files.

## Version selection

- [ ] Tag uses `vX.Y.Z` prefix.
- [ ] `0.x.y` used while contracts are still forming.
- [ ] Breaking changes called out in CHANGELOG and ADR if needed.

## Tag and release

```bash
git switch main
git pull --ff-only origin main
git tag vX.Y.Z
git push origin vX.Y.Z
gh release create vX.Y.Z \
  --title "vX.Y.Z — short description" \
  --notes "$(cat <<'EOF'
## Highlights

- …

## Verification

- composer test on PHP 8.2 / 8.4

## Support

0.x integration preview — not a long-term stability promise.
EOF
)"
```

- [ ] Tag points to intended commit on `main`.
- [ ] GitHub Release created (not tag-only push).
- [ ] Release notes mention support expectations for `0.x` if applicable.

## After release

- [ ] Packagist auto-update confirmed (after Packagist is enabled)—or N/A if pre-Packagist.
- [ ] private `nene-origin/internal-docs/mcp/todo/current.md` updated if release changes project state.
- [ ] Next FT reports use this tag in baseline.

## Non-goals

- Do not tag unmerged PR branches.
- Do not skip GitHub Release before Packagist is connected.
- Do not force-push `main` to fix a bad tag—cut a new patch instead.
