output "ecr_url" {
  description = "url of the repo"
  value       = data.aws_ecr_repository.ransain.repository_url
}