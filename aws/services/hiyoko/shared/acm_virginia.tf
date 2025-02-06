# ====================================================
# virginia region
# ====================================================
provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
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

output "aws_acm_certificate_virginia_arn" {
  value = aws_acm_certificate.virginia.arn
}
