variable "region" {
  type        = string
  description = "region for resources"
  default     = "eu-west-2"
}

variable "target_group_ip" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "hosted_zone" {
  type        = string
  description = "name of hosted zone"
  default     = "www.ransain.com"
}