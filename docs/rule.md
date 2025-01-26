# ルール

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
│       │   ├── shared/         # 供用
│       │   └── modules/        # モジュール
│       └── <サービス名>/
├── gcp/                        # 任意のクラウド
├── scripts/                    # スクリプトファイル
│   └── run-terraform.zsh       # terraform実行ファイル
└── service_environments.json   # 環境設定ファイル
```

## service_environments.json

サービスや環境を追加する場合、追加する必要がある  
＊ 全ての環境はsharedに依存する  

```json
[
  {
    "name": "<サービス名>",
    "environment": "<env develop|staging|production|shared>",
    "dir": "<terraformのルートディレクトリ>"
  }
]
```

## 実行スクリプト

環境を作成する場合、service_environments.json に追加

```shell
make terraform <service name> <env> <terraform cmd> [EXTRA="<terraform options>"]
```
