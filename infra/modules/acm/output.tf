output "acm_id" {
  description = "id of the acm cert"
  value       = aws_acm_certificate.gatus_cert.id
}

output "acm_arn" {
  description = "arn of the acm cert"
  value       = aws_acm_certificate.gatus_cert.arn
}

output "acm_domain" {
  description = "domain of the acm cert"
  value       = aws_acm_certificate.gatus_cert.domain_name
}