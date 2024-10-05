resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  enable_dns_hostnames = true
  enable_dns_support   = true
}

// Public Subnet
resource "aws_subnet" "public" {
  for_each = { for p in var.public_subnet_configs : p.az => p }

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    Name = "${local.name}-public-${reverse(split("-", each.value.az))[0]}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_eip" "nat_gateway" {
  for_each = { for p in var.public_subnet_configs : p.az => p }

  domain = "vpc"

  tags = {
    Name = "${local.name}-ng-${reverse(split("-", each.value.az))[0]}"
  }
}

resource "aws_nat_gateway" "main" {
  for_each = { for p in var.public_subnet_configs : p.az => p }

  allocation_id = aws_eip.nat_gateway[each.key].id
  subnet_id     = aws_subnet.public[each.key].id

  tags = {
    Name = "${local.name}-${reverse(split("-", each.value.az))[0]}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.name}-public}"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  for_each = { for p in var.public_subnet_configs : p.az => p }

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}

// Private Subnet
resource "aws_subnet" "private" {
  for_each = { for p in var.private_subnet_configs : p.az => p }

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    Name = "${local.name}-private-${reverse(split("-", each.value.az))[0]}"
  }
}
