resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name        = "shopsphere-nat-eip"
    Environment = "dev"
    Project     = "shopsphere"
  }
}

resource "aws_nat_gateway" "shopsphere_nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public["public_1"].id

  tags = {
    Name        = "shopsphere-nat"
    Environment = "dev"
    Project     = "shopsphere"
  }

  depends_on = [
    aws_internet_gateway.shopsphere_igw
  ]
}

resource "aws_route_table" "private" {
  for_each = aws_subnet.private

  vpc_id = aws_vpc.shopsphere_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.shopsphere_nat.id
  }

  tags = {
    Name        = "shopsphere-${each.key}-rt"
    Environment = "dev"
    Project     = "shopsphere"
    Tier        = "private"
  }
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}
