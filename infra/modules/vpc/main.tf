### VPC

resource "aws_vpc" "gatus_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.app}-vpc"
  }
}

resource "aws_subnet" "pub_sub" {
  count             = length(var.cidr_block_pub)

  vpc_id            = aws_vpc.gatus_vpc.id
  availability_zone = var.az[count.index]
  tags = {
    Name = "${var.app}-pub-${count.index}"
  }
}

resource "aws_subnet" "priv_sub" {
  count             = length(var.cidr_block_priv)

  vpc_id            = aws_vpc.gatus_vpc.id
  availability_zone = var.az[count.index]
  tags = {
    Name = "${var.app}-priv-${count.index}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.gatus_vpc.id
  tags = {
    Name = "${var.app}-igw"
  }
}

### INTERNET GATEWAY

resource "aws_internet_gateway_attachment" "igw_attachment" {
  vpc_id              = aws_vpc.gatus_vpc.id
  internet_gateway_id = aws_internet_gateway.igw.id
}

### ROUTE TABLE

resource "aws_route_table" "gatus_rt" {
  vpc_id = aws_vpc.gatus_vpc.id

  route = {
    cidr_block          = "0.0.0.0/0"
    internet_gateway_id = aws_internet_gateway.igw.id
  }
}