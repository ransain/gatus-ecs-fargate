output "alb_arn" {
  description = "arn of the alb"
  value       = aws_alb.gatus_alb.arn
}

output "target_arn" {
  description = "arn of the target group"
  value       = aws_alb_target_group.alb_tg.arn
}