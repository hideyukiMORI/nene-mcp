# Security

Do not expose production credentials through MCP catalogs or README examples.

**Full policy for implementers:** [`docs/development/security-policy.md`](docs/development/security-policy.md)

Summary:

- Never read raw `.env` files or undocumented local filesystem paths inside tools without an explicit scoped design.
- Use `NENE_MCP_BEARER_TOKEN` or an externally minted Bearer token injected **outside** Git—not committed files.
- MCP responses and stderr must not leak tokens, stack traces, or secrets.

Sensitive findings should flow through [GitHub private security advisory](https://github.com/hideyukiMORI/nene-mcp/security/advisories/new) for repository maintainers.
