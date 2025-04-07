data "aws_eks_cluster" "this" {
  name = aws_eks_cluster.this.name
}

data "aws_eks_cluster_auth" "this" {
  name       = aws_eks_cluster.this.name
  depends_on = [aws_eks_cluster.this]
}

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.this.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.this.token
  }
}

resource "helm_release" "external_secret" {
  name             = var.release_name
  repository       = var.helm_repo
  chart            = var.chart
  namespace        = var.chart_ns
  create_namespace = var.create_ns
  version          = var.chart_version
}

