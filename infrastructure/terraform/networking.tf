resource "aws_internet_gateway" "shopsphere_igw" {
  vpc_id = aws_vpc.shopsphere_vpc.id

  tags = {
    Name        = "shopsphere-igw"
    Environment = "dev"
    Project     = "shopsphere"
  }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.shopsphere_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.shopsphere_igw.id
  }

  tags = {
    Name        = "shopsphere-public-rt"
    Environment = "dev"
    Project     = "shopsphere"
  }
}


resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}
