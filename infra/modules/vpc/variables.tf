variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "priv_subnet_cidr" {
  type = set(string)
  default = [ "10.0.0.0/24", "10.0.1.0/24" ]
}

variable "pub_subnet_cidr" {
  type = set(string)
  default = [ "10.0.2.0/24", "10.0.3.0/24" ]
}

variable "app" {
  type = string
  default = "gatus"
}