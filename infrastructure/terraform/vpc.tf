resource "aws_vpc" "shopsphere_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "shopsphere-vpc"
    Environment = "dev"
    Project     = "shopsphere"
  }
}
