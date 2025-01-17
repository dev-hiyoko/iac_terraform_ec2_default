# terraform sample

暫定  
vpc + cloud front + s3 + elb + ec2 + rds + dns(route53) + acm + sg + iam  
TODO: narikawa 構成図を作成  
TODO: narikawa terraform のローカル実行環境の構築方法をまとめる（terraform docker に aws vault についてまとめればよさそう）  
TODO: narikawa サーバービルドのサービスについて調べる  
TODO: narikawa code pipeline  
TODO: narikawa 複数環境の実装方法について(atlantis について)  
TODO: narikawa ローカル、git actions の terraform のバージョン統一方法（github のビルド用のフローが必要？）  
TODO: narikawa aws 連携方法についてまとめる(role 系を設定したタイミングで確認したい)  
TODO: narikawa plan apply の運用についての考えをまとめる  
TODO: narikawa git actions の追加（全環境の plan を PR 時に実行「PR 更新時にも実行されるように」）  
TODO: narikawa git actions の追加（本番以外の環境の apply を main に marge 時に実行）  
TODO: narikawa git actions の追加（本番の環境の apply を手動で実行）  
TODO: narikawa .terraform.lock.hcl の取り扱いについて

## 環境

mac os  
zsh shell

## クイックスタート

1. 鍵ファイル生成

   ```shell
   ssh-keygen [-t 鍵の種類] [-b 鍵のビット数(2048以上が推奨)] [-f 鍵のファイル名]
   ```

2. .tfvars の設定

3. 初期設定

   ```shell
   make init
   make git/commit-template
   ```

4. init/fmt/plan/apply/destroy

   ```shell
   make terraform hiyoko develop init
   make terraform hiyoko develop fmt EXTRA="-recursive"
   make terraform hiyoko develop plan
   make terraform hiyoko develop apply EXTRA="-auto-approve"
   make terraform hiyoko develop destroy EXTRA="-auto-approve"
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

- [ディレクトリルール](./docs/terraform/directory.md)
- [ブランチルール](./docs/git/branch.md)
- [コミットルール](./docs/git/commit.md)

### 覚書

- [terraform](https://developer.hashicorp.com/terraform)
- [terraform provider](https://registry.terraform.io/browse/providers)
- [terraform 実行環境構築 for docker](./docs/terraform/docker.md)
- [terraform file process](./docs/terraform/process.md)
