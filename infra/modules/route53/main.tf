resource "aws_route53_zone" "gatus" {
  name = var.hosted_zone
}

resource "aws_route53_record" "gatus" {
  zone_id = aws_route53_zone.gatus.zone_id
  name = var.hosted_zone
  type = "NS"
  ttl = var.ttl
  records = aws_route53_zone.gatus.name_servers
}