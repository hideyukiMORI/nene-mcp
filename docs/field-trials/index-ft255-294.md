# Field Trial Index FT255–FT294

L6 **adversarial / cracking-perspective** band on v0.1.4+. Generated 2026-05-22.

| FT | Status | Report | L6 variant |
| --- | --- | --- | --- |
| 255 | pass | [2026-05-field-trial-255.md](2026-05-field-trial-255.md) | SSRF off-host escape |
| 256 | pass | [2026-05-field-trial-256.md](2026-05-field-trial-256.md) | Bearer bypass / empty token |
| 257 | pass | [2026-05-field-trial-257.md](2026-05-field-trial-257.md) | JSON-RPC fuzz |
| 258 | pass | [2026-05-field-trial-258.md](2026-05-field-trial-258.md) | Path param injection |
| 259 | pass | [2026-05-field-trial-259.md](2026-05-field-trial-259.md) | Secret leak probe |
| 260 | pass | [2026-05-field-trial-260.md](2026-05-field-trial-260.md) | NeNe CSRF write re-attack |
| 261 | pass | [2026-05-field-trial-261.md](2026-05-field-trial-261.md) | Catalog safety mislabel |
| 262 | pass | [2026-05-field-trial-262.md](2026-05-field-trial-262.md) | Query/base URL confusion |
| 263 | pass | [2026-05-field-trial-263.md](2026-05-field-trial-263.md) | SSRF |
| 264 | pass | [2026-05-field-trial-264.md](2026-05-field-trial-264.md) | Bearer bypass |
| 265 | pass | [2026-05-field-trial-265.md](2026-05-field-trial-265.md) | JSON-RPC fuzz |
| 266 | pass | [2026-05-field-trial-266.md](2026-05-field-trial-266.md) | Path injection |
| 267 | pass | [2026-05-field-trial-267.md](2026-05-field-trial-267.md) | Secret leak |
| 268 | pass | [2026-05-field-trial-268.md](2026-05-field-trial-268.md) | NeNe CSRF |
| 269 | pass | [2026-05-field-trial-269.md](2026-05-field-trial-269.md) | Safety mislabel |
| 270 | pass | [2026-05-field-trial-270.md](2026-05-field-trial-270.md) | Query confusion |
| 271 | pass | [2026-05-field-trial-271.md](2026-05-field-trial-271.md) | SSRF |
| 272 | pass | [2026-05-field-trial-272.md](2026-05-field-trial-272.md) | Bearer bypass |
| 273 | pass | [2026-05-field-trial-273.md](2026-05-field-trial-273.md) | JSON-RPC fuzz |
| 274 | pass | [2026-05-field-trial-274.md](2026-05-field-trial-274.md) | Path injection |
| 275 | pass | [2026-05-field-trial-275.md](2026-05-field-trial-275.md) | Secret leak |
| 276 | pass | [2026-05-field-trial-276.md](2026-05-field-trial-276.md) | NeNe CSRF |
| 277 | pass | [2026-05-field-trial-277.md](2026-05-field-trial-277.md) | Safety mislabel |
| 278 | pass | [2026-05-field-trial-278.md](2026-05-field-trial-278.md) | Query confusion |
| 279 | pass | [2026-05-field-trial-279.md](2026-05-field-trial-279.md) | SSRF |
| 280 | pass | [2026-05-field-trial-280.md](2026-05-field-trial-280.md) | Bearer bypass |
| 281 | pass | [2026-05-field-trial-281.md](2026-05-field-trial-281.md) | JSON-RPC fuzz |
| 282 | pass | [2026-05-field-trial-282.md](2026-05-field-trial-282.md) | Path injection |
| 283 | pass | [2026-05-field-trial-283.md](2026-05-field-trial-283.md) | Secret leak |
| 284 | pass | [2026-05-field-trial-284.md](2026-05-field-trial-284.md) | NeNe CSRF |
| 285 | pass | [2026-05-field-trial-285.md](2026-05-field-trial-285.md) | Safety mislabel |
| 286 | pass | [2026-05-field-trial-286.md](2026-05-field-trial-286.md) | Query confusion |
| 287 | pass | [2026-05-field-trial-287.md](2026-05-field-trial-287.md) | SSRF |
| 288 | pass | [2026-05-field-trial-288.md](2026-05-field-trial-288.md) | Bearer bypass |
| 289 | pass | [2026-05-field-trial-289.md](2026-05-field-trial-289.md) | JSON-RPC fuzz |
| 290 | pass | [2026-05-field-trial-290.md](2026-05-field-trial-290.md) | Path injection |
| 291 | pass | [2026-05-field-trial-291.md](2026-05-field-trial-291.md) | Secret leak |
| 292 | pass | [2026-05-field-trial-292.md](2026-05-field-trial-292.md) | NeNe CSRF |
| 293 | pass | [2026-05-field-trial-293.md](2026-05-field-trial-293.md) | Safety mislabel |
| 294 | pass | [2026-05-field-trial-294.md](2026-05-field-trial-294.md) | Query confusion |

## Findings surfaced

| F-ID | Summary | Decision |
| --- | --- | --- |
| F-3 (fixed) | Whitespace-only `NENE_MCP_BEARER_TOKEN` bypassed fail-closed | fix-in-package #64 |
| F-7 | `safety:read` on Bearer-protected POST — no fail-closed, API 401 only | document (defer) |
| NeNe CSRF | Write chain blocked at host | fix-in-host [#380](https://github.com/hideyukiMORI/NeNe/issues/380) |

Batch summary: [`milestone-ft255-294.md`](milestone-ft255-294.md). Post-v0.1.5: [`index-ft296-336.md`](index-ft296-336.md).
