module "network" {
  source = "./modules/network"
  count  = var.enable_net ? 1 : 0
}

module "s3" {
  source = "./modules/s3"
  count  = var.enable_s3 ? 1 : 0
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
  source = "./modules/eks"

  vpc_id     = module.network[0].vpc_id
  secret_arn = module.secrets_manager[0].secret_arn
  subnets    = module.network[0].subnets_from_data
}
