data "aws_eks_cluster" "this" {
  name = aws_eks_cluster.this.name
}

data "aws_eks_cluster_auth" "this" {
  name = aws_eks_cluster.this.name
  depends_on = [aws_eks_cluster.this]
}

#provider "helm" {
  #kubernetes {
    #host                   = data.aws_eks_cluster.this.endpoint
    #cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
    #token                  = data.aws_eks_cluster_auth.this.token
  #}
#}

#provider "helm" {
  #kubernetes {
    #host                   = data.aws_eks_cluster.this.endpoint
    #cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
    #exec {
      #api_version = "client.authentication.k8s.io/v1beta1"
      #args        = ["eks", "get-token", "--cluster-name", var.cluster_name, "--output", "json"]
      #command     = "aws"
    #}
  #}
#}


provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.this.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.this.token
    #load_config_file       = false
  }
}

resource "helm_release" "external_secret" {
  name = var.release_name
  repository = var.helm_repo
  chart = var.chart
  namespace = "kube-system"
  #create_namespace = var.create_namespace
  version = var.chart_version
}

#resource "helm_release" "secrets_csi_driver" {
#  name             = var.generic_driver_name
#  repository       = var.generic_driver_repo
#  chart            = var.generic_driver_chart
#  namespace        = "kube-system"
#  #create_namespace = var.create_ns
#  version          = var.version_for_generic
#
#  set {
#    name = var.option
#    value = var.option_value
#  }
#}
#
#resource "helm_release" "driver_aws_provider" {
#  name       = var.specific_deiver_name
#  repository = var.specific_driver_repo
#  chart      = var.specific_driver_chart
#  namespace  = "kube-system"
#  version    = var.version_for_specific
#
#  depends_on = [helm_release.secrets_csi_driver]
#}


