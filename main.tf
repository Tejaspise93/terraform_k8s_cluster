module "vpc" {
  source = "./modules/vpc"

  vpc_cidr           = var.vpc_cidr
  name_prefix        = local.name_prefix
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 3)
  common_tags        = local.common_tags
}

module "security_group" {
  source = "./modules/security-group"

  vpc_id       = module.vpc.vpc_id
  cluster_name = var.cluster_name
  name_prefix  = local.name_prefix
  common_tags  = local.common_tags
}

module "iam" {
  source = "./modules/iam"

  name_prefix = local.name_prefix
  common_tags = local.common_tags
  account_id  = data.aws_caller_identity.current.account_id
}

module "eks" {
  source = "./modules/eks"

  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version
  cluster_role_arn   = module.iam.cluster_role_arn
  node_role_arn      = module.iam.node_role_arn
  private_subnet_ids = module.vpc.private_subnet_ids
  cluster_sg_id      = module.security_group.cluster_sg_id
  node_sg_id         = module.security_group.node_sg_id
  node_instance_type = var.node_instance_type
  eks_admin_arn      = module.iam.eks_admin_arn
  name_prefix        = local.name_prefix
  common_tags        = local.common_tags
}