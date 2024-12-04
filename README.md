# terraform sample

暫定  
vpc + cloud front + s3 + elb + ec2 + rds + dns(route53) + acm  + sg + iam  
TODO: narikawa 構成図を作成する予定  

## 初期設定

TODO: narikawa tfvarsの利用方法について固める

```shell
cp ./src/terraform.tfvars.example ./src/terraform.tfvars &&\
make git/commit-template
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
5. security group
