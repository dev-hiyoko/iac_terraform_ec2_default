# terraform sample

暫定  
vpc + cloud front + s3 + elb + ec2 + rds + dns(route53) + acm + sg + iam  
TODO: narikawa 構成図を作成する予定  
TODO: narikawa やりたいこと、nginx、php 環境を作成までやりたいが、php のバージョンアップが入った際等の対応方法について
TODO: narikawa ソースコードは S3 管理になるのか？（PHP の場合でも、その場合の管理方法について）
TODO: narikawa ソースコードにおいて、git で main にマージされた際にデプロイまで持っていきたい
TODO: narikawa 複数環境の実装方法について(atlantis)
TODO: narikawa ローカル、gitactions の terraform のバージョン統一方法
TODO: narikawa gitactions の追加（全環境に fmt を追加）
TODO: narikawa gitactions の追加（全環境の plan を PR 時に実行「PR 更新時にも実行されるように」）
TODO: narikawa gitactions の追加（本番以外の環境の apply を main に marge 時に実行）
TODO: narikawa gitactions の追加（本番の環境の apply を手動で実行）

## 環境

mac os  
zsh shell

## 初期設定

TODO: narikawa tfvars の作成方法についてどうするか（makefile で一気に作るようにする？）

```shell
make init
```

## 実行スクリプト

環境を作成する場合、service_environments.json に追加

```shell
make terraform <service name> <env> <terraform cmd> [EXTRA="<terraform options>"]
```

## コミット前確認

fmt の実行

```shell
terraform fmt -recursive
```

## ドキュメント

### 必読(開発する場合)

- [ディレクトリ構成](./docs/terraform/directory.md)
- [ブランチルール](./docs/git/branch.md)
- [コミットルール](./docs/git/commit.md)

### 覚書

- [terraform](https://developer.hashicorp.com/terraform)
- [terraform provider](https://registry.terraform.io/browse/providers)
- [terraform docker](./docs/terraform/docker.md)
- [terraform file process](./docs/terraform/process.md)
