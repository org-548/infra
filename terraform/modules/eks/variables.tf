variable "eks_role_name" {
  default = "eksClusterRole"
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

#Missing
variable "vpc_id" {}

variable "cluster_name" {
  default = "first-eks"
}

variable "eks_version" {
  default = "1.31"
}

variable "admin_permission" {
  type    = bool
  default = true
}

variable "user_arn" {
  default = "arn:aws:iam::637423489195:user/terraform-user"
}

variable "type" {
  default = "STANDARD"
}

variable "access_entry_policy" {
  default = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}

variable "access_scope" {
  default = "cluster"
}

variable "node_group_role_name" {
  default = "node-group-role"
}

variable "node_group_role_vers" {
  default = "2012-10-17"
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

variable "node_group_name" {
  default = "first-node-group"
}

variable "node_capacity_type" {
  default = "ON_DEMAND"
}

#Missing
variable "subnets" {}

variable "node_instance_type" {
  type    = list(string)
  default = ["t3.small"]
}

variable "desired_size" {
  type    = number
  default = 1
}

variable "max_size" {
  type    = number
  default = 2
}

variable "min_size" {
  type    = number
  default = 0
}

variable "max_unavailable" {
  type    = number
  default = 1
}

variable "node_group_label" {
  default = "some-label"
}

variable "oidc_client_ids" {
  type    = list(string)
  default = ["sts.amazonaws.com"]
}

variable "s3_access_policy_name" {
  default = "eks-access-to-s3"
}

variable "s3_access_policy_action" {
  type = list(string)
  default = [
    "s3:ListAllMyBuckets",
    "s3:GetBucketLocation",
    "s3:DeleteObject",
    "s3:GetObject",
    "s3:GetObjectAcl",
    "s3:PutObject",
    "s3:PutObjectAcl"
  ]
}

variable "s3_access_policy_effect" {
  default = "Allow"
}

variable "s3_access_policy_resource" {
  default = "arn:aws:s3:::*"
}

variable "sm_secret_access_role_name" {
  default = "access_to_sm_secret"
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

variable "secret_arn" {}

variable "release_name" {
  default = "external-secrets"
}

variable "helm_repo" {
  default = "https://charts.external-secrets.io"
}

variable "chart" {
  default = "external-secrets"
}

variable "chart_ns" {
  default = "kube-system"
}

variable "create_ns" {
  type    = bool
  default = false
}

variable "chart_version" {
  default = "v0.9.20"
}

