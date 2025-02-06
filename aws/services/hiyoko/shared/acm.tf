# ====================================================
# ACM (tokyo)
# ====================================================
resource "aws_acm_certificate" "tokyo" {
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

output "aws_acm_certificate_tokyo_arn" {
  value = aws_acm_certificate.tokyo.arn
}
