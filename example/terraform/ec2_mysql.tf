# ====================================================
# ami
# ====================================================
data "aws_ami" "mysql" {
  most_recent = true
  owners      = ["self", "amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.6.*.0-kernel-6.1-x86_64"]
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
# Security Group (db)
# ====================================================
resource "aws_security_group_rule" "db_out_https" {
  security_group_id = aws_security_group.db_sg.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "db_out_http" {
  security_group_id = aws_security_group.db_sg.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}

# TODO ssh 22ポートをメインインスタンスからのみアクセスできるようにする

# ====================================================
# Network Address Translation Gateway
# ====================================================
resource "aws_route" "public_ngw_main" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.main.id
  depends_on             = [aws_route_table.private_rt]
}

resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "main" {
  subnet_id     = module.vpc_main.public_subnet_ids_by_az[var.availability_zone["a"]]
  allocation_id = aws_eip.nat_eip.id

  tags = {
    Name    = "${var.project}-${var.environment}-ngw-main"
    Project = var.project
    Env     = var.environment
  }
}

# ====================================================
# EC2 mysql instance
# ====================================================
resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!@#$%^&*()_+-="
  min_upper        = 1
  min_lower        = 1
  min_special      = 1
  min_numeric      = 1
}

resource "aws_instance" "mysql" {
  ami               = data.aws_ami.mysql.id
  instance_type     = var.ec2_instance_type
  availability_zone = var.availability_zone["a"]
  subnet_id         = module.vpc_main.private_subnet_ids_by_az[var.availability_zone["a"]]
  vpc_security_group_ids = [
    aws_security_group.db_sg.id,
  ]

  # key_name = aws_key_pair.keypair.key_name
  user_data = templatefile("../user_data/install-mysql.sh", {
    db_user     = var.project
    db_password = random_password.db_password.result
    db_name     = "${var.project}_${var.environment}"
  })

  key_name = aws_key_pair.keypair.key_name

  # user_data実行時にインターネット接続が出来なくなるため
  depends_on = [aws_route.public_ngw_main]

  # TODO narikawa バックアップ設定を追加する

  tags = {
    Name    = "${var.project}-${var.environment}-mysql"
    Project = var.project
    Env     = var.environment
    Type    = "db"
  }
}
