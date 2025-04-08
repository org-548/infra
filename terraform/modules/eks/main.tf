resource "aws_iam_role" "for_eks" {
  name = var.eks_role_name

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
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.for_eks.name
}


resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.for_eks.arn

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = var.admin_permission
  }

  vpc_config {
    subnet_ids = var.subnets
  }
  depends_on = [aws_iam_role_policy_attachment.this]
}

resource "aws_eks_access_entry" "for_local_access" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = var.user_arn
  type          = var.type
}

resource "aws_eks_access_policy_association" "for_local_access" {
  cluster_name  = aws_eks_cluster.this.name
  policy_arn    = var.access_entry_policy
  principal_arn = var.user_arn

  access_scope {
    type = var.access_scope
  }
}

#Node-group configuration
resource "aws_iam_role" "for_node_group" {
  name = var.node_group_role_name

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
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.for_node_group.name
}

resource "aws_iam_role_policy_attachment" "eni_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.for_node_group.name
}

resource "aws_iam_role_policy_attachment" "ecr_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.for_node_group.name
}

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.for_node_group.arn
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
    aws_iam_role_policy_attachment.ec2_eks_access,
    aws_iam_role_policy_attachment.eni_access,
    aws_iam_role_policy_attachment.ecr_access
  ]
}

data "tls_certificate" "eks_oidc" {
  url = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks_oidc" {
  client_id_list  = var.oidc_client_ids
  thumbprint_list = [data.tls_certificate.eks_oidc.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

resource "aws_iam_policy" "access_to_s3" {
  name = var.s3_access_policy_name

  policy = jsonencode({
    Version = var.node_group_role_vers
    Statement = [{
      Action   = var.s3_access_policy_action
      Effect   = var.s3_access_policy_effect
      Resource = var.s3_access_policy_resource
    }]
  })
}

data "aws_iam_policy_document" "access_to_sm" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks_oidc.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:somens:m-service-account"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks_oidc.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "for_sm_secret" {
  name               = var.sm_secret_access_role_name
  assume_role_policy = data.aws_iam_policy_document.access_to_sm.json
}

resource "aws_iam_role_policy_attachment" "oidc_test" {
  role       = aws_iam_role.for_sm_secret.name
  policy_arn = aws_iam_policy.access_to_s3.arn
}

resource "aws_iam_policy" "access_to_secrets_manager" {
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
  role       = aws_iam_role.for_sm_secret.name
  policy_arn = aws_iam_policy.access_to_secrets_manager.arn
}

