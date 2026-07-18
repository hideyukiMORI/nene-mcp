# Field Trial Report Self-Review

Use before committing a report to the private mirror `nene-origin/internal-docs/mcp/field-trials/`.

Source: private `nene-origin/internal-docs/mcp/field-trials/README.md`, `docs/development/language-policy.md`, `docs/development/security-policy.md`

## Checklist

- [ ] Report filename follows `YYYY-MM-field-trial-{N}.md` and `{N}` matches FT directory number.
- [ ] Baseline includes nene-mcp ref, host app, PHP, MCP client.
- [ ] Every friction has `F-N` inline and a Friction Summary row.
- [ ] Severity, kind, and decision filled for each row.
- [ ] MCP verification table covers at least initialize, tools/list, and one tools/call.
- [ ] Security Review section present when `N % 3 == 0`; omitted or N/A otherwise.
- [ ] No secrets, tokens, `.env` contents, or production URLs.
- [ ] English throughout.
- [ ] Follow-up Issues filed (or explicitly deferred with row in private `nene-origin/internal-docs/mcp/field-trials/follow-ups.md`).
- [ ] private `nene-origin/internal-docs/mcp/field-trials/README.md` index table updated.
- [ ] private `nene-origin/internal-docs/mcp/todo/current.md` FT block updated when Issues exist.

## Verification

Manual read + confirm Issue links resolve on GitHub.
