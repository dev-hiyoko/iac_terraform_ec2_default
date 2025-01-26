terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.84"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}
