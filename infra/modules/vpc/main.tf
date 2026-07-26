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
    Name = "${var.app}-pub-${count.index + 1}"
  }
  cidr_block = var.cidr_block_pub[count.index]
}

resource "aws_subnet" "priv_sub" {
  count = length(var.cidr_block_priv)

  vpc_id            = aws_vpc.gatus_vpc.id
  availability_zone = var.az[count.index]
  tags = {
    Name = "${var.app}-priv-${count.index + 1}"
  }
  cidr_block = var.cidr_block_priv[count.index]
}

### INTERNET GATEWAY + NAT

resource "aws_internet_gateway" "igw" {
  tags = {
    Name = "${var.app}-igw"
  }
}

resource "aws_internet_gateway_attachment" "igw_attachment" {
  vpc_id              = aws_vpc.gatus_vpc.id
  internet_gateway_id = aws_internet_gateway.igw.id
}

resource "aws_eip" "nat" {
  count = length(var.az)
  tags = {
    Name = "gatus-nat-eip-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "gatus_nat" {
  count             = length(var.az)
  connectivity_type = "public"
  allocation_id     = aws_eip.nat[count.index].allocation_id
  depends_on        = [aws_internet_gateway.igw]
  subnet_id         = aws_subnet.pub_sub[count.index].id
  tags = {
    Name = "${var.app}-nat-gw-${count.index + 1}"
  }
}

### ROUTE TABLE

resource "aws_route_table" "gatus_pub_rt" {
  vpc_id = aws_vpc.gatus_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.app}-pub-rt"
  }
}

resource "aws_route_table_association" "rt_pub" {
  count          = length(var.cidr_block_pub)
  subnet_id      = aws_subnet.pub_sub[count.index].id
  route_table_id = aws_route_table.gatus_pub_rt.id
}

resource "aws_route_table" "private" {
  count  = length(var.az)
  vpc_id = aws_vpc.gatus_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gatus_nat[count.index].id
  }
  tags = {
    "Name" = "${var.app}-priv-rt-${count.index + 1}"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.cidr_block_priv)
  subnet_id      = aws_subnet.priv_sub[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

# SECURITY GROUP for HTTP and HTTPS

resource "aws_security_group" "sg_http_https" {
  vpc_id = aws_vpc.gatus_vpc.id
  name   = "allow http and https"
  tags = {
    Name = "allow http and https"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http_rule" {
  security_group_id = aws_security_group.sg_http_https.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = "80"
  to_port     = "80"
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "https_rule" {
  security_group_id = aws_security_group.sg_http_https.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = "443"
  to_port     = "443"
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "egress" {
  security_group_id = aws_security_group.sg_http_https.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# SECURITY GROUP FOR ECS

resource "aws_security_group" "ecs_sg" {
  vpc_id = aws_vpc.gatus_vpc.id
  name   = "allow port 8080"
  tags = {
    Name = "allow-port-8080"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ecs_allow" {
  security_group_id = aws_security_group.ecs_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = "8080"
  to_port     = "8080"
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "ecs_outbound" {
  security_group_id = aws_security_group.ecs_sg.id

  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}