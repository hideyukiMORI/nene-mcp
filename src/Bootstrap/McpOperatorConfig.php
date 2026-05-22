<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp\Bootstrap;

/**
 * Operator-tunable HTTP and diagnostics settings (SMB / staging tier).
 *
 * Parsed from environment in one place; see docs/reference/environment-variables.md.
 */
final readonly class McpOperatorConfig
{
    public const DEFAULT_HTTP_TIMEOUT_SEC = 10;

    public const MIN_HTTP_TIMEOUT_SEC = 1;

    public const MAX_HTTP_TIMEOUT_SEC = 120;

    public function __construct(
        public int $httpTimeoutSec = self::DEFAULT_HTTP_TIMEOUT_SEC,
        public ?string $tlsCaFile = null,
        public bool $logHttpToStderr = false,
    ) {
    }

    public static function fromGlobals(): self
    {
        return new self(
            self::parseHttpTimeoutSec(getenv('NENE_MCP_HTTP_TIMEOUT_SEC')),
            self::parseTlsCaFile(getenv('NENE_MCP_TLS_CA_FILE')),
            self::parseLogHttpToStderr(getenv('NENE_MCP_LOG')),
        );
    }

    /**
     * @param mixed $raw
     */
    public static function parseHttpTimeoutSec(mixed $raw): int
    {
        if (!is_string($raw) || $raw === '') {
            return self::DEFAULT_HTTP_TIMEOUT_SEC;
        }

        if (!ctype_digit($raw)) {
            return self::DEFAULT_HTTP_TIMEOUT_SEC;
        }

        $value = (int) $raw;

        if ($value < self::MIN_HTTP_TIMEOUT_SEC || $value > self::MAX_HTTP_TIMEOUT_SEC) {
            return self::DEFAULT_HTTP_TIMEOUT_SEC;
        }

        return $value;
    }

    /**
     * @param mixed $raw
     */
    public static function parseTlsCaFile(mixed $raw): ?string
    {
        if (!is_string($raw)) {
            return null;
        }

        $trimmed = trim($raw);

        return $trimmed !== '' ? $trimmed : null;
    }

    /**
     * @param mixed $raw
     */
    public static function parseLogHttpToStderr(mixed $raw): bool
    {
        if (!is_string($raw)) {
            return false;
        }

        return strtolower(trim($raw)) === 'stderr';
    }
}
