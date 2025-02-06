# ====================================================
# bucket(public)
# ====================================================
resource "aws_s3_bucket" "public_static" {
  bucket        = "${var.project}-${var.environment}-static"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "public_static" {
  bucket = aws_s3_bucket.public_static.bucket

  versioning_configuration {
    status = "Disabled"
  }
}

data "aws_iam_policy_document" "public_static" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.public_static.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.cf_s3_origin_access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_static" {
  bucket                  = aws_s3_bucket.public_static.id
  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "public_static" {
  bucket = aws_s3_bucket.public_static.id
  policy = data.aws_iam_policy_document.public_static.json
  depends_on = [
    aws_s3_bucket_public_access_block.public_static,
    aws_s3_bucket_versioning.public_static
  ]
}

# ====================================================
# bucket(private)
# ====================================================
# app iam roleにS3 fullをアタッチ
resource "aws_iam_policy_attachment" "app_iam_role_s3_full" {
  name       = "${var.project}-${var.environment}-app-iam-role-s3-full"
  roles      = [aws_iam_role.app.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_s3_bucket" "public_deploy" {
  bucket        = "${var.project}-${var.environment}-deploy"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "public_deploy" {
  bucket = aws_s3_bucket.public_deploy.bucket

  versioning_configuration {
    status = "Disabled"
  }
}

data "aws_iam_policy_document" "public_deploy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.public_deploy.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.app.arn]
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_deploy" {
  bucket                  = aws_s3_bucket.public_deploy.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "public_deploy" {
  bucket = aws_s3_bucket.public_deploy.id
  policy = data.aws_iam_policy_document.public_deploy.json
  depends_on = [
    aws_s3_bucket_public_access_block.public_deploy,
    aws_s3_bucket_versioning.public_deploy
  ]
}
