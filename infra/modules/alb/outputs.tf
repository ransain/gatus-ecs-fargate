output "alb_arn" {
  description = "arn of the alb"
  value       = aws_alb.gatus_alb.arn
}

output "target_arn" {
  description = "arn of the target group"
  value       = aws_alb_target_group.alb_tg.arn
}

output "alb_dns" {
  description = "dns name of the alb"
  value       = aws_alb.gatus_alb.dns_name
}

output "alb_zone_id" {
  description = "zone id of the alb"
  value       = aws_alb.gatus_alb.zone_id
}