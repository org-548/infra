variable "eks_iam_role_cnt" {
  type    = number
  default = 1
}

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

variable "eks_role_attach_cnt" {
  type    = number
  default = 1
}

#Missing
variable "vpc_id" {}

variable "cluster_cnt" {
  type    = number
  default = 1
}

variable "cluster_name" {
  default = "first-eks"
}

variable "cluster_auth_mode" {
  default = "API"
}

variable "eks_version" {
  default = "1.31"
}

variable "admin_permission" {
  type    = bool
  default = true
}

variable "access_entry_cnt" {
  type    = number
  default = 1
}

variable "user_arn" {
  default = "arn:aws:iam::637423489195:user/terraform-user"
}

variable "type" {
  default = "STANDARD"
}

variable "access_entry_policy_cnt" {
  type    = number
  default = 1
}

variable "access_entry_policy" {
  default = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}

variable "access_scope" {
  default = "cluster"
}

variable "node_group_role_cnt" {
  type    = number
  default = 1
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

variable "worker_node_policy_attach" {
  type    = number
  default = 1
}

variable "cni_policy_attach" {
  type    = number
  default = 1
}

variable "ecr_policy_attach" {
  type    = number
  default = 1
}

variable "node_group_cnt" {
  type    = number
  default = 1
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

variable "tls_cert_data_cnt" {
  type    = number
  default = 1
}

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

variable "secret_arn" {}

variable "eks_cluster_data" {
  type    = number
  default = 1
}

variable "eks_cluster_auth_data" {
  type    = number
  default = 1
}

variable "ex_secret_helm_release" {
  type    = number
  default = 1
}

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

