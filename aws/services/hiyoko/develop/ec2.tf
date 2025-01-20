# ====================================================
# EC2 keypair
# ====================================================
# ローカルでキーペアを作成
# ssh-keygen [-t 鍵の種類] [-b 鍵のビット数(2048以上が推奨)] [-f 鍵のファイル名]
# ssh-keygen -t rsa -b 2048 -f hiyoko-dev-keypair
resource "aws_key_pair" "keypair" {
  key_name   = "${var.project}-${var.environment}-keypair"
  public_key = file(var.keypair_relative_path)

  tags = {
    Name    = "${var.project}-${var.environment}-keypair"
    Project = var.project
    Env     = var.environment
  }
}

# ====================================================
# EC2 instance
# ====================================================
# TODO モジュール化
# TODO DBインスタンスを作成
resource "aws_instance" "app" {
  ami                         = data.aws_ami.app.id
  instance_type               = var.ec2_instance_type
  subnet_id                   = module.vpc_main.public_subnet_ids_by_az[var.availability_zone["a"]]
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.app_sg.id,
    aws_security_group.opmng_sg.id
  ]
  key_name = aws_key_pair.keypair.key_name

  tags = {
    Name    = "${var.project}-${var.environment}-app-ec2"
    Project = var.project
    Env     = var.environment
    Type    = "app"
  }
}
