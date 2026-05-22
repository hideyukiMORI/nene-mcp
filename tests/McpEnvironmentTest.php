<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp\Tests;

use HideyukiMori\NeneMcp\Bootstrap\McpEnvironment;
use HideyukiMori\NeneMcp\Bootstrap\McpOperatorConfig;
use PHPUnit\Framework\TestCase;

final class McpEnvironmentTest extends TestCase
{
    protected function tearDown(): void
    {
        putenv('NENE_MCP_BEARER_TOKEN');
        putenv('NENE_MCP_HTTP_TIMEOUT_SEC');
        putenv('NENE_MCP_TLS_CA_FILE');
        putenv('NENE_MCP_LOG');
        parent::tearDown();
    }

    public function testWhitespaceBearerTokenTreatedAsUnset(): void
    {
        putenv('NENE_MCP_BEARER_TOKEN=   ');

        $env = McpEnvironment::fromGlobals();

        self::assertNull($env->bearerToken);
    }

    public function testOperatorConfigFromGlobals(): void
    {
        putenv('NENE_MCP_HTTP_TIMEOUT_SEC=45');
        putenv('NENE_MCP_TLS_CA_FILE=/tmp/custom-ca.pem');
        putenv('NENE_MCP_LOG=stderr');

        $env = McpEnvironment::fromGlobals();

        self::assertSame(45, $env->operatorConfig->httpTimeoutSec);
        self::assertSame('/tmp/custom-ca.pem', $env->operatorConfig->tlsCaFile);
        self::assertTrue($env->operatorConfig->logHttpToStderr);
    }

    public function testRuntimeContextIncludesOperatorFlags(): void
    {
        putenv('NENE_MCP_HTTP_TIMEOUT_SEC=25');
        putenv('NENE_MCP_LOG=stderr');

        $server = McpEnvironment::fromGlobals()->buildServer();
        $response = $server->handle([
            'jsonrpc' => '2.0',
            'id' => 1,
            'method' => 'tools/call',
            'params' => [
                'name' => 'nene_mcp_about',
                'arguments' => [],
            ],
        ]);

        self::assertIsArray($response);
        $runtime = $response['result']['structuredContent']['runtime'];
        self::assertSame(25, $runtime['httpTimeoutSec']);
        self::assertTrue($runtime['httpLogStderr']);
    }
}
