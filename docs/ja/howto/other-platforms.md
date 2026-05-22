# その他プラットフォーム

NENE2 互換カタログがあれば **任意の HTTP API** で同じ stdio ブリッジが使えます。

## PHP / 他言語

Laravel・Symfony・vanilla PHP は `composer require` 後に base URL を設定。Node/Python/Go API では PHP 8.2+ の MCP プロセスをサイドカーとして起動します。

## Pattern B

API は任意言語、MCP だけ PHP — FT7 で検証済みの vanilla bridge パターン。

詳細: [英語版](/howto/other-platforms)（コード例）
