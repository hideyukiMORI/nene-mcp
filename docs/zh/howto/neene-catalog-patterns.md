# NeNe 目录模式

将 `docs/api/openapi.yaml` 映射到 `docs/mcp/tools.json` 时的 NeNe 约定。nene-mcp **不含** NeNe 专用代码。

## 路径参数（`id_{param}`）

NeNe 常用 **键值路径段**，而非纯 OpenAPI `{param}`。

| OpenAPI path | 目录 `path` | `tools/call` 参数 |
| --- | --- | --- |
| `/todo/item/id_{id}` | `/todo/item/id_{id}` | `{ "id": "42" }` → HTTP `/todo/item/id_42` |

**常见错误：** 使用 `/todo/item/{id}` → NeNe 返回 **405**（路由需要 `id_{id}`）。

## 基础 URL 与 `URI_ROOT`

`NENE_MCP_API_BASE_URL` = 源站 + 部署前缀。目录 `path` 追加在其后。

| NeNe 部署 | `NENE_MCP_API_BASE_URL` | 目录 path |
| --- | --- | --- |
| 根路径 | `http://localhost:8080` | `/health/index` |
| `URI_ROOT=/mybiz/` | `http://localhost:8080/mybiz` | `/health/index` |

不匹配时：health 或业务接口 **404** — 检查 NeNe `URI_ROOT`。

## Session Cookie 认证（TODO 示例）

NeNe OpenAPI 在 `/todo/*` 使用 **`sessionCookie`**，非 Bearer。

nene-mcp 当前：

- 设置 `NENE_MCP_BEARER_TOKEN` 时发送 **`Authorization: Bearer …`**
- **不**在 MCP 调用间保存 cookie

因此 **login → listTodos → createTodo** 在 stock NeNe 示例上 **无法** 通过 MCP  alone 完成。

## CSRF（`X-CSRF-Token`）

TODO **写入** 除 cookie 外还需要 login 返回的 token 作为 **`X-CSRF-Token` 头**。nene-mcp **不支持**该头。见 [NeNe #380](https://github.com/hideyukiMORI/NeNe/issues/380)。

## 写入工具与 login 引导

`safety: write` 需要 env Bearer（fail-closed）。HTTP login 公开时可用 **占位 Bearer** 满足 fail-closed。

MCP 参数中的账号密码会进入 **agent  transcript** — 仅使用开发账号。

## 相关

- [集成 NeNe](/zh/howto/integrate-nene)
- [写入工具与 Bearer](/zh/howto/write-tools-bearer)
- [NeNe health 目录示例](/zh/howto/health-catalog-example)
