output "cluster_role_arn" {
  description = "ARN of the EKS cluster IAM role"
  value       = aws_iam_role.eks_cluster.arn
}

output "node_role_arn" {
  description = "ARN of the EKS node IAM role"
  value       = aws_iam_role.eks_node.arn
}

output "node_role_name" {
  description = "Name of the EKS node IAM role"
  value       = aws_iam_role.eks_node.name
}

output "eks_admin_arn" {
  description = "ARN of the eks-admin IAM user"
  value       = aws_iam_user.eks_admin.arn
}

output "eks_admin_access_key_id" {
  description = "Access key ID for eks-admin user"
  value       = aws_iam_access_key.eks_admin.id
  sensitive   = true
}

output "eks_admin_secret_access_key" {
  description = "Secret access key for eks-admin user"
  value       = aws_iam_access_key.eks_admin.secret
  sensitive   = true
}