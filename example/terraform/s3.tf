# ====================================================
# IAM Policy
# ====================================================
# app iam roleにS3 fullをアタッチ
resource "aws_iam_policy_attachment" "app_iam_role_s3_full" {
  name       = "${var.project}-${var.environment}-app-iam-role-s3-full"
  roles      = [aws_iam_role.app.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}