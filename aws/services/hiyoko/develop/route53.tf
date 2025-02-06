# ====================================================
# Route53
# ====================================================
resource "aws_route53_record" "elb_origin" {
  name    = "elb-${var.domain}"
  type    = "A"
  zone_id = data.terraform_remote_state.shared.outputs.route53_zone_id


  alias {
    evaluate_target_health = true
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
  }
}

resource "aws_route53_record" "cf" {
  name    = var.domain
  type    = "A"
  zone_id = data.terraform_remote_state.shared.outputs.route53_zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
  }
}