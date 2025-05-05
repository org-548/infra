resource "aws_eks_cluster" "this" {
  count    = var.cluster_cnt
  name     = var.cluster_name
  role_arn = var.cluster_role

  access_config {
    authentication_mode                         = var.cluster_auth_mode
    bootstrap_cluster_creator_admin_permissions = var.admin_permission
  }

  vpc_config {
    subnet_ids = var.subnets
  }
  #depends_on = [aws_iam_role_policy_attachment.this[0]]
}

resource "aws_eks_access_entry" "for_local_access" {
  count         = var.access_entry_cnt
  cluster_name  = aws_eks_cluster.this[0].name
  principal_arn = var.user_arn
  type          = var.type
}

resource "aws_eks_access_policy_association" "for_local_access" {
  count         = var.access_entry_policy_cnt
  cluster_name  = aws_eks_cluster.this[0].name
  policy_arn    = var.access_entry_policy
  principal_arn = var.user_arn

  access_scope {
    type = var.access_scope
  }
}

#Node-group configuration
resource "aws_eks_node_group" "this" {
  count           = var.node_group_cnt
  cluster_name    = aws_eks_cluster.this[0].name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_group_role
  subnet_ids      = var.subnets
  capacity_type   = var.node_capacity_type
  instance_types  = var.node_instance_type

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  labels = {
    role = var.node_group_label
  }

#  depends_on = [
#    aws_iam_role_policy_attachment.node_group_access_provision
#  ]

}

