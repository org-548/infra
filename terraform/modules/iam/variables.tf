variable "s3_pol_doc_cnt" {
  type    = number
  default = 1
}

variable "s3_pol_sid" {
  default = "S3TrustPolicy"
}

variable "s3_pol_effect" {
  default = "Allow"
}

variable "s3_pol_actions" {
  type = list(string)
  default = [
    "s3:PutObject",
    "s3:GetObject"
  ]
}

variable "s3_pol_principal" {
  type = map(string)
  default = {
    type  = "AWS"
    value = "arn:aws:iam::637423489195:user/terraform-user"
  }
}

variable "s3_pol2_sid" {
  default = "PreventBucketDeletion"
}

variable "s3_pol2_effect" {
  default = "Deny"
}

variable "s3_pol2_action" {
  default = ["s3:DeleteBucket"]
}

variable "bucket_name" {
  default = "tf-backend-f"
}

variable "eks_iam_role_cnt" {
  type    = number
  default = 1
}

variable "eks_role_name" {
  default = "eksClusterRole"
}

variable "node_group_role_vers" {
  default = "2012-10-17"
}

variable "eks_role_action" {
  default = "sts:AssumeRole"
}

variable "eks_role_effect" {
  default = "Allow"
}

variable "eks_role_principal" {
  default = "eks.amazonaws.com"
}

variable "eks_role_attach_cnt" {
  type    = number
  default = 1
}

variable "node_group_role_cnt" {
  type    = number
  default = 1
}

variable "node_group_role_name" {
  default = "node-group-role"
}

variable "node_group_role_action" {
  default = "sts:AssumeRole"
}

variable "node_group_role_effect" {
  default = "Allow"
}

variable "role_service" {
  default = "ec2.amazonaws.com"
}

variable "node_group_policies" {
  type = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]
}

variable "tls_cert_data_cnt" {
  type    = number
  default = 1
}

variable "cluster_identity_issuer" {}

variable "oidc_provider_cnt" {
  type    = number
  default = 1
}

variable "oidc_client_ids" {
  type    = list(string)
  default = ["sts.amazonaws.com"]
}

variable "oidc_primary_trust_policy" {
  type    = number
  default = 1
}

variable "oidc_policy_action" {
  default = "sts:AssumeRoleWithWebIdentity"
}

variable "oidc_policy_effect" {
  default = "Allow"
}

variable "oidc_policy_cnd_test" {
  default = "StringEquals"
}

variable "sa_namespace" {
  default = "somens"
}

variable "sa_name" {
  default = "m-service-account"
}

variable "oidc_principal_type" {
  default = "Federated"
}

variable "oidc_role_cnt" {
  type    = number
  default = 1
}

variable "eks_oidc_role_name" {
  default = "eks-oidc-role"
}

variable "sm_access_policy_cnt" {
  type    = number
  default = 1
}

variable "policy_name" {
  default = "for-access-to-SM"
}

variable "policy_desc" {
  default = "Provide access to AWS Secrets Manager"
}

variable "policy_effect" {
  default = "Allow"
}

variable "policy_action" {
  type = list(string)
  default = [
    "secretsmanager:GetSecretValue",
    "secretsmanager:DescribeSecret"
  ]
}

variable "policy_resource" {
  default = "*"
}

variable "sm_access_attach" {
  type    = number
  default = 1
}

