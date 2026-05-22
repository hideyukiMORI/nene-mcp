# Release and CI Self-Review

Use for `.github/workflows/`, `composer.json` scripts, PHP version matrix, and release prep.

Source policies:

- `docs/development/release-policy.md`
- `docs/development/release-checklist.md`
- `docs/development/quality-tools.md`
- `docs/development/coding-standards.md`

## Checklist

- [ ] GitHub Issue exists for CI or release policy changes.
- [ ] New composer scripts documented in `quality-tools.md`.
- [ ] CI runs the same commands documented for local verification.
- [ ] PHP matrix matches library `require.php` constraint.
- [ ] No secrets or tokens in workflow files.
- [ ] New quality tools have committed config before joining `composer check`.
- [ ] Breaking env or CLI changes noted in PR, CHANGELOG, and considered for ADR.
- [ ] Release policy consulted when changing version, tag, or Packagist-related metadata.
- [ ] `composer test` (or `composer check`) verified locally before push.

## Verification

```bash
composer test
```

Run on the same PHP minor versions CI uses when possible.
