<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp\Tests;

use HideyukiMori\NeneMcp\Http\McpHttpClientInterface;
use HideyukiMori\NeneMcp\Http\McpHttpResponse;

/** @internal */
final class RecordingHttpClient implements McpHttpClientInterface
{
    /**
     * @var list<array{0: string, 1: string, 2: string, 3: array<string, mixed>|null}>
     */
    public array $requests = [];

    public function __construct(
        private readonly McpHttpResponse $stub,
        private readonly bool $authenticated = false,
    ) {
    }

    public function get(string $baseUrl, string $path): McpHttpResponse
    {
        $this->requests[] = ['GET', $baseUrl, $path, null];

        return $this->stub;
    }

    /** @param array<string, mixed> $body */
    public function post(string $baseUrl, string $path, array $body): McpHttpResponse
    {
        $this->requests[] = ['POST', $baseUrl, $path, $body];

        return $this->stub;
    }

    /** @param array<string, mixed> $body */
    public function put(string $baseUrl, string $path, array $body): McpHttpResponse
    {
        $this->requests[] = ['PUT', $baseUrl, $path, $body];

        return $this->stub;
    }

    /** @param array<string, mixed> $body */
    public function patch(string $baseUrl, string $path, array $body): McpHttpResponse
    {
        $this->requests[] = ['PATCH', $baseUrl, $path, $body];

        return $this->stub;
    }

    public function delete(string $baseUrl, string $path): McpHttpResponse
    {
        $this->requests[] = ['DELETE', $baseUrl, $path, null];

        return $this->stub;
    }

    public function hasAuthentication(): bool
    {
        return $this->authenticated;
    }
}
