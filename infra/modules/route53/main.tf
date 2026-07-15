data "aws_route53_zone" "ransain" {
  name = var.subdomain
}

resource "aws_route53_record" "alb" {
  zone_id = data.aws_route53_zone.ransain.zone_id
  name    = var.subdomain
  type    = "A"
  alias {
    name                   = var.alb_dns
    zone_id                = var.alb_zone
    evaluate_target_health = true
  }
}