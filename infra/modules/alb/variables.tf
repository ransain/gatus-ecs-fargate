variable "alb_sg" {
  type        = string
  description = "security group for the ALB"
}

variable "alb_subnet" {
  type        = list(string)
  description = "subnet for the ALB"
}

variable "alb_vpc_id" {
  type        = string
  description = "vpc id"
}

variable "certificate_arn" {
  type        = string
  description = "arn of the certificate of the domain"
}