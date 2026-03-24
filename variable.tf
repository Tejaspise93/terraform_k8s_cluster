variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region to deploy resources"
}

variable "project" {
  type        = string
  default     = "myapp"
  description = "Project name used in resource naming"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Deployment environment"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be dev, staging, or prod."
  }
}

variable "cluster_name" {
  type        = string
  default     = "eks-cluster"
  description = "EKS cluster name"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.cluster_name))
    error_message = "cluster_name must be lowercase alphanumeric and hyphens only."
  }
}

variable "kubernetes_version" {
  type        = string
  default     = "1.29"
  description = "Kubernetes version for the EKS cluster"

  validation {
    condition     = can(regex("^1\\.[0-9]+$", var.kubernetes_version))
    error_message = "kubernetes_version must be in format 1.XX (e.g. 1.29)."
  }
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC"
}