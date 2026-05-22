# Current work

## Release

- **v0.1.5** — tagging (FT295): whitespace Bearer fail-closed fix (#64)
- **v0.1.4** — shipped; [Release](https://github.com/hideyukiMORI/nene-mcp/releases/tag/v0.1.4)

## Field trials

| Range | Status |
| --- | --- |
| FT1–FT9 | ✅ Individual reports |
| FT10–FT200 | ✅ Individual reports ([index](field-trials/index-ft10-200.md)) |
| FT201–295 | ✅ Persona + L6 adversarial + v0.1.5 release ([255–294 index](field-trials/index-ft255-294.md)) |

## Open Issues

- **nene-mcp:** 0
- **NeNe cross-repo:** [#380](https://github.com/hideyukiMORI/NeNe/issues/380) — optional Bearer for MCP agents (FT204)

## Automation

- `tools/ft-runner.sh` — all suites green on main (FT210)
- `tools/packagist-verify.sh` — pass

## Next

FT295+ — F-7 doc callout for mislabeled `safety:read`; NeNe #380; v0.1.5 when warranted.
