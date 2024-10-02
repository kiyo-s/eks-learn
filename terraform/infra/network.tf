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
