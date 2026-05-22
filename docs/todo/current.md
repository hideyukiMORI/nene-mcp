# Current work

## Release

- **v0.1.4** — shipped (FT223/224): docs persona band FT201–222 + PHPUnit query/path tests; [Release](https://github.com/hideyukiMORI/nene-mcp/releases/tag/v0.1.4)
- **v0.1.3** — superseded by 0.1.4 on Packagist

## Field trials

| Range | Status |
| --- | --- |
| FT1–FT9 | ✅ Individual reports |
| FT10–FT200 | ✅ Individual reports ([index](field-trials/index-ft10-200.md)) |
| FT201–294 | ✅ Persona + regression + L6 adversarial ([201–224](field-trials/index-ft201-211.md), [225–254](field-trials/index-ft225-254.md), [255–294](field-trials/index-ft255-294.md)) |

## Open Issues

- **nene-mcp:** #65 (this band PR)
- **NeNe cross-repo:** [#380](https://github.com/hideyukiMORI/NeNe/issues/380) — optional Bearer for MCP agents (FT204)

## Automation

- `tools/ft-runner.sh` — all suites green on main (FT210)
- `tools/packagist-verify.sh` — pass

## Next

FT295+ — F-7 doc callout for mislabeled `safety:read`; NeNe #380; v0.1.5 when warranted.
