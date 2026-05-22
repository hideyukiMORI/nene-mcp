<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp\Tests;

use HideyukiMori\NeneMcp\Bootstrap\McpEnvironment;
use PHPUnit\Framework\TestCase;

final class McpEnvironmentTest extends TestCase
{
    protected function tearDown(): void
    {
        putenv('NENE_MCP_BEARER_TOKEN');
        parent::tearDown();
    }

    public function testWhitespaceBearerTokenTreatedAsUnset(): void
    {
        putenv('NENE_MCP_BEARER_TOKEN=   ');

        $env = McpEnvironment::fromGlobals();

        self::assertNull($env->bearerToken);
    }
}
