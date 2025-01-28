# ====================================================
# ACM
# ====================================================
resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.tokyo.arn
  validation_record_fqdns = [
    for record in aws_route53_record.acm_dns_resolve : record.fqdn
  ]
}

# ====================================================
# Route53
# ====================================================
resource "aws_route53_record" "acm_dns_resolve" {
  for_each = {
    for v in aws_acm_certificate.tokyo.domain_validation_options : v.domain_name => {
      name   = v.resource_record_name
      type   = v.resource_record_type
      record = v.resource_record_value
    }
  }

  allow_overwrite = true
  zone_id         = aws_route53_zone.main.zone_id
  name            = each.value.name
  type            = each.value.type
  records = [each.value.record]
  ttl             = 600
}
