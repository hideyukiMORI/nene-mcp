# Field Trial 6 — Security review (catalog mistakes)

## Date

2026-05-22

## Baseline

- nene-mcp ref: `v0.1.2`
- Runner: `tools/ft-runner.sh security-catalog`

## Goal

FT6 (`N % 3 == 0` variant: catalog-focused): invalid JSON, duplicate names, absolute path in catalog.

## Results

| Probe | Result |
| --- | --- |
| Invalid JSON catalog | `-32700` / safe error |
| Duplicate tool names | Both listed — **F-1** |
| Absolute URL in `path` | HTTP 400 from Apache; no host escape |
| `ft-runner.sh` `${3:-{}}` bash bug | **F-2** — broke initialize; fixed in repo |

**Finding (F-1)**: No duplicate `name` rejection (medium, feature-gap, defer).

**Finding (F-2)**: Automation `${3:-{}}` bash parsing — fixed in `tools/ft-runner.sh`.

## Security Review

### SSRF and URL control

- [x] Absolute path in catalog → malformed URL, no third-party fetch
- [x] Redirect following disabled (FT3 fix)
- **Result**: pass

### Secret handling

- [x] N/A this FT
- **Result**: pass

### Write tools

- N/A

### JSON-RPC / protocol

- [x] Invalid catalog → safe error
- **Result**: pass

**Security summary**: conditional pass — duplicate names are schema hygiene, not exploit.

## Follow-up Issues

#22 — duplicate catalog tool names

## Next FT gate

Defer #22 recorded; proceed FT7.
