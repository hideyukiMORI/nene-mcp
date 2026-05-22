<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp\Tests;

use HideyukiMori\NeneMcp\Exception\McpRuntimeException;
use HideyukiMori\NeneMcp\Http\NativeMcpHttpClient;
use PHPUnit\Framework\TestCase;

final class NativeMcpHttpClientTest extends TestCase
{
    public function testUnreadableTlsCaFileFailsBeforeRequest(): void
    {
        $client = new NativeMcpHttpClient(
            bearerToken: null,
            timeoutSeconds: 10,
            tlsCaFile: '/nonexistent/nene-mcp-ca-' . uniqid('', true) . '.pem',
        );

        $this->expectException(McpRuntimeException::class);
        $this->expectExceptionMessage('TLS CA bundle');

        $client->get('https://127.0.0.1:1', '/health');
    }

    public function testOperationLoggerReceivesSafeMetadataOnly(): void
    {
        $logger = new CollectingHttpOperationLogger();
        $client = new NativeMcpHttpClient(
            bearerToken: 'secret-token-not-logged',
            timeoutSeconds: 5,
            tlsCaFile: null,
            operationLogger: $logger,
        );

        try {
            $client->get('http://127.0.0.1:1', '/health');
        } catch (McpRuntimeException) {
            // Expected when nothing listens on port 1.
        }

        self::assertCount(1, $logger->entries);
        self::assertSame('GET', $logger->entries[0]['method']);
        self::assertSame('/health', $logger->entries[0]['path']);
        self::assertSame(0, $logger->entries[0]['statusCode']);
    }
}
