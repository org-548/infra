resource "aws_iam_role" "for_eks" {
  count = var.eks_iam_role_cnt
  name  = var.eks_role_name

  assume_role_policy = jsonencode({
    Version = var.node_group_role_vers
    Statement = [{
      Action = var.eks_role_action
      Effect = var.eks_role_effect
      Principal = {
        Service = var.eks_role_principal
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  count      = var.eks_role_attach_cnt
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.for_eks[0].name
}


resource "aws_eks_cluster" "this" {
  count    = var.cluster_cnt
  name     = var.cluster_name
  role_arn = aws_iam_role.for_eks[0].arn

  access_config {
    authentication_mode                         = var.cluster_auth_mode
    bootstrap_cluster_creator_admin_permissions = var.admin_permission
  }

  vpc_config {
    subnet_ids = var.subnets
  }
  depends_on = [aws_iam_role_policy_attachment.this[0]]
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
resource "aws_iam_role" "for_node_group" {
  count = var.node_group_role_cnt
  name  = var.node_group_role_name

  assume_role_policy = jsonencode({
    Version = var.node_group_role_vers
    Statement = [{
      Action = var.node_group_role_action
      Effect = var.node_group_role_effect
      Principal = {
        Service = var.role_service
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_eks_access" {
  count      = var.worker_node_policy_attach
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.for_node_group[0].name
}

resource "aws_iam_role_policy_attachment" "eni_access" {
  count      = var.cni_policy_attach
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.for_node_group[0].name
}

resource "aws_iam_role_policy_attachment" "ecr_access" {
  count      = var.ecr_policy_attach
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.for_node_group[0].name
}

resource "aws_eks_node_group" "this" {
  count           = var.node_group_cnt
  cluster_name    = aws_eks_cluster.this[0].name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.for_node_group[0].arn
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

  depends_on = [
    aws_iam_role_policy_attachment.ec2_eks_access[0],
    aws_iam_role_policy_attachment.eni_access[0],
    aws_iam_role_policy_attachment.ecr_access[0]
  ]
}

data "tls_certificate" "for_eks_oidc" {
  count = var.tls_cert_data_cnt
  url   = aws_eks_cluster.this[0].identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "for_eks_oidc" {
  count           = var.oidc_provider_cnt
  client_id_list  = var.oidc_client_ids
  thumbprint_list = [data.tls_certificate.for_eks_oidc[0].certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.this[0].identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "trust_policy" {
  count = var.oidc_primary_trust_policy
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.for_eks_oidc[0].url, "https://", "")}:sub"
      values   = ["system:serviceaccount:somens:m-service-account"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.for_eks_oidc[0].arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "eks_oidc_role" {
  count              = var.oidc_role_cnt
  name               = var.eks_oidc_role_name
  assume_role_policy = data.aws_iam_policy_document.trust_policy[0].json
}

resource "aws_iam_policy" "access_to_secrets_manager" {
  count       = var.sm_access_policy_cnt
  name        = var.policy_name
  description = var.policy_desc

  policy = jsonencode({
    Version = var.node_group_role_vers
    Statement = [
      {
        Effect   = var.policy_effect
        Action   = var.policy_action
        Resource = var.policy_resource
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "for_sm_secret" {
  count      = var.sm_access_attach
  role       = aws_iam_role.eks_oidc_role[0].name
  policy_arn = aws_iam_policy.access_to_secrets_manager[0].arn
}

