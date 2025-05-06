data "aws_iam_policy_document" "access_to_s3" {
  count = var.s3_pol_doc_cnt

  statement {
    sid     = var.s3_pol_sid
    effect  = var.s3_pol_effect
    actions = var.s3_pol_actions
    principals {
      type        = var.s3_pol_principal["type"]
      identifiers = [var.s3_pol_principal["value"]]
    }
    resources = ["arn:aws:s3:::${var.bucket_name}/*"]
  }

  statement {
    sid     = var.s3_pol2_sid
    effect  = var.s3_pol2_effect
    actions = var.s3_pol2_action
    principals {
      type        = var.s3_pol_principal["type"]
      identifiers = [var.s3_pol_principal["value"]]
    }
    resources = ["arn:aws:s3:::${var.bucket_name}"]
  }

}

#EKS trusted role/policy
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

#EKS node-group role/policy
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

resource "aws_iam_role_policy_attachment" "node_group_access_provision" {
  count      = length(var.node_group_policies)
  policy_arn = var.node_group_policies[count.index]
  role       = aws_iam_role.for_node_group[0].name
}

data "tls_certificate" "for_eks_oidc" {
  count = var.tls_cert_data_cnt
  url   = var.cluster_identity_issuer
}

resource "aws_iam_openid_connect_provider" "for_eks_oidc" {
  count           = var.oidc_provider_cnt
  client_id_list  = var.oidc_client_ids
  thumbprint_list = [data.tls_certificate.for_eks_oidc[0].certificates[0].sha1_fingerprint]
  url             = var.cluster_identity_issuer
}

data "aws_iam_policy_document" "trust_policy" {
  count = var.oidc_primary_trust_policy
  statement {
    actions = [var.oidc_policy_action]
    effect  = var.oidc_policy_effect

    condition {
      test     = var.oidc_policy_cnd_test
      variable = "${replace(aws_iam_openid_connect_provider.for_eks_oidc[0].url, "https://", "")}:sub"
      values   = ["system:serviceaccount:${var.sa_namespace}:${var.sa_name}"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.for_eks_oidc[0].arn]
      type        = var.oidc_principal_type
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

