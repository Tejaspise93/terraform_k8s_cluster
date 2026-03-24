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