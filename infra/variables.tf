variable "region" {
  type        = string
  description = "region for resources"
  default     = "eu-west-2"
}

variable "ecr_repo" {
  type    = string
  default = "672461264962.dkr.ecr.eu-west-2.amazonaws.com/gatus"
}