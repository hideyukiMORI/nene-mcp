<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp\Catalog;

/**
 * Builtin tools bundled with hideyukiMori/nene-mcp (never require HTTP nor NeNe checkout).
 *
 * @phpstan-import-type McpTool from JsonToolCatalog
 */
final class BuiltinCatalog
{
    /**
     * @return list<McpTool>
     */
    public static function tools(): array
    {
        return [
            [
                'name' => 'nene_mcp_about',
                'title' => 'About nene-mcp',
                'description' => 'Return package metadata and resolved environment (paths and base URLs only; no secrets).',
                'safety' => 'read',
                'source' => [
                    'type' => 'builtin',
                ],
                'inputSchema' => [
                    'type' => 'object',
                    'properties' => [],
                    'additionalProperties' => false,
                ],
                'responseSchemaRef' => null,
            ],
        ];
    }
}
