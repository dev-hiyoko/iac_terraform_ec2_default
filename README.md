# terraform sample

暫定  
vpc + cloud front + s3 + elb + ec2 + rds + dns(route53) + acm + sg + iam  
TODO: narikawa 構成図を作成する予定  
TODO: narikawa やりたいこと、nginx、php 環境を作成までやりたいが、php のバージョンアップが入った際等の対応方法について
TODO: narikawa ソースコードは S3 管理になるのか？（PHP の場合でも、その場合の管理方法について）
TODO: narikawa ソースコードにおいて、git で main にマージされた際にデプロイまで持っていきたい
TODO: narikawa 本 git で pr 時には plan、マージ時には apply を実行したい
TODO: narikawa aws 関連のサービスであった気がする ↑
TODO: narikawa 複数環境の実装方法について(module、atlantis)

## 初期設定

TODO: narikawa tfvars の利用方法について固める

```shell
cp ./src/terraform.tfvars.example ./src/terraform.tfvars &&\
make git/commit-template
chmod +x ./scripts/run-terraform.zsh
```

## 実行スクリプト

zsh のみ作成  
環境を作成する場合、service_environments.json に追加

```shell
./scripts/run-terraform.zsh <terraform cmd> <service name> <env>
```

## ドキュメント

- [terraform](https://developer.hashicorp.com/terraform)
- [terraform provider](https://registry.terraform.io/browse/providers)
- [ブランチルール](./docs/git/branch.md)
- [コミットルール](./docs/git/commit.md)

## 覚書

手順（各種それぞれの役割については、別途調べる必要がありそう）

1. terraform
2. vpc + subnet
3. route table + route table association
4. internet gateway
5. security group()
6. rds(instance, parameter group, subnet group, subnet)
7. ec2
8. terraform(state file)
9. iam
10. parameter store
11. ami
12. elb
13. route53
14. ecm
15. s3
16. cloud front
17. ec2(auto scale)
