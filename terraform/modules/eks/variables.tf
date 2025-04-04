variable "eks_role_name" {
  default = "eksClusterRole"
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

variable "role_service" {
  default = "ec2.amazonaws.com"
}

variable "node_group_name" {
  default = "first-node-group"
}

variable "node_capacity_type" {
  default = "ON_DEMAND"
}

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

variable "namespace" {
  default = "somens"
}

variable "create_namespace" {
  type    = bool
  default = true
}

variable "chart_version" {
  default = "v0.9.20"
}

variable "generic_driver_name" {
  default = "secrets-store-csi-driver"
}

variable "generic_driver_repo" {
  default = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
}

variable "generic_driver_chart" {
  default = "secrets-store-csi-driver"
}

#variable "namespace" {
#  default = "somens"
#}

variable "create_ns" {
  type    = bool
  default = true
}

variable "version_for_generic" {
  default = "1.4.3"
}

variable "option" {
  default = "syncSecret.enabled"
}

variable "option_value" {
  type    = bool
  default = true
}

variable "specific_deiver_name" {
  default = "secrets-store-csi-driver-aws"
}

variable "specific_driver_repo" {
  default = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
}

variable "specific_driver_chart" {
  default = "secrets-store-csi-driver-provider-aws"
}

variable "version_for_specific" {
  default = "0.3.8"
}


