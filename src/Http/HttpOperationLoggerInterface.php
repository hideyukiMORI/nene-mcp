<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp\Http;

/** Optional per-request diagnostics (must never include secrets or bodies). */
interface HttpOperationLoggerInterface
{
    public function log(string $method, string $path, int $statusCode, int $durationMs): void;
}
