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

variable "alb_target_group_id" {
  type        = list(string)
  description = "the ip of the target groups containers"
}