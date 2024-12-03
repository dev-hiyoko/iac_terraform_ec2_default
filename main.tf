# TODO narikawa 記述方法が正しいかどうか確認する
# TODO narikawa terraform fmtチェックのactionsを追加する
terraform {
  # TODO: narikawa バージョンを確認する
  required_version = ">= 0.13"
  required_providers {
    # TODO: narikawa バージョンを確認する
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

# TODO: narikawa .envからregionを取得できない？
# TODO: narikawa tfvarsはgit管理しない場合、どうやって生成する？（サンプルファイルでもおいておく？）
provider "aws" {
  profile = "hiyoko-terraform"
  region  = "ap-northeast-1"
}
