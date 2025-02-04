# ====================================================
# Route53
# ====================================================
resource "aws_route53_zone" "main" {
  name          = var.domain
  force_destroy = false

  tags = {
    Name    = "${var.project}-${var.environment}-route53-zone-main"
    Project = var.project
    Env     = var.environment
  }
}

output "route53_zone_id" {
  value = aws_route53_zone.main.zone_id
}
