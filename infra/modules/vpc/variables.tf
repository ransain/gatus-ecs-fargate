variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}



variable "app" {
  type = string
  default = "gatus"
}

#

variable "subnet" {
  type = map(object({
    cidr = string
    az = string
  }))

  default = {
    "pub_subnet_1" = {
      cidr = "10.0.1.0/24"
      az = "eu-west-2a"
    }

    "priv_subnet_1" = {
      cidr = "10.0.2.0/24"
      az = "eu-west-2a"
    }

    "pub_subnet_2" = {
      cidr = "10.0.3.0/24"
      az = "eu-west-2b"
    }

    "priv_subnet_2" = {
      cidr = "10.0.4.0/24"
      az = "eu-west-2b"
    }

  }
}

# https://spacelift.io/blog/terraform-map-variable
# https://oneuptime.com/blog/post/2026-02-23-how-to-pass-maps-of-objects-as-variables-in-terraform/view
# https://spacelift.io/blog/terraform-functions-expressions-loops#terraform-loops-
# https://spacelift.io/blog/how-to-use-terraform-variables#how-to-use-variables-in-foreach-loop