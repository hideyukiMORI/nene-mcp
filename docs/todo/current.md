# Current work

## Release

- **v0.1.4** — shipped (FT223/224): docs persona band FT201–222 + PHPUnit query/path tests; [Release](https://github.com/hideyukiMORI/nene-mcp/releases/tag/v0.1.4)
- **v0.1.3** — superseded by 0.1.4 on Packagist

## Field trials

| Range | Status |
| --- | --- |
| FT1–FT9 | ✅ Individual reports |
| FT10–FT200 | ✅ Individual reports ([index](field-trials/index-ft10-200.md)) |
| FT201–254 | ✅ Persona + post-v0.1.4 regression ([201–224 index](field-trials/index-ft201-211.md), [225–254 index](field-trials/index-ft225-254.md)) |

## Open Issues

- **nene-mcp:** 0
- **NeNe cross-repo:** [#380](https://github.com/hideyukiMORI/NeNe/issues/380) — optional Bearer for MCP agents (FT204)

## Automation

- `tools/ft-runner.sh` — all suites green on main (FT210)
- `tools/packagist-verify.sh` — pass

## Next

FT255+ — NeNe #380 (Bearer E2E); continue regression band or cut v0.1.5 when friction warrants.
