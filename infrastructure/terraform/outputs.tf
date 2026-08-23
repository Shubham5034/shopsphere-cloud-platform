output "vpc_id" {
  description = "ID of the ShopSphere VPC"
  value       = aws_vpc.shopsphere_vpc.id
}

output "vpc_cidr" {
  description = "CIDR block of the ShopSphere VPC"
  value       = aws_vpc.shopsphere_vpc.cidr_block
}

output "eks_cluster_name" {
  description = "Name of the ShopSphere EKS cluster"
  value       = aws_eks_cluster.shopsphere.name
}

output "eks_cluster_endpoint" {
  description = "Endpoint of the ShopSphere EKS cluster"
  value       = aws_eks_cluster.shopsphere.endpoint
}

output "frontend_ecr_repository_url" {
  description = "ECR repository URL for the ShopSphere frontend"
  value       = aws_ecr_repository.frontend.repository_url
}

output "user_service_ecr_repository_url" {
  description = "ECR repository URL for the ShopSphere user service"
  value       = aws_ecr_repository.user_service.repository_url
}
