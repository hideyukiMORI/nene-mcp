<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp\Http;

use HideyukiMori\NeneMcp\Exception\McpRuntimeException;

/** Native PHP stream HTTP client suitable for localhost tools. */
final readonly class NativeMcpHttpClient implements McpHttpClientInterface
{
    public function __construct(private ?string $bearerToken = null)
    {
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
                'timeout' => 10,
            ],
        ];

        if ($content !== null) {
            $options['http']['content'] = $content;
        }

        $context = stream_context_create($options);
        $url = rtrim($baseUrl, '/') . $path;

        $responseBody = @file_get_contents($url, false, $context);

        $headerLines = [];

        if (isset($http_response_header) && is_array($http_response_header)) {
            foreach ($http_response_header as $hdr) {
                if (is_string($hdr)) {
                    $headerLines[] = $hdr;
                }
            }
        }

        if ($responseBody === false) {
            throw new McpRuntimeException(sprintf('HTTP request failed for "%s".', $url));
        }

        return new McpHttpResponse(
            $this->statusCode($headerLines),
            $this->headers($headerLines),
            $responseBody,
        );
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
