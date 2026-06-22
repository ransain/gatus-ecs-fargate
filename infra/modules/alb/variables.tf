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

variable "alb_tg_ip" {
  type        = string
  description = "the ip of the target groups containers"
}

variable "tg_arn" {
  type        = string
  description = "the arn of the target group to forward to"
}