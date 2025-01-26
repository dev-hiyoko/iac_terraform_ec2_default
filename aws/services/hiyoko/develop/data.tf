# ====================================================
# prefix list
# ====================================================
data "aws_prefix_list" "s3_lp" {
  # vpcのプレフィックスリストから確認可能
  name = "com.amazonaws.*.s3"
}

# ====================================================
# ami
# ====================================================
# aws ec2 describe-images コマンドで検索
data "aws_ami" "app" {
  most_recent = true
  owners      = ["self", "amazon"]

  filter {
    name   = "name"
    values = [var.app_ami]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ====================================================
# shared
# ====================================================
data "terraform_remote_state" "shared" {
  backend = "local"
  config = {
    path = "../shared/terraform.tfstate"
  }
}
