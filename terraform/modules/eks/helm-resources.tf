data "aws_eks_cluster" "this" {
  count = var.eks_cluster_data
  name  = aws_eks_cluster.this[0].name
}

data "aws_eks_cluster_auth" "this" {
  count      = var.eks_cluster_auth_data
  name       = aws_eks_cluster.this[0].name
  depends_on = [aws_eks_cluster.this[0]]
}

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.this[0].endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.this[0].certificate_authority.0.data)
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

