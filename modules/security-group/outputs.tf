
output "cluster_sg_id" {
  description = "ID of the EKS cluster security group"
  value       = aws_security_group.cluster.id
}

output "node_sg_id" {
  description = "ID of the EKS node security group"
  value       = aws_security_group.node.id
}

output "alb_sg_id" {
  description = "ID of the ALB security group"
  value       = aws_security_group.alb.id
}