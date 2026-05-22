<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp\Tests;

use HideyukiMori\NeneMcp\Http\HttpOperationLoggerInterface;

/** @internal */
final class CollectingHttpOperationLogger implements HttpOperationLoggerInterface
{
    /** @var list<array{method: string, path: string, statusCode: int, durationMs: int}> */
    public array $entries = [];

    public function log(string $method, string $path, int $statusCode, int $durationMs): void
    {
        $this->entries[] = [
            'method' => $method,
            'path' => $path,
            'statusCode' => $statusCode,
            'durationMs' => $durationMs,
        ];
    }
}
