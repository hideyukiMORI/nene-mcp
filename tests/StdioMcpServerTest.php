<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp\Tests;

use HideyukiMori\NeneMcp\Catalog\JsonToolCatalog;
use HideyukiMori\NeneMcp\Catalog\MergedCatalog;
use HideyukiMori\NeneMcp\Http\McpHttpResponse;
use HideyukiMori\NeneMcp\Package;
use HideyukiMori\NeneMcp\StdioMcpServer;
use PHPUnit\Framework\TestCase;

final class StdioMcpServerTest extends TestCase
{
    private const FIXTURE_CATALOG = __DIR__ . '/fixtures/sample-catalog.json';

    public function testInitializeReturnsCapabilities(): void
    {
        $server = $this->createServer(null);

        $response = $server->handle([
            'jsonrpc' => '2.0',
            'id' => 1,
            'method' => 'initialize',
            'params' => [],
        ]);

        self::assertSame('2.0', $response['jsonrpc']);
        self::assertSame(1, $response['id']);
        self::assertSame(Package::NAME, $response['result']['serverInfo']['name']);
        self::assertSame(Package::VERSION, $response['result']['serverInfo']['version']);
        self::assertSame(false, $response['result']['capabilities']['tools']['listChanged']);
    }

    public function testToolsListIncludesBuiltinAndCatalog(): void
    {
        $server = $this->createServer(self::FIXTURE_CATALOG);

        $response = $server->handle([
            'jsonrpc' => '2.0',
            'id' => 2,
            'method' => 'tools/list',
            'params' => [],
        ]);

        $tools = array_column((array) $response['result']['tools'], 'name');
        self::assertSame('nene_mcp_about', $tools[0]);
        self::assertContains('getHealthDemo', $tools);
        self::assertTrue($response['result']['tools'][0]['annotations']['readOnlyHint']);
    }

    public function testToolsCallAboutBuiltin(): void
    {
        $server = $this->createServer(null);

        $response = $server->handle([
            'jsonrpc' => '2.0',
            'id' => 3,
            'method' => 'tools/call',
            'params' => [
                'name' => 'nene_mcp_about',
                'arguments' => [],
            ],
        ]);

        self::assertFalse($response['result']['isError']);
        self::assertSame(Package::VERSION, $response['result']['structuredContent']['packageVersion']);
    }

    public function testToolsCallOpenApiDelegatesToHttpClient(): void
    {
        $stub = new McpHttpResponse(200, ['x-request-id' => 'rq-42'], '{"ok":true}');
        $client = new RecordingHttpClient($stub);
        $catalog = new MergedCatalog(new JsonToolCatalog(self::FIXTURE_CATALOG));
        $server = new StdioMcpServer($catalog, $client, 'http://app.test', []);

        $response = $server->handle([
            'jsonrpc' => '2.0',
            'id' => 4,
            'method' => 'tools/call',
            'params' => [
                'name' => 'getHealthDemo',
                'arguments' => [],
            ],
        ]);

        self::assertCount(1, $client->requests);
        self::assertSame(['GET', 'http://app.test', '/demo/health'], $client->requests[0]);
        self::assertSame(200, $response['result']['structuredContent']['statusCode']);
        self::assertSame('rq-42', $response['result']['structuredContent']['requestId']);
    }

    public function testNotificationWithoutIdReturnsNull(): void
    {
        $server = $this->createServer(null);

        $response = $server->handle([
            'jsonrpc' => '2.0',
            'method' => 'notifications/initialized',
        ]);

        self::assertNull($response);
    }

    public function testWriteToolFailsClosedWithoutBearer(): void
    {
        $writeCatalog = sys_get_temp_dir() . '/nene-mcp-write-' . uniqid('', true) . '.json';
        file_put_contents($writeCatalog, json_encode([
            'tools' => [[
                'name' => 'writeProbe',
                'title' => 'Write probe',
                'description' => 'Write probe',
                'safety' => 'write',
                'source' => [
                    'type' => 'openapi',
                    'operationId' => 'login',
                    'method' => 'POST',
                    'path' => '/session/login',
                ],
                'inputSchema' => [
                    'type' => 'object',
                    'properties' => new \stdClass(),
                    'additionalProperties' => false,
                ],
                'responseSchemaRef' => null,
            ]],
        ], JSON_THROW_ON_ERROR));

        $catalog = new MergedCatalog(new JsonToolCatalog($writeCatalog));
        $server = new StdioMcpServer(
            $catalog,
            new RecordingHttpClient(new McpHttpResponse(200, [], '{}')),
            'http://stub',
            [],
        );

        $response = $server->handle([
            'jsonrpc' => '2.0',
            'id' => 5,
            'method' => 'tools/call',
            'params' => [
                'name' => 'writeProbe',
                'arguments' => [],
            ],
        ]);

        self::assertSame(-32603, $response['error']['code']);
        self::assertStringContainsString('requires bearer authentication', $response['error']['message']);
    }

    public function testDuplicateCatalogNamesSurfaceAsJsonRpcError(): void
    {
        $dupCatalog = sys_get_temp_dir() . '/nene-mcp-dup-' . uniqid('', true) . '.json';
        file_put_contents($dupCatalog, json_encode([
            'tools' => [
                [
                    'name' => 'dup',
                    'title' => 'a',
                    'description' => 'a',
                    'safety' => 'read',
                    'source' => ['type' => 'openapi', 'operationId' => 'a', 'method' => 'GET', 'path' => '/a'],
                    'inputSchema' => ['type' => 'object', 'properties' => new \stdClass(), 'additionalProperties' => false],
                    'responseSchemaRef' => null,
                ],
                [
                    'name' => 'dup',
                    'title' => 'b',
                    'description' => 'b',
                    'safety' => 'read',
                    'source' => ['type' => 'openapi', 'operationId' => 'b', 'method' => 'GET', 'path' => '/b'],
                    'inputSchema' => ['type' => 'object', 'properties' => new \stdClass(), 'additionalProperties' => false],
                    'responseSchemaRef' => null,
                ],
            ],
        ], JSON_THROW_ON_ERROR));

        $catalog = new MergedCatalog(new JsonToolCatalog($dupCatalog));
        $server = new StdioMcpServer(
            $catalog,
            new RecordingHttpClient(new McpHttpResponse(200, [], '{}')),
            'http://stub',
            [],
        );

        $response = $server->handle([
            'jsonrpc' => '2.0',
            'id' => 6,
            'method' => 'tools/list',
            'params' => [],
        ]);

        self::assertSame(-32603, $response['error']['code']);
        self::assertStringContainsString('duplicated', $response['error']['message']);
    }

    /** @internal */
    private function createServer(?string $fixturePath): StdioMcpServer
    {
        $catalog = new MergedCatalog(
            $fixturePath !== null ? new JsonToolCatalog($fixturePath) : null,
        );

        return new StdioMcpServer(
            $catalog,
            new RecordingHttpClient(new McpHttpResponse(200, [], '{}')),
            'http://stub',
            [],
        );
    }
}
