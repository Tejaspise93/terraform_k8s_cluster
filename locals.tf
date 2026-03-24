locals {
  name_prefix = "${var.project}-${var.environment}-${var.region}"

  common_tags = {
    Project     = var.project
    Environment = var.environment
    Region      = var.region
    ManagedBy   = "Terraform"
    Owner       = "devops"
  }
}