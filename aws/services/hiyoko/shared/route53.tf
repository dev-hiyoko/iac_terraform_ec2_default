# ====================================================
# Route53
# ====================================================
resource "aws_route53_zone" "main" {
  name          = var.domain
  force_destroy = false

  tags = {
    Name    = "${var.project}-route53-zone-main"
    Project = var.project
  }
}

output "route53_zone_id" {
  value = aws_route53_zone.main.zone_id
}
