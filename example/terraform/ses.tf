# ====================================================
# SES
# ====================================================
resource "aws_ses_domain_identity" "main" {
  domain = var.domain
}

resource "aws_ses_domain_dkim" "main" {
  domain = var.domain

  depends_on = [
    aws_ses_domain_identity.main
  ]
}

resource "aws_ses_domain_mail_from" "main" {
  domain           = var.domain
  mail_from_domain = "mail.${var.domain}"

  depends_on = [
    aws_ses_domain_identity.main
  ]
}

resource "aws_route53_record" "ses_txt" {
  zone_id = data.terraform_remote_state.shared.outputs.route53_zone_id
  name    = "_amazonses.${var.domain}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.main.verification_token]
}

resource "aws_route53_record" "ses_dkim" {
  count   = 3
  zone_id = data.terraform_remote_state.shared.outputs.route53_zone_id
  name    = "${element(aws_ses_domain_dkim.main.dkim_tokens, count.index)}._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.main.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

resource "aws_route53_record" "ses_spf_mx" {
  zone_id = data.terraform_remote_state.shared.outputs.route53_zone_id
  name    = aws_ses_domain_mail_from.main.mail_from_domain
  type    = "MX"
  ttl     = "600"
  records = ["10 feedback-smtp.ap-northeast-1.amazonses.com"]
}

resource "aws_route53_record" "ses_spf_txt" {
  zone_id = data.terraform_remote_state.shared.outputs.route53_zone_id
  name    = aws_ses_domain_mail_from.main.mail_from_domain
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com ~all"]
}

resource "aws_route53_record" "ses_dmarc" {
  zone_id = data.terraform_remote_state.shared.outputs.route53_zone_id
  name    = "_dmarc.${var.domain}"
  type    = "TXT"
  ttl     = "600"
  records = ["v=DMARC1;p=quarantine;pct=25;rua=mailto:dmarcreports@${var.domain}"]
}