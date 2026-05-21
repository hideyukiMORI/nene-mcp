<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp;

use HideyukiMori\NeneMcp\Catalog\JsonToolCatalog;
use HideyukiMori\NeneMcp\Catalog\MergedCatalog;
use HideyukiMori\NeneMcp\Exception\McpRuntimeException;
use HideyukiMori\NeneMcp\Http\McpHttpClientInterface;

/**
 * MCP stdio protocol surface (newline-delimited JSON-RPC) compatible with NENE2 documented local MCP.
 *
 * @phpstan-import-type McpTool from JsonToolCatalog
 */
final readonly class StdioMcpServer
{
    /**
     * @param array<string, mixed> $runtimeContext Metadata for nene_mcp_about only (never secrets).
     */
    public function __construct(
        private MergedCatalog $catalog,
        private McpHttpClientInterface $httpClient,
        private string $apiBaseUrl,
        private array $runtimeContext = [],
    ) {
    }

    /**
     * @param array<string, mixed> $message
     * @return array<string, mixed>|null
     */
    public function handle(array $message): ?array
    {
        $method = $message['method'] ?? null;

        /** @var mixed $id */
        $id = $message['id'] ?? null;

        if (!is_string($method)) {
            return $this->error($id, -32600, 'JSON-RPC request must include a method.');
        }

        if (!array_key_exists('id', $message)) {
            return null;
        }

        try {
            return match ($method) {
                'initialize' => $this->success($id, $this->initializeResult()),
                'tools/list' => $this->success($id, $this->toolsListResult()),
                'tools/call' => $this->success($id, $this->toolsCallResult($message['params'] ?? null)),
                default => $this->error($id, -32601, sprintf('Method "%s" is not supported.', $method)),
            };
        } catch (McpRuntimeException $exception) {
            return $this->error($id, -32603, $exception->getMessage());
        }
    }

    /** @return array<string, mixed> */
    private function initializeResult(): array
    {
        return [
            'protocolVersion' => '2024-11-05',
            'capabilities' => [
                'tools' => [
                    'listChanged' => false,
                ],
            ],
            'serverInfo' => [
                'name' => Package::NAME,
                'version' => Package::VERSION,
            ],
        ];
    }

    /** @return array<string, mixed> */
    private function toolsListResult(): array
    {
        return [
            'tools' => array_map(
                fn (array $tool): array => [
                    'name' => $tool['name'],
                    'title' => $tool['title'],
                    'description' => $tool['description'],
                    'inputSchema' => $this->mcpInputSchema($tool['inputSchema']),
                    'annotations' => [
                        'readOnlyHint' => $tool['safety'] === 'read',
                    ],
                ],
                $this->catalog->tools(),
            ),
        ];
    }

    /** @param array<string, mixed> $schema */
    private function mcpInputSchema(array $schema): array
    {
        if (($schema['properties'] ?? null) === []) {
            $schema['properties'] = new \stdClass();
        }

        return $schema;
    }

    /**
     * @param mixed $params
     * @return array<string, mixed>
     */
    private function toolsCallResult(mixed $params): array
    {
        if (!is_array($params)) {
            throw new McpRuntimeException('tools/call params must be an object.');
        }

        $name = $params['name'] ?? null;
        $arguments = $params['arguments'] ?? [];

        if (!is_string($name) || $name === '') {
            throw new McpRuntimeException('tools/call params.name must be a non-empty string.');
        }

        if (!is_array($arguments)) {
            throw new McpRuntimeException('tools/call params.arguments must be an object when provided.');
        }

        $tool = $this->catalog->find($name);

        if ($tool === null) {
            throw new McpRuntimeException(sprintf('MCP tool "%s" was not found.', $name));
        }

        if (($tool['source']['type'] ?? null) === 'builtin') {
            return $this->builtinToolResult((string) $tool['name'], $arguments);
        }

        if ($tool['safety'] !== 'read' && !$this->httpClient->hasAuthentication()) {
            throw new McpRuntimeException(
                sprintf(
                    'Write tool "%s" requires bearer authentication. Set NENE_MCP_BEARER_TOKEN in the MCP server environment.',
                    $name,
                ),
            );
        }

        if (($tool['source']['type'] ?? null) !== 'openapi') {
            throw new McpRuntimeException(sprintf('MCP tool "%s" does not map to a supported backend.', $name));
        }

        return $this->httpToolResult($tool, $arguments);
    }

    /**
     * @param array<string, mixed> $arguments
     * @return array<string, mixed>
     */
    private function builtinToolResult(string $name, array $arguments): array
    {
        unset($arguments);

        if ($name !== 'nene_mcp_about') {
            throw new McpRuntimeException(sprintf('Builtin tool "%s" is not implemented.', $name));
        }

        $structuredContent = [
            'tool' => $name,
            'packageName' => 'hideyukiMORI/nene-mcp',
            'packageVersion' => Package::VERSION,
            'phpVersion' => PHP_VERSION,
            'runtime' => $this->runtimeContext,
        ];

        return [
            'content' => [
                [
                    'type' => 'text',
                    'text' => json_encode($structuredContent, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES | JSON_THROW_ON_ERROR),
                ],
            ],
            'structuredContent' => $structuredContent,
            'isError' => false,
        ];
    }

    /**
     * @param McpTool              $tool
     * @param array<string, mixed> $arguments
     * @return array<string, mixed>
     */
    private function httpToolResult(array $tool, array $arguments): array
    {
        $source = $tool['source'];
        /** @phpstan-ignore offsetAccess.invalidOffset */
        $pathTpl = $source['path'];

        [$path, $remainingArgs] = $this->interpolatePath(is_string($pathTpl) ? $pathTpl : '', $arguments);

        /** @phpstan-ignore offsetAccess.invalidOffset */
        $method = is_string($source['method'] ?? null) ? $source['method'] : '';

        $response = match ($method) {
            'GET'    => $this->httpClient->get($this->apiBaseUrl, $this->appendQuery($path, $remainingArgs)),
            'POST'   => $this->httpClient->post($this->apiBaseUrl, $path, $remainingArgs),
            'PUT'    => $this->httpClient->put($this->apiBaseUrl, $path, $remainingArgs),
            'PATCH'  => $this->httpClient->patch($this->apiBaseUrl, $path, $remainingArgs),
            'DELETE' => $this->httpClient->delete($this->apiBaseUrl, $path),
            default  => throw new McpRuntimeException(sprintf('HTTP method "%s" is not supported.', $method)),
        };

        $body = $this->decodeBody($response->body);

        $structuredContent = [
            'tool' => $tool['name'],
            'operationId' => $source['operationId'],
            'statusCode' => $response->statusCode,
            'requestId' => $response->requestId(),
            'body' => $body,
        ];

        return [
            'content' => [
                [
                    'type' => 'text',
                    'text' => json_encode($structuredContent, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES | JSON_THROW_ON_ERROR),
                ],
            ],
            'structuredContent' => $structuredContent,
            'isError' => !$response->isSuccessful(),
        ];
    }

    /**
     * @param array<string, mixed> $arguments
     * @return array{string, array<string, mixed>}
     */
    private function interpolatePath(string $path, array $arguments): array
    {
        preg_match_all('/\{([^}]+)\}/', $path, $matches);
        /** @var list<string> $pathParams */
        $pathParams = $matches[1];

        $remaining = $arguments;

        foreach ($pathParams as $param) {
            if (!array_key_exists($param, $arguments)) {
                throw new McpRuntimeException(sprintf('Required path parameter "%s" was not provided.', $param));
            }

            $replacement = rawurlencode((string) $arguments[$param]);

            $path = str_replace('{' . $param . '}', $replacement, $path);
            unset($remaining[$param]);
        }

        return [$path, $remaining];
    }

    /** @param array<string, mixed> $queryArgs */
    private function appendQuery(string $path, array $queryArgs): string
    {
        if ($queryArgs === []) {
            return $path;
        }

        return $path . '?' . http_build_query($queryArgs);
    }

    private function decodeBody(string $body): mixed
    {
        try {
            return json_decode($body, true, 512, JSON_THROW_ON_ERROR);
        } catch (\JsonException) {
            return $body;
        }
    }

    /**
     * @param mixed                $id
     * @param array<string, mixed> $result
     * @return array<string, mixed>
     */
    private function success(mixed $id, array $result): array
    {
        return [
            'jsonrpc' => '2.0',
            'id' => $id,
            'result' => $result,
        ];
    }

    /**
     * @param mixed $id
     * @return array<string, mixed>
     */
    private function error(mixed $id, int $code, string $message): array
    {
        return [
            'jsonrpc' => '2.0',
            'id' => $id,
            'error' => [
                'code' => $code,
                'message' => $message,
            ],
        ];
    }
}
