# Security

Do not expose production credentials through MCP catalogs or README examples.

Guidelines mirror NENE2 documentation for local MCP:

- Never read raw `.env` files or undocumented local filesystem paths inside tools without an explicit scoped design.
- Use `NENE_MCP_BEARER_TOKEN` or an externally minted Bearer token injected **outside** Git—not committed files.

Sensitive findings should flow through GitHub private security advisory for repository maintainers.
