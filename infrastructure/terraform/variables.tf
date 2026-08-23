variable "aws_region" {
  description = "AWS region where ShopSphere infrastructure will be deployed"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the ShopSphere VPC"
  type        = string
  default     = "10.0.0.0/16"
}
