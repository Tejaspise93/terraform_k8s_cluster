output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "kubeconfig_command" {
  description = "Run this command to configure kubectl"
  value       = "aws eks update-kubeconfig --region ${var.region} --name ${module.eks.cluster_name}"
}

output "node_group_arn" {
  description = "ARN of the EKS managed node group"
  value       = module.eks.node_group_arn
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "eks_admin_access_key_id" {
  description = "Access key ID for eks-admin user"
  value       = module.iam.eks_admin_access_key_id
  sensitive   = true
}

output "eks_admin_secret_access_key" {
  description = "Secret access key for eks-admin user"
  value       = module.iam.eks_admin_secret_access_key
  sensitive   = true
}

output "aws_region" {
  description = "AWS region where resources are deployed"
  value       = var.region
}