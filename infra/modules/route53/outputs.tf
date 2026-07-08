output "zone_id" {
  description = "id of the hosted zone"
  value = aws_route53_zone.gatus.id
}