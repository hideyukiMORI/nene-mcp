<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp\Tests;

use HideyukiMori\NeneMcp\Catalog\JsonToolCatalog;
use HideyukiMori\NeneMcp\Exception\McpRuntimeException;
use PHPUnit\Framework\TestCase;

final class JsonToolCatalogTest extends TestCase
{
    private const FIXTURE_CATALOG = __DIR__ . '/fixtures/sample-catalog.json';

    public function testLoadsValidCatalog(): void
    {
        $catalog = new JsonToolCatalog(self::FIXTURE_CATALOG);

        $tools = $catalog->tools();

        self::assertNotEmpty($tools);
        self::assertSame('getHealthDemo', $tools[0]['name']);
    }

    public function testRejectsDuplicateToolNames(): void
    {
        $path = $this->writeCatalog([
            'tools' => [
                $this->openapiTool('dup', 'a'),
                $this->openapiTool('dup', 'b'),
            ],
        ]);

        $catalog = new JsonToolCatalog($path);

        $this->expectException(McpRuntimeException::class);
        $this->expectExceptionMessage('MCP catalog tool name "dup" is duplicated');

        $catalog->tools();
    }

    public function testRejectsInvalidJson(): void
    {
        $path = sys_get_temp_dir() . '/nene-mcp-invalid-' . uniqid('', true) . '.json';
        file_put_contents($path, '{bad json');

        $catalog = new JsonToolCatalog($path);

        $this->expectException(\JsonException::class);

        $catalog->tools();
    }

    /** @param array<string, mixed> $payload */
    private function writeCatalog(array $payload): string
    {
        $path = sys_get_temp_dir() . '/nene-mcp-catalog-' . uniqid('', true) . '.json';
        file_put_contents($path, json_encode($payload, JSON_THROW_ON_ERROR));

        return $path;
    }

    /** @return array<string, mixed> */
    private function openapiTool(string $name, string $operationId): array
    {
        return [
            'name' => $name,
            'title' => $name,
            'description' => $name,
            'safety' => 'read',
            'source' => [
                'type' => 'openapi',
                'operationId' => $operationId,
                'method' => 'GET',
                'path' => '/demo/health',
            ],
            'inputSchema' => [
                'type' => 'object',
                'properties' => new \stdClass(),
                'additionalProperties' => false,
            ],
            'responseSchemaRef' => null,
        ];
    }
}
