resource "aws_vpc" "gatus_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "gatus_vpc"
  }
}

resource "aws_subnet" "priv_subnet" {
  vpc_id = aws_vpc.gatus_vpc.id
  cidr_block = var.priv_subnet_cidr[0]
}

resource "aws_subnet" "pub_subnet" {
  vpc_id = aws_vpc.gatus_vpc.id
  cidr_block = var.pub_subnet_cidr[0]
}