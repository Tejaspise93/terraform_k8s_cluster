variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version for the EKS cluster"
}

variable "cluster_role_arn" {
  type        = string
  description = "ARN of the EKS cluster IAM role"
}

variable "node_role_arn" {
  type        = string
  description = "ARN of the EKS node IAM role"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for the EKS cluster and nodes"
}

variable "cluster_sg_id" {
  type        = string
  description = "Security group ID for the EKS control plane"
}

variable "node_sg_id" {
  type        = string
  description = "Security group ID for the EKS worker nodes"
}

variable "node_instance_type" {
  type        = string
  description = "EC2 instance type for EKS worker nodes"
  default     = "t3.micro"
}

variable "eks_admin_arn" {
  type        = string
  description = "ARN of the eks-admin IAM user"
}

variable "name_prefix" {
  type        = string
  description = "Prefix used for naming all resources"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags applied to all resources"
}