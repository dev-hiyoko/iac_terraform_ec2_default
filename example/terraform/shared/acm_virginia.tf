# ====================================================
# virginia region
# ====================================================
provider "aws" {
  alias   = "virginia"
  profile = "terraform"
  region  = "us-east-1"
}

resource "aws_acm_certificate" "virginia" {
  provider          = aws.virginia
  domain_name       = "*.${var.domain}"
  validation_method = "DNS"

  tags = {
    Name    = "${var.project}-${var.environment}-wikdecard-sslcert"
    Project = var.project
    Env     = var.environment
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_route53_zone.main
  ]
}
