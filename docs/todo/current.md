# Current work

## Release

- **v0.1.8** — shipped: SMB adoption tier; [Release](https://github.com/hideyukiMORI/nene-mcp/releases/tag/v0.1.8)
- **v0.1.7** — quality release (#85): PHPStan L8, safety validation
- **v0.1.6** — shipped (FT379/380): F-7 docs; [Release](https://github.com/hideyukiMORI/nene-mcp/releases/tag/v0.1.6)
- **v0.1.5** — superseded on Packagist

## Field trials

| Range | Status |
| --- | --- |
| FT1–FT9 | ✅ Individual reports |
| FT10–FT200 | ✅ Individual reports ([index](field-trials/index-ft10-200.md)) |
| FT201–419 | ✅ through v0.1.6 ([339–378](field-trials/index-ft339-378.md), [380–419](field-trials/index-ft380-419.md)) |
| FT420–449 | ✅ L7 band ([index](field-trials/index-ft420-449.md)) |
| FT450–479 | ✅ FT450 PASS + L8 band ([index](field-trials/index-ft450-479.md)) |
| FT480–509 | ✅ L9 band ([index](field-trials/index-ft480-509.md)) |
| FT510–539 | ✅ L10 band ([index](field-trials/index-ft510-539.md)) |
| FT540–569 | ✅ L11 band ([index](field-trials/index-ft540-569.md)) |
| FT570–599 | ✅ L12 band ([index](field-trials/index-ft570-599.md)) |
| FT600–629 | ✅ L13 band ([index](field-trials/index-ft600-629.md)) |
| FT630–659 | ✅ L14 band ([index](field-trials/index-ft630-659.md)) |
| FT660–689 | ✅ L15 band ([index](field-trials/index-ft660-689.md)) |
| FT690–719 | ✅ L16 band ([index](field-trials/index-ft690-719.md)) |
| FT720–749 | ✅ L17 band ([index](field-trials/index-ft720-749.md)) |

## Open Issues

- **nene-mcp:** [#110](https://github.com/hideyukiMORI/nene-mcp/issues/110) — L17 band (in PR)
- **NeNe:** [#395](https://github.com/hideyukiMORI/NeNe/issues/395) **CLOSED** — FT450 + L14 Bearer E2E confirmed

## Automation

- `tools/ft-runner.sh` — all suites green on main
- `tools/packagist-verify.sh` — pass on 0.1.8
- `composer check` — PHPUnit + PHPStan L8

## Next

FT750+ — next adversarial band.
