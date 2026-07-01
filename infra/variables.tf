variable "region" {
  type        = string
  description = "region for resources"
  default     = "eu-west-2"
}

variable "ecr_repo" {
  type    = string
  default = "672461264962.dkr.ecr.eu-west-2.amazonaws.com/gatus"
}

variable "target_group_ip" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}