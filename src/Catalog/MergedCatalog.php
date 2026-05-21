<?php

declare(strict_types=1);

namespace HideyukiMori\NeneMcp\Catalog;

/** @phpstan-import-type McpTool from JsonToolCatalog */
final class MergedCatalog
{
    /**
     * @param ?JsonToolCatalog $jsonCatalog null when optional catalog path omitted
     */
    public function __construct(
        private readonly ?JsonToolCatalog $jsonCatalog,
    ) {
    }

    /**
     * Builtin tools precede catalog tools so accidental name collisions favour builtins.
     *
     * @return list<McpTool>
     */
    public function tools(): array
    {
        return array_merge(
            BuiltinCatalog::tools(),
            $this->jsonCatalog !== null ? $this->jsonCatalog->tools() : [],
        );
    }

    /** @return McpTool|null */
    public function find(string $name): ?array
    {
        foreach (BuiltinCatalog::tools() as $tool) {
            if ($tool['name'] === $name) {
                return $tool;
            }
        }

        return $this->jsonCatalog !== null ? $this->jsonCatalog->find($name) : null;
    }
}
