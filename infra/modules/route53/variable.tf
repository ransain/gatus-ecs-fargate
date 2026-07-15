variable "subdomain" {
  type        = string
  description = "subdomain name"
}

variable "alb_dns" {
  type        = string
  description = "dns name of the alb"
}

variable "alb_zone" {
  type        = string
  description = "zone id of the alb"
}