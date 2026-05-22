---
layout: home

hero:
  name: 'nene-mcp'
  text: 'MCP Bridge for NeNe & HTTP APIs'
  tagline: Standalone Composer stdio MCP server — NENE2-compatible tool catalogs, fail-closed write tools, Packagist-ready.
  actions:
    - theme: brand
      text: Get Started →
      link: /tutorial/getting-started
    - theme: alt
      text: Packagist
      link: https://packagist.org/packages/hideyukimori/nene-mcp
    - theme: alt
      text: NENE2 (PHP)
      link: https://hideyukimori.github.io/NENE2/

features:
  - icon: 📦
    title: Composer install
    details: 'composer require hideyukimori/nene-mcp — no NeNe fork. vendor/bin/nene-mcp spawns over stdio for Cursor, Claude Desktop, and other MCP hosts.'

  - icon: 🔌
    title: NENE2-compatible catalogs
    details: Committed docs/mcp/tools.json maps OpenAPI operations to MCP tools. Accepts NENE2_LOCAL_* env aliases for fast alignment.

  - icon: 🛡️
    title: Security defaults
    details: Write tools fail closed without Bearer. No HTTP redirect following. Duplicate catalog names rejected at load time.

  - icon: ⚡
    title: Minimal surface
    details: Built-in nene_mcp_about for Day-0 smoke. Add the catalog when HTTP tools are ready — omit TOOLS_JSON until then.

  - icon: 🔗
    title: Ecosystem aware
    details: PHP runtime in NENE2/NeNe; TypeScript client in nene2-js; MCP stays in this package — not a framework fork.

  - icon: 🔬
    title: Field-trial driven
    details: Quality-first FT methodology with individual reports, PHPUnit, CI regression, and Issue-driven fixes.
---
