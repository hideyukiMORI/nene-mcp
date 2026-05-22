<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp\Http;

use HideyukiMori\NeneMcp\Exception\McpRuntimeException;

/** Native PHP stream HTTP client suitable for localhost tools. */
final readonly class NativeMcpHttpClient implements McpHttpClientInterface
{
    public function __construct(
        private ?string $bearerToken = null,
        private int $timeoutSeconds = 10,
        private ?string $tlsCaFile = null,
        private ?HttpOperationLoggerInterface $operationLogger = null,
    ) {
    }

    public function get(string $baseUrl, string $path): McpHttpResponse
    {
        return $this->request('GET', $baseUrl, $path, null);
    }

    /** @param array<string, mixed> $body */
    public function post(string $baseUrl, string $path, array $body): McpHttpResponse
    {
        return $this->request('POST', $baseUrl, $path, $body);
    }

    /** @param array<string, mixed> $body */
    public function put(string $baseUrl, string $path, array $body): McpHttpResponse
    {
        return $this->request('PUT', $baseUrl, $path, $body);
    }

    /** @param array<string, mixed> $body */
    public function patch(string $baseUrl, string $path, array $body): McpHttpResponse
    {
        return $this->request('PATCH', $baseUrl, $path, $body);
    }

    public function delete(string $baseUrl, string $path): McpHttpResponse
    {
        return $this->request('DELETE', $baseUrl, $path, null);
    }

    public function hasAuthentication(): bool
    {
        return $this->bearerToken !== null && $this->bearerToken !== '';
    }

    /**
     * @param array<string, mixed>|null $body
     */
    private function request(string $method, string $baseUrl, string $path, ?array $body): McpHttpResponse
    {
        $startedAt = hrtime(true);
        $headers = ['Accept: application/json'];

        if ($this->hasAuthentication()) {
            $headers[] = 'Authorization: Bearer ' . $this->bearerToken;
        }

        $content = null;

        if ($body !== null) {
            $content = json_encode($body, JSON_THROW_ON_ERROR | JSON_UNESCAPED_UNICODE);
            $headers[] = 'Content-Type: application/json';
        }

        $options = [
            'http' => [
                'method' => $method,
                'header' => implode("\r\n", $headers),
                'ignore_errors' => true,
                'timeout' => $this->timeoutSeconds,
                'follow_location' => 0,
                'max_redirects' => 0,
            ],
        ];

        if ($content !== null) {
            $options['http']['content'] = $content;
        }

        $sslOptions = $this->sslContextOptions($baseUrl);

        if ($sslOptions !== null) {
            $options['ssl'] = $sslOptions;
        }

        $context = stream_context_create($options);
        $url = rtrim($baseUrl, '/') . $path;

        $responseBody = @file_get_contents($url, false, $context);

        if ($responseBody === false) {
            $this->logOperation($method, $path, 0, $startedAt);

            throw new McpRuntimeException(sprintf('HTTP request failed for "%s".', $url));
        }

        /** @var list<string> $headerLines */
        $headerLines = [];

        foreach ($http_response_header as $hdr) {
            $headerLines[] = $hdr;
        }

        $response = new McpHttpResponse(
            $this->statusCode($headerLines),
            $this->headers($headerLines),
            $responseBody,
        );

        $this->logOperation($method, $path, $response->statusCode, $startedAt);

        return $response;
    }

    /**
     * @return array<string, bool|string>|null
     */
    private function sslContextOptions(string $baseUrl): ?array
    {
        if ($this->tlsCaFile === null || !str_starts_with(strtolower($baseUrl), 'https://')) {
            return null;
        }

        if (!is_readable($this->tlsCaFile)) {
            throw new McpRuntimeException(sprintf(
                'TLS CA bundle "%s" is not readable. Set NENE_MCP_TLS_CA_FILE to a valid PEM file or unset it.',
                $this->tlsCaFile,
            ));
        }

        return [
            'verify_peer' => true,
            'verify_peer_name' => true,
            'cafile' => $this->tlsCaFile,
        ];
    }

    private function logOperation(string $method, string $path, int $statusCode, int $startedAtNs): void
    {
        if ($this->operationLogger === null) {
            return;
        }

        $durationMs = (int) round((hrtime(true) - $startedAtNs) / 1_000_000);

        $this->operationLogger->log($method, $path, $statusCode, $durationMs);
    }

    /**
     * @param list<string> $responseHeaders
     */
    private function statusCode(array $responseHeaders): int
    {
        if ($responseHeaders === []) {
            throw new McpRuntimeException('HTTP response did not include header lines.');
        }

        $statusLine = $responseHeaders[0] ?? '';

        if (!is_string($statusLine) || preg_match('/\AHTTP\/\S+\s+(\d{3})\b/', $statusLine, $matches) !== 1) {
            throw new McpRuntimeException('HTTP response did not include an HTTP status line.');
        }

        return (int) $matches[1];
    }

    /**
     * @param list<string> $responseHeaders
     *
     * @return array<string, string>
     */
    private function headers(array $responseHeaders): array
    {
        $headers = [];

        foreach ($responseHeaders as $header) {
            if (!str_contains($header, ':')) {
                continue;
            }

            [$name, $value] = explode(':', $header, 2);
            $headers[strtolower(trim($name))] = trim($value);
        }

        return $headers;
    }
}
