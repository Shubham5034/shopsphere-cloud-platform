resource "aws_eks_cluster" "shopsphere" {
  name     = "shopsphere-eks"
  role_arn = aws_iam_role.eks_cluster.arn
  version  = "1.35"

  vpc_config {
    subnet_ids = [
      aws_subnet.private["private_1"].id,
      aws_subnet.private["private_2"].id
    ]

    security_group_ids = [
      aws_security_group.eks_cluster.id
    ]

    endpoint_private_access = true
    endpoint_public_access  = true
  }

  tags = {
    Name        = "shopsphere-eks"
    Environment = "dev"
    Project     = "shopsphere"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}

resource "aws_eks_node_group" "shopsphere" {
  cluster_name    = aws_eks_cluster.shopsphere.name
  node_group_name = "shopsphere-workers"
  node_role_arn   = aws_iam_role.eks_nodes.arn

  subnet_ids = [
    aws_subnet.private["private_1"].id,
    aws_subnet.private["private_2"].id
  ]

  instance_types = ["t3.small"]

  capacity_type = "ON_DEMAND"

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  update_config {
    max_unavailable = 1
  }

  tags = {
    Name        = "shopsphere-eks-worker"
    Environment = "dev"
    Project     = "shopsphere"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_ecr_read_only
  ]
}
