# terraform sample

暫定  
cloud front + s3 + elb + ec2 + rds + dns(route53) + acm  + sg + iam  
TODO: narikawa 構成図を作成する予定  

## 初期設定

```shell
cp ./src/terraform.tfvars.example ./src/terraform.tfvars &&\
make git/commit-template
```

## ドキュメント

- [terraform](https://developer.hashicorp.com/terraform)
- [terraform provider](https://registry.terraform.io/browse/providers)
- [ブランチルール](./docs/git/branch.md)
- [コミットルール](./docs/git/commit.md)
