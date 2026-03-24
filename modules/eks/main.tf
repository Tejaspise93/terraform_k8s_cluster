resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  version  = var.kubernetes_version
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids              = var.private_subnet_ids
    security_group_ids      = [var.cluster_sg_id]
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  depends_on = [
    var.cluster_role_arn,
  ]

  tags = merge(var.common_tags, {
    Name = var.cluster_name
  })
}

resource "time_sleep" "wait_for_aws_auth" {
  depends_on      = [aws_eks_node_group.main]
  create_duration = "30s"
}

resource "kubernetes_config_map_v1_data" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode([
      {
        rolearn  = var.node_role_arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = ["system:bootstrappers", "system:nodes"]
      }
    ])
    mapUsers = yamlencode([
      {
        userarn  = var.eks_admin_arn
        username = "eks-admin"
        groups   = ["system:masters"]
      }
    ])
  }

  force = true

  depends_on = [time_sleep.wait_for_aws_auth]
}