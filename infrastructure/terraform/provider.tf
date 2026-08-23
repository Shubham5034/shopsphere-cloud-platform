terraform {
  required_version = ">= 1.15.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.38"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_eks_cluster" "shopsphere" {
  name = aws_eks_cluster.shopsphere.name
}

data "aws_eks_cluster_auth" "shopsphere" {
  name = aws_eks_cluster.shopsphere.name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.shopsphere.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.shopsphere.certificate_authority[0].data)

  token = data.aws_eks_cluster_auth.shopsphere.token
}
