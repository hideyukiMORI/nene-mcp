<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp\Bootstrap;

use HideyukiMori\NeneMcp\Exception\McpRuntimeException;
use Throwable;

/**
 * MCP stdio newline JSON-RPC runner.
 */
final class McpStdioLoop
{
    public static function run(?McpEnvironment $environment = null): void
    {
        $environment ??= McpEnvironment::fromGlobals();
        $server = $environment->buildServer();

        while (($line = fgets(STDIN)) !== false) {
            $line = trim($line);

            if ($line === '') {
                continue;
            }

            try {
                /** @var array<string, mixed> $message */
                $message = json_decode($line, true, 512, JSON_THROW_ON_ERROR);

                if (!is_array($message)) {
                    throw new McpRuntimeException('JSON-RPC message must be an object.');
                }

                $response = $server->handle($message);

                if ($response === null) {
                    continue;
                }
            } catch (Throwable $exception) {
                $response = [
                    'jsonrpc' => '2.0',
                    'id' => null,
                    'error' => [
                        'code' => -32700,
                        'message' => $exception->getMessage(),
                    ],
                ];
            }

            fwrite(STDOUT, json_encode($response, JSON_UNESCAPED_SLASHES | JSON_THROW_ON_ERROR) . PHP_EOL);
        }
    }
}
