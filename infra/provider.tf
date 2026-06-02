terraform {
  required_version = ">=1.15.3"

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "6.45.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "ransain"
    key = "state/terraform.tfstate"
    region = "eu-west-2"
    use_lockfile = true
    encrypt = true
  }
}