# Catalog smoke test

Verify MCP wiring before exposing write tools.

## 1. About-only

```bash
unset NENE_MCP_TOOLS_JSON
export NENE_MCP_API_BASE_URL=http://localhost:8080
printf '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}\n' | php vendor/bin/nene-mcp
```

Expect exactly one tool: `nene_mcp_about`.

## 2. With catalog

```bash
export NENE_MCP_TOOLS_JSON=/ABS/PATH/docs/mcp/tools.json
printf '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"getHealthCheck","arguments":{}}}\n' \
  | php vendor/bin/nene-mcp
```

Expect `statusCode` and JSON `body` in structured content.

## 3. Automation harness

From the nene-mcp repo:

```bash
tools/ft-runner.sh smoke /path/to/tools.json
tools/ft-runner.sh write-failclosed /tmp/ft-write
```

## Common failures

| Symptom | Likely cause |
| --- | --- |
| `tools/list` error on startup | Invalid or missing catalog path |
| HTTP connection refused | App not running or wrong base URL |
| Duplicate name error | Two tools share the same `name` (v0.1.3+) |
