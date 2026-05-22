# 集成 NeNe

nene-mcp **没有** NeNe 专用代码。NeNe 是提供 OpenAPI + `docs/mcp/tools.json` 的主机之一。

## 先启动 NeNe

nene-mcp 文档假设 **NeNe HTTP 应用已在运行**。若尚未部署：

1. 克隆 NeNe：[github.com/hideyukiMORI/NeNe](https://github.com/hideyukiMORI/NeNe)
2. 在项目根目录 `composer install`
3. 启动应用 — Docker（`compose.yaml`）或主机 PHP；见 NeNe `docs/development/docker.md`
4. 确认 HTTP 可用（例如在 base URL 上 `GET /health/index`）

然后在 **同一项目** 中添加 nene-mcp：

```bash
composer require hideyukimori/nene-mcp:^0.1
```

## 前提

- 本地运行的 NeNe（Docker 或主机 PHP）
- 使用 NeNe Docker 镜像时需要 PHP **ext-intl**
- MCP 主机配置使用 **绝对路径**（[Cursor 配置](/zh/tutorial/cursor-setup)）

## 步骤

1. 暴露带 OpenAPI 文档的 REST（NeNe 约定）。
2. 提交 `docs/mcp/tools.json` — NENE2 格式（[目录参考](/zh/reference/catalog-format)）。可从 [health 示例](/zh/howto/health-catalog-example) 开始。
3. 在 MCP 主机中配置 `vendor/bin/nene-mcp` 与 `tools.json` 的 **绝对路径**。
4. 在启用写入工具前对 read 工具做 [smoke 测试](/zh/howto/catalog-smoke-test)。
5. NeNe TODO / 会话路由：见 [NeNe 目录模式](/zh/howto/neene-catalog-patterns)。

::: warning 目录路径须为绝对路径
`NENE_MCP_TOOLS_JSON` 请使用 **绝对路径**。相对路径依赖 MCP 进程 cwd，Cursor 启动时可能无法解析 `docs/mcp/tools.json`。
:::

::: info NeNe Session Cookie 限制
标准 NeNe 示例用 **Session Cookie** 保护 `/todo/*`。nene-mcp 是 **无状态 Bearer 代理**，不在 MCP 调用间保存 cookie。health 等公开 read 可用；**login → 列表 → 创建** 若无主机侧 auth 变更则无法完成。详见 [NeNe 目录模式](/zh/howto/neene-catalog-patterns)。
:::

## 基础 URL（`NENE_MCP_API_BASE_URL`）

须与 NeNe 实际提供 HTTP 的地址一致（含 `URI_ROOT` 或反向代理前缀）。例：`NENE_MCP_API_BASE_URL=http://localhost:8080/mybiz`，目录 path 仍为 `/health/index`。前缀错误 → **404**。见 [NeNe 目录模式](/zh/howto/neene-catalog-patterns)。

## 环境别名

| nene-mcp | NENE2 |
| --- | --- |
| `NENE_MCP_API_BASE_URL` | `NENE2_LOCAL_API_BASE_URL` |
| `NENE_MCP_TOOLS_JSON` | `NENE2_LOCAL_TOOLS_JSON` |

## Bootstrap 缺口

NeNe Docker 或扩展前提阻塞时，请在 **NeNe 仓库** 提 Issue。

## 相关

- [其他平台](/zh/howto/other-platforms)
- [生态地图](/zh/integrations/ecosystem)
- [NeNe 目录模式](/zh/howto/neene-catalog-patterns)
