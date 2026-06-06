variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "app" {
  type    = string
  default = "gatus"
}

variable "subnet" {
  type = map(object({
    cidr = string
    az   = string
    name = string
  }))

  default = {
    "pub_subnet_1" = {
      cidr = "10.0.1.0/24"
      az   = "eu-west-2a"
      name = "pub-sub-1"
    }

    "priv_subnet_1" = {
      cidr = "10.0.2.0/24"
      az   = "eu-west-2a"
      name = "priv-sub-1"
    }

    "pub_subnet_2" = {
      cidr = "10.0.3.0/24"
      az   = "eu-west-2b"
      name = "pub-sub-2"
    }

    "priv_subnet_2" = {
      cidr = "10.0.4.0/24"
      az   = "eu-west-2b"
      name = "priv-sub-2"
    }
  }
}