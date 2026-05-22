<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp\Http;

/** Writes one safe line per HTTP call to stderr (stdout stays JSON-RPC only). */
final class StderrHttpOperationLogger implements HttpOperationLoggerInterface
{
    public function log(string $method, string $path, int $statusCode, int $durationMs): void
    {
        fwrite(
            STDERR,
            sprintf("[nene-mcp] %s %s status=%d duration_ms=%d\n", $method, $path, $statusCode, $durationMs),
        );
    }
}
