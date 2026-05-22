# Cursor / MCP 客户端配置

配置 MCP 主机通过 stdio 启动 `vendor/bin/nene-mcp`。**必须使用绝对路径**。

## 带目录（典型）

```json
{
  "mcpServers": {
    "nene-mcp": {
      "command": "php",
      "args": ["/绝对路径/vendor/bin/nene-mcp"],
      "env": {
        "NENE_MCP_API_BASE_URL": "http://localhost:8080",
        "NENE_MCP_TOOLS_JSON": "/绝对路径/your-app/docs/mcp/tools.json"
      }
    }
  }
}
```

## 无目录 smoke

在 `tools.json` 就绪前省略 `NENE_MCP_TOOLS_JSON`。

## 写入工具

Bearer 仅放在 MCP 主机 `env` 中 — 勿提交 git。见 [写入工具与 Bearer](/zh/howto/write-tools-bearer)。

## 验证

1. 启动无 stderr 堆栈
2. `tools/list` 返回 `nene_mcp_about`（+ 目录工具）
3. read 工具 `tools/call` 返回 HTTP 状态与 JSON

## 前端 / Cursor 团队

仓库中的 `.cursor/mcp.json` 需要**每台机器的绝对路径**。替换 `/绝对路径` 或文档化替换步骤。

## 相关

- [集成 NeNe](/zh/howto/integrate-nene)
- [NeNe 目录模式](/zh/howto/neene-catalog-patterns)
