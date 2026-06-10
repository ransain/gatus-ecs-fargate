variable "app" {
  type    = string
  default = "gatus"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "cidr_block_pub" {
  type        = list(string)
  description = "cidr values for public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "cidr_block_priv" {
  type        = list(string)
  description = "cidr values for private subnets"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

### Availability Zones

variable "az" {
  type        = list(string)
  description = "availability zones"
  default     = ["eu-west-2a", "eu-west-2b"]
}