<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp\Tests;

use HideyukiMori\NeneMcp\Bootstrap\McpOperatorConfig;
use PHPUnit\Framework\TestCase;

final class McpOperatorConfigTest extends TestCase
{
    public function testDefaultHttpTimeout(): void
    {
        self::assertSame(10, McpOperatorConfig::parseHttpTimeoutSec(null));
        self::assertSame(10, McpOperatorConfig::parseHttpTimeoutSec(''));
        self::assertSame(10, McpOperatorConfig::parseHttpTimeoutSec('abc'));
        self::assertSame(10, McpOperatorConfig::parseHttpTimeoutSec('0'));
        self::assertSame(10, McpOperatorConfig::parseHttpTimeoutSec('999'));
    }

    public function testValidHttpTimeout(): void
    {
        self::assertSame(30, McpOperatorConfig::parseHttpTimeoutSec('30'));
        self::assertSame(1, McpOperatorConfig::parseHttpTimeoutSec('1'));
        self::assertSame(120, McpOperatorConfig::parseHttpTimeoutSec('120'));
    }

    public function testTlsCaFileParsing(): void
    {
        self::assertNull(McpOperatorConfig::parseTlsCaFile(null));
        self::assertNull(McpOperatorConfig::parseTlsCaFile(''));
        self::assertNull(McpOperatorConfig::parseTlsCaFile('   '));
        self::assertSame('/etc/ssl/custom.pem', McpOperatorConfig::parseTlsCaFile('/etc/ssl/custom.pem'));
    }

    public function testLogStderrParsing(): void
    {
        self::assertFalse(McpOperatorConfig::parseLogHttpToStderr(null));
        self::assertFalse(McpOperatorConfig::parseLogHttpToStderr(''));
        self::assertFalse(McpOperatorConfig::parseLogHttpToStderr('stdout'));
        self::assertTrue(McpOperatorConfig::parseLogHttpToStderr('stderr'));
        self::assertTrue(McpOperatorConfig::parseLogHttpToStderr(' STDERR '));
    }
}
