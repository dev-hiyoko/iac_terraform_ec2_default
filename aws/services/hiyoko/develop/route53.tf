# ====================================================
# Route53
# ====================================================
resource "aws_route53_record" "record" {
  name    = var.domain
  type    = "A"
  zone_id = data.terraform_remote_state.shared.outputs.route53_zone_id


  alias {
    evaluate_target_health = true
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
  }
}
