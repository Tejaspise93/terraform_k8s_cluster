resource "aws_iam_user" "eks_admin" {
  name          = "${var.name_prefix}-eks-admin"
  force_destroy = true

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-eks-admin"
  })
}

resource "aws_iam_access_key" "eks_admin" {
  user = aws_iam_user.eks_admin.name
}

resource "aws_iam_role" "eks_cluster" {
  name = "${var.name_prefix}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-eks-cluster-role"
  })
}

resource "aws_iam_role" "eks_node" {
  name = "${var.name_prefix}-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-eks-node-role"
  })
}