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

## 2b. Tool count checklist (avoid partial catalog drift)

After `tools/list`, confirm **every** business tool your team expects is present — not only health:

```bash
printf '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}\n' | php vendor/bin/nene-mcp \
  | php -r '$d=json_decode(stream_get_contents(STDIN),true); foreach($d["result"]["tools"] as $t){ if($t["name"]!=="nene_mcp_about") echo $t["name"],PHP_EOL; }'
```

If inventory or write tools are missing from this list, agents cannot call them — fix `tools.json` and redeploy MCP config before announcing “MCP is live”. See [Bearer-native bridge example](/howto/bearer-native-bridge-example).

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
| Read tool HTTP 401 | Bearer-protected GET — set `NENE_MCP_BEARER_TOKEN` ([Bearer-native example](/howto/bearer-native-bridge-example)) |
| Mutating tool HTTP 401, no JSON-RPC bearer error | `safety: read` on POST/PUT — use `write` or set env Bearer ([safety vs method](/howto/write-tools-bearer#safety-label-vs-http-method)) |
| Agent “missing tool” | Partial catalog deployed — run tool count checklist (§2b) |
