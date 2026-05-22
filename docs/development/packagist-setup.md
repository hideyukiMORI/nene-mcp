# Packagist Setup (G1)

**Status: complete** — https://packagist.org/packages/hideyukimori/nene-mcp (registered 2026-05-22).

One-time maintainer guide used to publish `hideyukimori/nene-mcp` on [Packagist](https://packagist.org/). Policy: [`release-policy.md`](release-policy.md).

Closed: GitHub Issue **#16**.

## Preconditions

- [ ] `v0.1.0` (or later) tag exists on `main` with GitHub Release
- [ ] FT1 complete; actionable FT1 Issues closed
- [ ] `composer.json` name is `hideyukimori/nene-mcp`, `type: library`, `bin` includes `bin/nene-mcp`
- [ ] Repository is public on GitHub

## Submit the package

### Web UI (recommended)

1. Sign in at https://packagist.org/ (GitHub OAuth)
2. Click **Submit**
3. Repository URL: `https://github.com/hideyukiMORI/nene-mcp`
4. Confirm package name: `hideyukimori/nene-mcp`

### API (alternative)

Requires the **main** API token from your Packagist profile:

```bash
curl -X POST \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer hideyukimori:YOUR_MAIN_TOKEN' \
  'https://packagist.org/api/create-package' \
  -d '{"repository":"https://github.com/hideyukiMORI/nene-mcp"}'
```

## GitHub webhook

After submission, Packagist prompts to set up the GitHub hook. Accept it so new tags and releases trigger package updates.

Manual update if needed:

```bash
curl -X POST \
  -H 'Authorization: Bearer hideyukimori:YOUR_SAFE_OR_MAIN_TOKEN' \
  'https://packagist.org/api/update-package' \
  -d '{"repository":{"url":"https://github.com/hideyukiMORI/nene-mcp"}}'
```

## Verify

```bash
curl -sS https://packagist.org/packages/hideyukimori/nene-mcp.json | head -c 200

# Preferred: repo script (composer install + tools/list smoke)
tools/packagist-verify.sh 0.1.3
```

Or manual smoke:

```bash
mkdir /tmp/packagist-smoke && cd /tmp/packagist-smoke
composer init --name=smoke/test --no-interaction
composer require hideyukimori/nene-mcp:^0.1
php vendor/bin/nene-mcp --help 2>&1 || true
```

Expect package metadata JSON and successful `composer require` **without** a VCS repository stanza.

## Troubleshooting

| Symptom | Action |
| --- | --- |
| New tag on GitHub but old versions on Packagist | Wait 1–5 min; run `tools/packagist-verify.sh <version>`; ping GitHub hook or POST `api/update-package` (below) |
| `packagist.org/...json` lags behind web UI | Trust `composer require hideyukimori/nene-mcp:<version>` — Packagist JSON API can cache longer than the website |
| Webhook 202 but no new version | Manual update-package; confirm tag points at valid `composer.json` on GitHub |

After each GitHub Release, CI workflow **Release verify** (`.github/workflows/release-verify.yml`) retries `tools/packagist-verify.sh` automatically.

## After publication

1. Update README install section — `composer require hideyukimori/nene-mcp` as primary path
2. Move pre-Packagist VCS block in `docs/integration/nene.md` to a short historical note or remove
3. Close Issue #16
4. Run **FT8** (Packagist-only install validation)

## Related

- [`release-checklist.md`](release-checklist.md)
- [`../field-trials/schedule.md`](../field-trials/schedule.md) — G1 gate, FT8 validation
