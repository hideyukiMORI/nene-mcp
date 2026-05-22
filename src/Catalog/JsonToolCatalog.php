<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp\Catalog;

use HideyukiMori\NeneMcp\Exception\McpRuntimeException;

/**
 * Loads MCP tool entries from a committed JSON catalog compatible with NENE2 `docs/mcp/tools.json`.
 *
 * @phpstan-type McpToolSource array{type: string, operationId: string, method: string, path: string}
 * @phpstan-type McpToolSafety 'read'|'write'
 * @phpstan-type McpTool array{name: string, title: string, description: string, safety: McpToolSafety, source: McpToolSource|array{type: string}, inputSchema: array<string, mixed>, responseSchemaRef: string|null}
 */
final class JsonToolCatalog
{
    /** @var list<McpTool>|null */
    private ?array $cachedTools = null;

    public function __construct(
        private readonly string $catalogPath,
    ) {
    }

    /**
     * @return list<McpTool>
     */
    public function tools(): array
    {
        if ($this->cachedTools !== null) {
            return $this->cachedTools;
        }

        if (!is_file($this->catalogPath)) {
            throw new McpRuntimeException(sprintf('MCP tool catalog could not be read from "%s".', $this->catalogPath));
        }

        $contents = file_get_contents($this->catalogPath);

        if ($contents === false) {
            throw new McpRuntimeException(sprintf('MCP tool catalog could not be read from "%s".', $this->catalogPath));
        }

        /** @var mixed $catalog */
        $catalog = json_decode($contents, true, 512, JSON_THROW_ON_ERROR);

        if (!is_array($catalog)) {
            throw new McpRuntimeException('MCP tool catalog must parse to an object.');
        }

        $tools = $catalog['tools'] ?? null;

        if (!is_array($tools)) {
            throw new McpRuntimeException('MCP tool catalog must contain a tools array.');
        }

        $validTools = array_values(array_filter($tools, static fn (mixed $t) => is_array($t)));

        $normalized = array_map($this->normalizeTool(...), $validTools);

        $this->assertUniqueToolNames($normalized);

        return $this->cachedTools = $normalized;
    }

    /**
     * @param list<McpTool> $tools
     */
    private function assertUniqueToolNames(array $tools): void
    {
        $seen = [];

        foreach ($tools as $tool) {
            $name = $tool['name'];

            if (isset($seen[$name])) {
                throw new McpRuntimeException(sprintf(
                    'MCP catalog tool name "%s" is duplicated. Tool names must be unique.',
                    $name,
                ));
            }

            $seen[$name] = true;
        }
    }

    /** @return list<McpTool> */
    public static function emptyCatalog(): array
    {
        return [];
    }

    /**
     * @return McpTool|null
     */
    public function find(string $name): ?array
    {
        foreach ($this->tools() as $tool) {
            if ($tool['name'] === $name) {
                return $tool;
            }
        }

        return null;
    }

    /**
     * @param mixed $value
     * @return McpTool
     */
    private function normalizeTool(mixed $value): array
    {
        if (!is_array($value)) {
            throw new McpRuntimeException('Each MCP catalog tool must be an object.');
        }

        $source = $value['source'] ?? null;
        $inputSchema = $value['inputSchema'] ?? null;

        if (!is_array($source) || !is_array($inputSchema)) {
            throw new McpRuntimeException('Each MCP catalog tool must define source and inputSchema objects.');
        }

        $type = $this->stringValue($source, 'type');

        if ($type !== 'openapi') {
            throw new McpRuntimeException(sprintf(
                'Committed catalog source.type "%s" is invalid. Only "openapi" is allowed in JSON; builtin tools ship with nene-mcp.',
                $type,
            ));
        }

        $resolvedSource = [
            'type' => 'openapi',
            'operationId' => $this->stringValue($source, 'operationId'),
            'method' => strtoupper($this->stringValue($source, 'method')),
            'path' => $this->stringValue($source, 'path'),
        ];

        $safety = $this->safetyValue($value);

        return [
            'name' => $this->stringValue($value, 'name'),
            'title' => $this->stringValue($value, 'title'),
            'description' => $this->stringValue($value, 'description'),
            'safety' => $safety,
            'source' => $resolvedSource,
            'inputSchema' => $inputSchema,
            'responseSchemaRef' => $this->nullableStringValue($value, 'responseSchemaRef'),
        ];
    }

    /**
     * @param array<string, mixed> $values
     * @return 'read'|'write'
     */
    private function safetyValue(array $values): string
    {
        $safety = $this->stringValue($values, 'safety');

        if ($safety !== 'read' && $safety !== 'write') {
            throw new McpRuntimeException(sprintf(
                'MCP catalog field "safety" must be "read" or "write", got "%s".',
                $safety,
            ));
        }

        return $safety;
    }

    /**
     * @param array<string, mixed> $values
     */
    private function stringValue(array $values, string $key): string
    {
        $value = $values[$key] ?? null;

        if (!is_string($value) || $value === '') {
            throw new McpRuntimeException(sprintf('MCP catalog field "%s" must be a non-empty string.', $key));
        }

        return $value;
    }

    /**
     * @param array<string, mixed> $values
     */
    private function nullableStringValue(array $values, string $key): ?string
    {
        $value = $values[$key] ?? null;

        if ($value === null) {
            return null;
        }

        if (!is_string($value) || $value === '') {
            throw new McpRuntimeException(sprintf('MCP catalog field "%s" must be a non-empty string or null.', $key));
        }

        return $value;
    }
}
