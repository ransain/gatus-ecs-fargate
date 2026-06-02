resource "aws_vpc" "gatus_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.app}-vpc"
  }
}

resource "aws_subnet" "pub_subnet" {
  for_each = var.pub_subnet_cidr
  vpc_id = aws_vpc.gatus_vpc.id
  cidr_block = each.value
}

resource "aws_subnet" "priv_subnet" {
  for_each = var.priv_subnet_cidr
  vpc_id = aws_vpc.gatus_vpc.id
  cidr_block = each.value
}


# https://medium.com/@kajals909/terraform-variables-explained-how-to-use-string-number-list-map-boolean-types-part-2-67ad6b844673
# https://oneuptime.com/blog/post/2026-02-23-terraform-for-each-each-key-each-value/view