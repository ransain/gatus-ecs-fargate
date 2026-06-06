resource "aws_vpc" "gatus_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.app}-vpc"
  }
}

resource "aws_subnet" "gatus_subnet" {
  for_each = var.subnet
  vpc_id = aws_vpc.gatus_vpc.id
  cidr_block = each.value.cidr
  availability_zone = each.value.az
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.gatus_vpc.id
  tags = {
    Name = "${var.app}-igw"
  }
}

add tags to subnets