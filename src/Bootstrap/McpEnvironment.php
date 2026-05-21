<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp\Bootstrap;

use HideyukiMori\NeneMcp\Catalog\JsonToolCatalog;
use HideyukiMori\NeneMcp\Catalog\MergedCatalog;
use HideyukiMori\NeneMcp\Http\NativeMcpHttpClient;
use HideyukiMori\NeneMcp\StdioMcpServer;

/**
 * Wires stdin/stdout MCP from environment variables.
 *
 * Compatibility:
 *
 * - NENE_MCP_API_BASE_URL overrides NENE2_LOCAL_API_BASE_URL when either is set.
 * - NENE2_LOCAL_TOOLS_JSON is accepted as an alias for NENE_MCP_TOOLS_JSON.
 */
final class McpEnvironment
{
    /** @var array<string, mixed> */
    private array $context;

    public function __construct(
        public readonly ?string $catalogPath,
        public readonly string $apiBaseUrl,
        public readonly ?string $bearerToken,
    ) {
        $hasBearer = $this->bearerToken !== null && $this->bearerToken !== '';
        $this->context = [
            'catalogPath' => $this->catalogPath,
            'apiBaseUrl' => $this->apiBaseUrl,
            'hasBearerTokenConfigured' => $hasBearer,
        ];
    }

    public static function fromGlobals(): self
    {
        $catalog = getenv('NENE_MCP_TOOLS_JSON');

        if (!is_string($catalog) || $catalog === '') {
            $catalog = getenv('NENE2_LOCAL_TOOLS_JSON');
        }

        $catalogPath = null;

        if (is_string($catalog) && $catalog !== '') {
            $catalogPath = $catalog;
        }

        $base = getenv('NENE_MCP_API_BASE_URL');

        if (!is_string($base) || $base === '') {
            $base = getenv('NENE2_LOCAL_API_BASE_URL');
        }

        if (!is_string($base) || $base === '') {
            $base = 'http://localhost:8080';
        }

        $token = getenv('NENE_MCP_BEARER_TOKEN');

        return new self($catalogPath, $base, is_string($token) && $token !== '' ? $token : null);
    }

    public function buildServer(): StdioMcpServer
    {
        $jsonCatalog = $this->catalogPath !== null ? new JsonToolCatalog($this->catalogPath) : null;
        $merged = new MergedCatalog($jsonCatalog);

        return new StdioMcpServer(
            $merged,
            new NativeMcpHttpClient($this->bearerToken),
            $this->apiBaseUrl,
            $this->context,
        );
    }
}
