#Provides permissions for the Kubernetes control plane to 
#make calls to AWS API operations on your behalf.
resource "aws_iam_role" "for_eks" {
  name = var.eks_role_name

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.for_eks.name
}

data "aws_subnets" "pub" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_eks_cluster" "this" {
  name = var.cluster_name
  #version  = var.eks_version
  role_arn = aws_iam_role.for_eks.arn

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = var.admin_permission
  }

  vpc_config {
    subnet_ids = [for i in data.aws_subnets.pub.ids : i]
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
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = var.role_service
      }
    }]
  })
}

#Provide access to ec2 and eks for worker nodes
resource "aws_iam_role_policy_attachment" "ec2_eks_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.for_node_group.name
}

#Provide permission to VPC CNI for interaction with ENI on your behalf
resource "aws_iam_role_policy_attachment" "eni_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.for_node_group.name
}

#Provide access to ECR
resource "aws_iam_role_policy_attachment" "ecr_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.for_node_group.name
}

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.for_node_group.arn

  #subnet_ids = [for i in data.aws_subnets.pub.ids : i]
  subnet_ids = var.subnets

  capacity_type  = var.node_capacity_type
  instance_types = var.node_instance_type

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  update_config {
    max_unavailable = var.max_unavailable
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
  name = "eks-access-to-s3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "s3:ListAllMyBuckets",
        "s3:GetBucketLocation",
        "s3:DeleteObject",
        "s3:GetObject",
        "s3:GetObjectAcl",
        "s3:PutObject",
        "s3:PutObjectAcl",
        #"s3:ListBucket"
      ]
      Effect   = "Allow"
      Resource = "arn:aws:s3:::*"
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
  name               = "access_to_sm_secret"
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
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = var.policy_effect
        Action   = var.policy_action
        Resource = "*"
        #Resource = var.secret_arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "for_sm_secret" {
  role       = aws_iam_role.for_sm_secret.name
  policy_arn = aws_iam_policy.access_to_secrets_manager.arn
}

output "test_policy_arn" {
  value = aws_iam_role.for_sm_secret.arn
}

#data "aws_iam_policy_document" "prepare_sa_role_binding" {
#  statement {
#    actions = ["sts:AssumeRoleWithWebIdentity"]
#    effect  = "Allow"
#
#    #condition{}
#
#    principals {
#      identifiers = [aws_iam_openid_connect_provider.eks_oidc.arn]
#      type        = "Federated"
#    }
#  }
#}

#resource "aws_iam_role" "test_oidc" {
#  assume_role_policy = data.aws_iam_policy_document.prepare_sa_role_binding.json
#  name               = "test-oidc-role"
#}

#resource "kubernetes_service_account" "s3_sa" {
#  automount_service_account_token = true
#  metadata {
#    name = "for-access-to-s3"
#    namespace = "default"
#    #annotations = {}
#  }
#}
