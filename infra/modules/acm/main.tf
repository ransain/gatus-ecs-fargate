resource "aws_acm_certificate" "gatus_cert" {
  domain_name = var.domain_name
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "gatus_valid" {
  certificate_arn = aws_acm_certificate.gatus_cert.arn
}