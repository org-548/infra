variable "cluster_cnt" {
  type    = number
  default = 1
}

variable "cluster_name" {
  default = "first-eks"
}

variable "cluster_role" {}

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


variable "node_group_cnt" {
  type    = number
  default = 1
}

variable "node_group_name" {
  default = "first-node-group"
}

variable "node_group_role" {}

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

variable "eks_cluster_data" {
  type    = number
  default = 1
}

variable "eks_cluster_auth_data" {
  type    = number
  default = 1
}

