# セキュリティモデル

| 制御 | 動作 |
| --- | --- |
| 書き込み | Bearer なし → fail-closed |
| リダイレクト | 追従しない（FT3） |
| 重複 name | 拒否（v0.1.3+） |
| 秘密情報 | env のみ |

[書き込みと Bearer](/ja/howto/write-tools-bearer)
