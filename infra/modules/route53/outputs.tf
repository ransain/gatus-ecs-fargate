output "zone_id" {
  type        = string
  description = "zone id of the hosted zone"
  value       = data.aws_route53_zone.ransain.zone_id
}