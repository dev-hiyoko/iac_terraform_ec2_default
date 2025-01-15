# ディレクトリ

ディレクトリ運用ルール

## 構成

```text
root/
├── aws/                        # 任意のクラウド
│   └── services/               # サービス毎に作成
│       ├── <サービス名>/
│       │   ├── develop/        # 環境名
│       │   │   └── main.tf
│       │   ├── staging/        # 環境名
│       │   ├── production/     # 環境名
│       │   └── modules/        # モジュール
│       └── <サービス名>/
├── gcp/                        # 任意のクラウド
├── scripts/                    # スクリプトファイル
│   └── run-terraform.zsh       # terraform実行ファイル
└── service_environments.json   # 環境設定ファイル
```

## service_environments.json

サービスや環境を追加する場合、追加する必要がある

```json
[
  {
    "name": "<サービス名>",
    "environment": "<env develop|staging|production>",
    "dir": "<terraformのルートディレクトリ>"
  }
]
```
