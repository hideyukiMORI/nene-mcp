# Documentation map (repository index)

This page lists all markdown under `docs/` for contributors. **Integrators** should start at the [documentation site](https://hideyukimori.github.io/nene-mcp/).

## Start Here

| Document | Contents |
| --- | --- |
| [`project.md`](project.md) | Project purpose, NeNe relationship, architecture |
| [`../README.md`](../README.md) | Install, environment variables, minimal Cursor setup |
| [`integration/README.md`](integration/README.md) | Integration patterns |

## Integration

| Document | Contents |
| --- | --- |
| [`integration/nene.md`](integration/nene.md) | Add via Composer to NeNe |
| [`integration/other-platforms.md`](integration/other-platforms.md) | Other frameworks, vanilla PHP, other languages |
| [`example-ne-health-catalog.md`](example-ne-health-catalog.md) | Minimal NeNe health `tools.json` |

## Development

See [`development/`](development/) for workflow, security, release policy, and quality tools.

## Field trials

See private `nene-origin/internal-docs/mcp/field-trials/README.md`.

## VitePress site

Public integrator docs: `docs/index.md`, `docs/tutorial/`, `docs/howto/`, … plus locale dirs `ja/`, `fr/`, `zh/`, `pt-br/`, `de/`.

```bash
npm run docs:dev
```
