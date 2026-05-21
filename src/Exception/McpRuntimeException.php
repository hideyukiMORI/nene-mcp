<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp\Exception;

use RuntimeException;

/**
 * Thrown when the MCP server cannot process a catalog entry, RPC request, or HTTP proxy call.
 */
final class McpRuntimeException extends RuntimeException
{
}
