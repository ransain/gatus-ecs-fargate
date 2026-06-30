output "vpc_id" {
  description = "id of the vpc"
  value       = aws_vpc.gatus_vpc.id
}

output "sg_id" {
  description = "id security group for alb"
  value = aws_security_group.sg_http_https.id
}

output "pub_sub_id" {
  description = "id of the public subnet for alb"
  value = aws_subnet.pub_sub.id
}
### fix output for above