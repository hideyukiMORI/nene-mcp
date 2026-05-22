# Ferramentas de escrita & Bearer

Entradas `"safety": "write"` exigem **`NENE_MCP_BEARER_TOKEN`** no ambiente MCP.

## Fail-closed

Sem Bearer: erro JSON-RPC, sem HTTP.

## Token

- **API Bearer/JWT**: fluxo normal
- **TODO NeNe**: OpenAPI usa **`sessionCookie`** — [Padrões NeNe](/pt-br/howto/neene-catalog-patterns)
- **Login público como `write`**: Bearer placeholder para fail-closed

## GET protegido (read)

Read com `safety: read` pode retornar **401** se a API exige Bearer — defina env. [Exemplo Bearer-native](/pt-br/howto/bearer-native-bridge-example).

## Rótulo safety vs método HTTP

Fail-closed só quando `safety` ≠ `read`. **POST** com Bearer catalogado como `"safety": "read"` → HTTP sem env Bearer, **401**. Rotas mutantes Bearer: use **`write`**. F-7 / FT262+.

## Relacionado

- [Modelo de segurança](/pt-br/explanation/security-model)
