# terraform EC2 sample

<!--
TODO narikawa 構成図を作成(Pluralith)
TODO narikawa ローカル、git actions の terraform のバージョン統一方法（github のビルド用のフローが必要？）
TODO narikawa plan apply の運用についての考えをまとめる(varsやtfstateやkeypairの管理方法)
-->

## 動作確認環境

macos/zsh

## 使い方

1. [ディレクトリルールと実行スクリプト](./docs/rule.md)を確認
2. 鍵ファイル生成

   鍵ファイルの作成サンプル

   ```shell
   ssh-keygen -t rsa -b 2048 -f hiyoko-dev-keypair
   mkdir -p ./aws/services/hiyoko/develop/.ssh
   # 鍵ファイルの配置場所は、tfvarsで変更可能
   mv ./hiyoko-dev-keypair ./aws/services/hiyoko/develop/.ssh/hiyoko-dev-keypair.pem
   mv ./hiyoko-dev-keypair.pub ./aws/services/hiyoko/develop/.ssh
   ```

3. 初期設定コマンドの実行

   ```shell
   make init
   ```

4. .gitignore ファイルの設定(任意)

   不要な行を削除

5. .tfstate ファイルの設定(任意)

   tfstate を共有設定する場合、下記を参考に設定する  
   [terraform tfstate](./docs/terraform/tfstate.md)

6. .tfvars ファイルの設定(任意)

   必要な場合作成する(下記参考)
   - [terraform.tfvars.example](./aws/services/hiyoko/develop/terraform.tfvars.example)
   - [variables.tf](./aws/services/hiyoko/develop/variables.tf)

7. db instance ファイルの設定

   RDS か EC2 on MySQL を選択する

   ```shell
   cp ./example/terraform/ec2_mysql.tf ./aws/services/hiyoko/develop/
   # or
   cp ./example/terraform/rds.tf ./aws/services/hiyoko/develop/
   ```

8. 共通環境実行

   ```shell
   make terraform hiyoko shared apply -- -auto-approve
   ```

9. ドメインのネームサーバーをroute53のものに変更する

10. develop環境の実行

   ```shell
   make terraform hiyoko develop apply -- -auto-approve
   ```

11. init/fmt/plan/apply/destroyサンプル

   実行スクリプトのサンプル
   
   ```shell
   make terraform hiyoko shared apply -- -auto-approve
   make terraform hiyoko develop refresh
   make terraform hiyoko develop fmt -- -recursive
   make terraform hiyoko develop plan
   make terraform hiyoko develop apply -- -auto-approve
   make terraform hiyoko develop destroy -- -auto-approve
   ```

12. 構成図生成

   native
   ```shell
   make terraform hiyoko develop graph > ./docs/structure-graph/graph.dot
   ```

## ドキュメント

- [使い方](./docs/rule.md)
- [ブランチルール](./docs/git/branch.md)
- [コミットルール](./docs/git/commit.md)

### 参考

- [terraform 実行環境構築 for docker](./docs/terraform/docker.md)
- [terraform file process](./docs/terraform/process.md)
- [terraform tfstate](./docs/terraform/tfstate.md)
- [サーバー構築(nginx)](./docs/server/nginx.md)

### 公式

- [terraform](https://developer.hashicorp.com/terraform)
- [terraform provider](https://registry.terraform.io/browse/providers)
