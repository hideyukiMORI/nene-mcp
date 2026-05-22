# 写入工具与 Bearer

目录中 `"safety": "write"`（或非 read）的条目需要在 MCP 服务器环境中设置 **`NENE_MCP_BEARER_TOKEN`**。

## Fail-closed 默认

未设置 Bearer 时，`tools/call` 返回 JSON-RPC 错误且 **不发送 HTTP**：

```text
Write tool "myTool" requires bearer authentication. Set NENE_MCP_BEARER_TOKEN in the MCP server environment.
```

## 令牌存放位置

| 可以 | 不可以 |
| --- | --- |
| MCP 主机 `env` 块 | `tools.json` |
| MCP 进程的 OS 环境 | git 提交 |
| 密钥管理器 → 运行时 env | `nene_mcp_about` 输出 |

## 获取令牌

遵循 **OpenAPI 安全方案**：

- **Bearer / JWT API**：常规 auth 流程
- **NeNe TODO 示例**：OpenAPI 使用 **`sessionCookie`** — 见 [NeNe 目录模式](/zh/howto/neene-catalog-patterns)
- **标记为 `write` 的 login 工具**：即使 HTTP login 公开，仍须 env Bearer — Cookie 主机可用 **占位 Bearer**

设置 env 后，nene-mcp 在 HTTP 请求中附加 `Authorization: Bearer …`。

## MCP 参数中的凭据

`tools/call` 中的 `user_id` / `user_pass` 会出现在 **MCP 日志与 agent transcript** 中。仅使用开发账号，勿提交到 git。

## 读取工具

`safety: read` 在 nene-mcp 中不要求 Bearer（若设置了 env，GET 也会带 Bearer）。需要 session cookie 的 GET 无法仅靠 Bearer — [NeNe 目录模式](/zh/howto/neene-catalog-patterns)。

## 相关

- [安全模型](/zh/explanation/security-model)
- [环境变量](/zh/reference/environment-variables)
- [NeNe 目录模式](/zh/howto/neene-catalog-patterns)
