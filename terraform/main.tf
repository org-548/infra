module "network" {
  source = "./modules/network"
  count  = var.enable_net ? 1 : 0
}

module "ecr" {
  source        = "./modules/ecr"
  count         = var.enable_ecr ? 1 : 0
  #app_unit      = var.app_unit
  ecr_repo_name = var.ecr_repo_name #From .tfvars file
}

module "secrets_manager" {
  source = "./modules/secrets_mng"
  count  = var.enable_secrets_man ? 1 : 0
}

#module "eks" {
#  source = "./modules/eks"
#  #count = var.enable_eks ? 1 : 0
#
#  vpc_id     = module.network[0].vpc_id
#  secret_arn = module.secrets_manager[0].secret_arn
#  #depends_on = [module.secrets_manager[0]]
#}
