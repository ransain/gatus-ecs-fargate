variable "domain_name" {
  type        = string
  description = "domain name for the acm"
  default     ="www.ransain.com"
}

variable "zone_id" {
  type        = string
  description = "zone id of route 53 hosted zone"
}