data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public" {
  for_each = {
    public_1 = {
      cidr = "10.0.1.0/24"
      az   = data.aws_availability_zones.available.names[0]
    }

    public_2 = {
      cidr = "10.0.2.0/24"
      az   = data.aws_availability_zones.available.names[1]
    }
  }

  vpc_id                  = aws_vpc.shopsphere_vpc.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name        = "shopsphere-${each.key}"
    Environment = "dev"
    Project     = "shopsphere"
    Tier        = "public"
  }
}

resource "aws_subnet" "private" {
  for_each = {
    private_1 = {
      cidr = "10.0.11.0/24"
      az   = data.aws_availability_zones.available.names[0]
    }

    private_2 = {
      cidr = "10.0.12.0/24"
      az   = data.aws_availability_zones.available.names[1]
    }
  }

  vpc_id            = aws_vpc.shopsphere_vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name        = "shopsphere-${each.key}"
    Environment = "dev"
    Project     = "shopsphere"
    Tier        = "private"
  }
}
