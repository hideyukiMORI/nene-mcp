# 目录 smoke 测试

在暴露写入工具前验证 MCP 连接。

## 1. 仅 about

```bash
unset NENE_MCP_TOOLS_JSON
export NENE_MCP_API_BASE_URL=http://localhost:8080
printf '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}\n' | php vendor/bin/nene-mcp
```

期望：仅 `nene_mcp_about`。

## 2. 带目录

```bash
export NENE_MCP_TOOLS_JSON=/绝对路径/docs/mcp/tools.json
printf '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"getHealthCheck","arguments":{}}}\n' \
  | php vendor/bin/nene-mcp
```

期望：`statusCode` 与 JSON `body`。

## 2b. 工具数量（部分目录）

`tools/list` 后确认 **所有** 预期业务工具均已列出。见 [Bearer 原生 bridge](/zh/howto/bearer-native-bridge-example)。

## 3. 自动化

```bash
tools/ft-runner.sh smoke /path/to/tools.json
tools/ft-runner.sh write-failclosed /tmp/ft-write
```

## 常见失败

| 症状 | 原因 |
| --- | --- |
| `tools/list` 错误 | 目录路径无效 |
| 连接被拒绝 | 应用未运行或 URL 错误 |
| 重复名称 | 两个 tool 同名 |
| read HTTP 401 | Bearer GET — 设置 `NENE_MCP_BEARER_TOKEN` |
| 工具缺失 | 部分目录 — §2b |
