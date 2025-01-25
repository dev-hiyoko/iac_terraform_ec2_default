# terraform EC2 sample

<!--
暫定
TODO: narikawa 構成図を作成
TODO: narikawa terraform のローカル実行環境の構築方法をまとめる（terraform docker に aws vault についてまとめればよさそう）
TODO: narikawa code pipeline
TODO: narikawa 複数環境の実装方法について(atlantis について)
TODO: narikawa ローカル、git actions の terraform のバージョン統一方法（github のビルド用のフローが必要？）
TODO: narikawa aws 連携方法についてまとめる(role 系を設定したタイミングで確認したい)
TODO: narikawa plan apply の運用についての考えをまとめる
TODO: narikawa git actions の追加（全環境の plan を PR 時に実行「PR 更新時にも実行されるように」）
TODO: narikawa git actions の追加（本番以外の環境の apply を main に marge 時に実行）
TODO: narikawa git actions の追加（本番の環境の apply を手動で実行）
TODO: narikawa .terraform.lock.hcl の取り扱いについて(特に github で terraform の apply までやりたい時)
TODO: narikawa クイックスタートを別ファイルに分割し、初期設定を作成
TODO: narikawa keypair の運用方法についてまとめる(特に github で terraform の apply までやりたい時)
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

   必要な場合作成する  
   さらに調整したい場合は、variables.tf を編集する

7. db instance ファイルの設定

   RDS か EC2 on MySQL を選択する

   ```shell
   cp ./example/terraform/ec2_mysql.tf ./aws/services/hiyoko/develop/
   # or
   cp ./example/terraform/rds.tf ./aws/services/hiyoko/develop/
   ```

8. init/fmt/plan/apply/destroy

   実行スクリプトのサンプル

   ```shell
   make terraform hiyoko develop init
   make terraform hiyoko develop refresh
   make terraform hiyoko develop fmt EXTRA="-recursive"
   make terraform hiyoko develop plan
   make terraform hiyoko develop apply EXTRA="-auto-approve"
   make terraform hiyoko develop destroy EXTRA="-auto-approve"
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
