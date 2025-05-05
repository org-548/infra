module "network" {
  source = "./modules/network"
  count  = var.enable_net ? 1 : 0
}

module "s3" {
  source    = "./modules/s3"
  count     = var.enable_s3 ? 1 : 0
  s3_policy = module.iam[0].s3_pol_doc_json
}

module "iam" {
  source                  = "./modules/iam"
  count                   = var.enable_iam ? 1 : 0
  cluster_identity_issuer = module.eks.cluster_identity_issuer
}

module "ecr" {
  source = "./modules/ecr"
  count  = var.enable_ecr ? 1 : 0
}

module "secrets_manager" {
  source     = "./modules/secrets_mng"
  count      = var.enable_secrets_man ? 1 : 0
  depends_on = [module.network[0]]
}

module "eks" {
  source          = "./modules/eks"
  subnets         = module.network[0].subnets_from_data
  cluster_role    = module.iam[0].eks_role_arn
  node_group_role = module.iam[0].node_group_role_arn
}

module "helm" {
  source           = "./modules/helm_charts"
  cluster_name = module.eks.cluster_name
}

#Trivial
