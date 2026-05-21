<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp\Http;

interface McpHttpClientInterface
{
    public function get(string $baseUrl, string $path): McpHttpResponse;

    /** @param array<string, mixed> $body */
    public function post(string $baseUrl, string $path, array $body): McpHttpResponse;

    /** @param array<string, mixed> $body */
    public function put(string $baseUrl, string $path, array $body): McpHttpResponse;

    /** @param array<string, mixed> $body */
    public function patch(string $baseUrl, string $path, array $body): McpHttpResponse;

    public function delete(string $baseUrl, string $path): McpHttpResponse;

    public function hasAuthentication(): bool;
}
