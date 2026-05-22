# nene-mcp Documentation

Documentation index for the NeNe ecosystem MCP bridge and generic HTTP app integration.

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

| Document | Contents |
| --- | --- |
| [`workflow.md`](workflow.md) | Issue-driven workflow |
| [`CONTRIBUTING.md`](CONTRIBUTING.md) | Contribution guide |
| [`development/coding-standards.md`](development/coding-standards.md) | PHP / MCP architecture rules |
| [`development/language-policy.md`](development/language-policy.md) | English-only public policy |
| [`development/quality-tools.md`](development/quality-tools.md) | PHPUnit, PHPStan, CS-Fixer |
| [`development/security-policy.md`](development/security-policy.md) | Security rules for implementers |
| [`development/self-review.md`](development/self-review.md) | Checklist policy |
| [`development/commit-conventions.md`](development/commit-conventions.md) | Conventional Commits |
| [`development/adr.md`](development/adr.md) | ADR policy |
| [`development/release-policy.md`](development/release-policy.md) | Versioning, tags, Packagist timing |
| [`development/release-checklist.md`](development/release-checklist.md) | Pre-tag checklist |
| [`development/release-v0.1.0-prep.md`](development/release-v0.1.0-prep.md) | First tag candidate |
| [`review/README.md`](review/README.md) | Self-review checklists |
| [`adr/README.md`](adr/README.md) | ADR index |
| [`todo/current.md`](todo/current.md) | Short-lived TODO summary |

## Field trials

| Document | Contents |
| --- | --- |
| [`field-trials/README.md`](field-trials/README.md) | FT methodology (inherited from NeNe / NENE2 / nene2-python) |
| [`field-trials/schedule.md`](field-trials/schedule.md) | Long-horizon FT plan (FT2–FT18) |
| [`field-trials/follow-ups.md`](field-trials/follow-ups.md) | Deferred FT findings |
| [`templates/field-trial-report.md`](templates/field-trial-report.md) | Report skeleton |
| [`review/field-trial-report.md`](review/field-trial-report.md) | Pre-commit checklist for reports |

## AI / Cursor

| Path | Contents |
| --- | --- |
| [`../AGENTS.md`](../AGENTS.md) | Required reading for agents |
| [`.cursor/rules/`](../.cursor/rules/) | Cursor persistent rules (project context) |

## NeNe references (external)

nene-mcp does not ship NeNe MCP code. For NeNe conventions and OpenAPI policy, see the NeNe repository.

| NeNe document | Use |
| --- | --- |
| `docs/project.md` | Framework philosophy, routing |
| `docs/api/README.md` | OpenAPI policy |
| `docs/tutorials/building-a-service.md` | Adding REST endpoints |
| `AGENTS.md` | NeNe agent rules |

## Source of Truth

GitHub Issues and PRs are the source of truth for active work.  
Update docs when purpose, integration steps, or configuration change.
