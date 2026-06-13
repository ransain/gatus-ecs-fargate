### VPC

resource "aws_vpc" "gatus_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.app}-vpc"
  }
}

### SUBNET

resource "aws_subnet" "pub_sub" {
  count = length(var.cidr_block_pub)

  vpc_id            = aws_vpc.gatus_vpc.id
  availability_zone = var.az[count.index]
  tags = {
    Name = "${var.app}-pub-${count.index}"
  }
  cidr_block = var.cidr_block_pub[count.index]
}

resource "aws_subnet" "priv_sub" {
  count = length(var.cidr_block_priv)

  vpc_id            = aws_vpc.gatus_vpc.id
  availability_zone = var.az[count.index]
  tags = {
    Name = "${var.app}-priv-${count.index}"
  }
  cidr_block = var.cidr_block_priv[count.index]
}

### INTERNET GATEWAY

resource "aws_internet_gateway" "igw" {
  tags = {
    Name = "${var.app}-igw"
  }
}

resource "aws_internet_gateway_attachment" "igw_attachment" {
  vpc_id              = aws_vpc.gatus_vpc.id
  internet_gateway_id = aws_internet_gateway.igw.id
}

### ROUTE TABLE

resource "aws_route_table" "gatus_pub_rt" {
  vpc_id = aws_vpc.gatus_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.app}-rt"
  }
}

resource "aws_route_table_association" "rt_pub" {
  count          = length(var.cidr_block_pub)
  subnet_id      = aws_subnet.pub_sub[count.index].id
  route_table_id = aws_route_table.gatus_pub_rt.id
}