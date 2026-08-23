resource "aws_security_group" "eks_cluster" {
  name        = "shopsphere-eks-cluster-sg"
  description = "Security group for ShopSphere EKS control plane"
  vpc_id      = aws_vpc.shopsphere_vpc.id

  ingress {
    description = "Allow HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "shopsphere-eks-cluster-sg"
    Environment = "dev"
    Project     = "shopsphere"
  }
}


resource "aws_security_group" "eks_nodes" {
  name        = "shopsphere-eks-nodes-sg"
  description = "Security group for ShopSphere EKS worker nodes"
  vpc_id      = aws_vpc.shopsphere_vpc.id

  ingress {
    description = "Allow node-to-node communication"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  ingress {
    description     = "Allow HTTPS from EKS control plane"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.eks_cluster.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "shopsphere-eks-nodes-sg"
    Environment = "dev"
    Project     = "shopsphere"
  }
}
