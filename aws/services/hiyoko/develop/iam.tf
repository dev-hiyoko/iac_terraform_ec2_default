# ====================================================
# IAM Profile(app)
# ====================================================
resource "aws_iam_instance_profile" "app_ec2_profile" {
  name = aws_iam_role.app.name
  role = aws_iam_role.app.name
}

# ====================================================
# IAM Role(app)
# ====================================================
resource "aws_iam_role" "app" {
  name               = "${var.project}-${var.environment}-app-iam-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy_attachment" "app_ec2_full" {
  name       = "${var.project}-${var.environment}-app-iam-role-ec2-full"
  roles      = [aws_iam_role.app.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_policy_attachment" "app_ssm_managed" {
  name       = "${var.project}-${var.environment}-app-iam-role-ssm-managed"
  roles      = [aws_iam_role.app.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
