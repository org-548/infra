variable "enable_net" {
  type    = bool
  default = false
}

variable "enable_s3" {
  type    = bool
  default = false
}

variable "enable_secrets_man" {
  type    = bool
  default = false
}

variable "enable_eks" {
  type    = bool
  default = false
}

variable "enable_ecr" {}

#variable "app_unit" {}

variable "ecr_repo_name" {}
