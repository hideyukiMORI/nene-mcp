<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp\Http;

/** @internal */
final readonly class McpHttpResponse
{
    /**
     * @param array<string, string> $headers
     */
    public function __construct(
        public int $statusCode,
        public array $headers,
        public string $body,
    ) {
    }

    public function isSuccessful(): bool
    {
        return $this->statusCode >= 200 && $this->statusCode < 300;
    }

    public function requestId(): ?string
    {
        return $this->headers['x-request-id'] ?? null;
    }
}
