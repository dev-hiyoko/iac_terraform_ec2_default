# ====================================================
# RDS parameter group
# ====================================================
resource "aws_db_parameter_group" "mysql_parametergroup" {
  name   = "${var.project}-${var.environment}-mysql-parametergroup"
  family = "mysql8.0"

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
}

# ====================================================
# RDS option group
# ====================================================
resource "aws_db_option_group" "mysql_optiongroup" {
  name                 = "${var.project}-${var.environment}-mysql-optiongroup"
  engine_name          = "mysql"
  major_engine_version = "8.0"
}

# ====================================================
# RDS subnet group
# ====================================================
resource "aws_db_subnet_group" "mysql_subnetgroup" {
  name = "${var.project}-${var.environment}-mysql-subnetgroup"
  subnet_ids = [
    module.vpc_main.private_subnet_ids_by_az[var.availability_zone["a"]],
    module.vpc_main.private_subnet_ids_by_az[var.availability_zone["c"]]
  ]

  tags = {
    Name    = "${var.project}-${var.environment}-mysql-subnetgroup"
    Project = var.project
    Env     = var.environment
  }
}

# ====================================================
# RDS instance
# ====================================================
# passwordはtfstateファイルから参照できる
# tfstateにpasswordに載ってしまうので、tfstateファイルにアクセスできる人を管理する必要がある
resource "random_string" "db_password" {
  length  = 16
  special = false
}

# 削除手順
# 1. 削除防止パラメーターの変更→apply
# 2. db_instanceのresourceをコメントアウト→apply
resource "aws_db_instance" "mysql" {
  engine         = "mysql"
  engine_version = "8.0.39"

  identifier = "${var.project}-${var.environment}"
  username   = "admin"
  password   = random_string.db_password.result

  instance_class = "db.t4g.micro"

  allocated_storage     = 20
  max_allocated_storage = 50
  storage_type          = "gp2"
  storage_encrypted     = false

  multi_az               = false
  availability_zone      = var.availability_zone["a"]
  db_subnet_group_name   = aws_db_subnet_group.mysql_subnetgroup.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  publicly_accessible    = false
  port                   = 3306

  name                 = var.project
  parameter_group_name = aws_db_parameter_group.mysql_parametergroup.name
  option_group_name    = aws_db_option_group.mysql_optiongroup.name

  # バックアップ
  backup_window              = "04:00-05:00"
  backup_retention_period    = 7
  maintenance_window         = "Mon:05:00-Mon:08:00"
  auto_minor_version_upgrade = false

  # 削除防止
  deletion_protection = true  // 削除時falseに変更
  skip_final_snapshot = false // 削除時trueに変更
  apply_immediately   = true  // 削除時trueに変更

  tags = {
    Name    = "${var.project}-${var.environment}-mysql"
    Project = var.project
    Env     = var.environment
  }
}
