# Field Trial 216 — Security: CSRF exposure + host matrix cadence

## Date

2026-05-22

## Baseline

- nene-mcp ref: `main` + #51 branch
- FT215 CSRF probes on NeNe; FT206 Bearer-native sandbox
- `216 % 3 == 0` — full security review

## Security Review

### SSRF and URL control

- [x] FT210/207 harness — paths stay on configured base
- **Result**: Pass (no regression)

### Secret handling

- [x] Bearer not in `nene_mcp_about` (FT210 spot check)
- [x] `sessionLogin` MCP response includes `csrfToken` in **tool body** (API contract data)
- [ ] **Note**: CSRF in MCP transcript — same class as credentials-in-arguments; operators should treat login tool output as sensitive in shared logs
- **Result**: Conditional — document CSRF sensitivity alongside credentials (#51)

### Write tools

- [x] fail-closed without Bearer
- [x] NeNe writes blocked by session + CSRF even if Bearer placeholder set
- **Result**: Pass — defense in depth on host

### JSON-RPC / protocol

- [x] CSRF/401/403 as structured errors, no crash
- **Result**: Pass

**Security summary**: **conditional** — bridge does not weaken NeNe CSRF; MCP transcripts may contain csrfToken from login tool.

## Host matrix verification

Re-ran:

| Check | NeNe | Bearer-native |
| --- | --- | --- |
| `tools/ft-runner.sh smoke` | health catalog (8080) | FT206 catalog (9090) |
| Write E2E | Not achievable | 201 create |

## Friction Summary

None new — F-1 covered by #51.

## Follow-up

#51

## Next gate

FT217 — query param catalog mapping or OpenAPI `servers` mismatch theme
