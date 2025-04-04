variable "ecr_cnt" {
  type        = number
  default     = 2
  description = "Count of ECR repository"
}

variable "force_delete" {
  type    = bool
  default = true
}

variable "mutability" {
  default = "MUTABLE"
}

variable "tf_data_dkr_pack" {
  type    = bool
  default = true
}

#Missing
#variable "app_unit" {}

variable "account_id" {
  default = "637423489195"
}

variable "region" {
  default = "eu-north-1"
}

#Missing
variable "ecr_repo_name" {
  type    = list(string)
  default = ["server-repo", "client-repo"]
}

variable "tag" {
  default = "latest"
}

variable "srv_addr" {
  default = ""
}

variable "index" {
  type    = number
  default = 0
}

