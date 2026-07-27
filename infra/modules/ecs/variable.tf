variable "container_image" {
  type        = string
  description = "docker image for the task"
}

variable "security_group_id" {
  type        = string
  description = "id of the security group"
}

variable "subnet_id" {
  type        = list(string)
  description = "ids of the private subnets"
}

variable "target_group_arn" {
  type        = string
  description = "arn of the target group associated with the alb"
}