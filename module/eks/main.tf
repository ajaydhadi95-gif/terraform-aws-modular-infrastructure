# =========================================================
# EKS CLUSTER
# =========================================================

resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.eks_cluster.arn

  # EKS Authentication Configuration
  # Supports EKS Access Entries and aws-auth ConfigMap
  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  # VPC Configuration
  vpc_config {
    subnet_ids = var.private_subnet_ids

    security_group_ids = [
      var.cluster_security_group_id
    ]

    endpoint_private_access = true
    endpoint_public_access  = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]

  tags = {
    Name      = var.cluster_name
    ManagedBy = "Terraform"
  }
}


# =========================================================
# EKS MANAGED NODE GROUP
# =========================================================

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = aws_iam_role.eks_node.arn

  # Worker nodes run in private subnets
  subnet_ids = var.private_subnet_ids

  # Launch Template
  launch_template {
    id      = aws_launch_template.eks_nodes.id
    version = aws_launch_template.eks_nodes.latest_version
  }

  # Capacity Configuration
  capacity_type = "ON_DEMAND"

  # Autoscaling limits
  scaling_config {
    desired_size = var.desired_nodes
    min_size     = var.min_nodes
    max_size     = var.max_nodes
  }

  # Rolling update configuration
  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.ecr_pull_policy
  ]

  tags = {
    Name      = "${var.cluster_name}-node-group"
    ManagedBy = "Terraform"
  }
}
