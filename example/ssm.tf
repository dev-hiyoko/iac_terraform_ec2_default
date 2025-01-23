# ====================================================
# SSM Parameter Store
# ====================================================
resource "aws_ssm_parameter" "host" {
  name  = "/${var.project}/${var.environment}/app/MYSQL_HOST"
  type  = "String"
  value = aws_db_instance.mysql.address
}


# ====================================================
# IAM Policy
# ====================================================
# app iam roleにSSM read onlyをアタッチ
resource "aws_iam_policy_attachment" "app_iam_role_ssm_readonly" {
  name       = "${var.project}-${var.environment}-app-iam-role-ssm-readonly"
  roles      = [aws_iam_role.app.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}