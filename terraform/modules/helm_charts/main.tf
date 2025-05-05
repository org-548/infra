data "aws_eks_cluster" "this" {
  count = var.eks_cluster_data
  name  = var.cluster_name
}

data "aws_eks_cluster_auth" "this" {
  count      = var.eks_cluster_auth_data
  name       = var.cluster_name
  #depends_on = [aws_eks_cluster.this[0]]
}

#provider "kubernetes" {
#  #config_path = "~/.kube/config"
#  host = data.aws_eks_cluster.this[0].endpoint
#  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this[0].certificate_authority.0.data)
#  token = data.aws_eks_cluster_auth.this[0].token
#}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.this[0].endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this[0].certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.this[0].token
  }
}

resource "helm_release" "external_secret" {
  count            = var.ex_secret_helm_release
  name             = var.release_name
  repository       = var.helm_repo
  chart            = var.chart
  namespace        = var.chart_ns
  create_namespace = var.create_ns
  version          = var.chart_version
}

resource "helm_release" "nginx_ingress_controller" {
  count      = var.ing_ctrl_release
  name       = var.ing_ctrl_release_name
  repository = var.ing_ctrl_chart_repo
  chart      = var.ing_ctrl_chart
  namespace  = var.chart_ns

  set {
    name  = "service.type"
    value = var.nginx_ctrl_service
  }
}

