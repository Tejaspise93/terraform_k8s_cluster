variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "name_prefix" {
  type        = string
  description = "Prefix used for naming all resources"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags applied to all resources"
}