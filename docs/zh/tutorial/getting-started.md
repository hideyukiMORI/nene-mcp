# 入门

nene-mcp 通过 NENE2 兼容目录为 HTTP API 添加 **stdio MCP**。

## 要求

- PHP **8.2+**
- [Composer](https://getcomposer.org/)
- MCP 主机（Cursor、Claude Desktop 等）

## 安装

```bash
composer require hideyukimori/nene-mcp
```

已在 [Packagist](https://packagist.org/packages/hideyukimori/nene-mcp) 发布。固定版本：

```bash
composer require hideyukimori/nene-mcp:^0.1
```

请查看 [Packagist](https://packagist.org/packages/hideyukimori/nene-mcp) 或 [GitHub Releases](https://github.com/hideyukiMORI/nene-mcp/releases)。若文档版本高于 Packagist，请使用**已发布**的最新 tag。

## Day 0 — 仅 about

省略 `NENE_MCP_TOOLS_JSON` 时仅暴露 `nene_mcp_about`：

```bash
export NENE_MCP_API_BASE_URL=http://localhost:8080
printf '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}\n' | php vendor/bin/nene-mcp
```

## 下一步

- [Cursor 配置](/zh/tutorial/cursor-setup)
- [集成 NeNe](/zh/howto/integrate-nene)
