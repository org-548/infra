variable "ecr_cnt" {
  type        = number
  default     = 2
  description = "Count of ECR repository"
}

variable "ecr_repo_name" {
  type    = list(string)
  default = ["server-repo", "client-repo"]
}

variable "force_delete" {
  type    = bool
  default = true
}

variable "mutability" {
  default = "MUTABLE"
}

