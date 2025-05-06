variable "thingy" {}

variable "eks_cluster_data" {
  type    = number
  default = 1
}

variable "cluster_name" {}

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

variable "ing_ctrl_release" {
  type    = number
  default = 1
}

variable "ing_ctrl_release_name" {
  default = "nginx-ingress-controller"
}

variable "ing_ctrl_chart_repo" {
  default = "https://kubernetes.github.io/ingress-nginx"
}

variable "ing_ctrl_chart" {
  default = "ingress-nginx"
}

variable "nginx_ctrl_service" {
  default = "LoadBalancer"
}

