variable "bucket_cnt" {
  type    = number
  default = 1
}

variable "bucket_name" {
  default = "tf-backend-f"
}

variable "destroy" {
  type        = bool
  default     = true
  description = "In bucket destroy time destroy bucket objects also or not"
}

variable "bucket_tag" {
  default = "Bucket-tag"
}

variable "acl_cnt" {
  type    = number
  default = 1
}

variable "acl" {
  default = "private"
}

variable "expected_owner_id" {
  default = "637423489195"
}

variable "ownership_definiton_cnt" {
  type    = number
  default = 1
}

variable "obj_ownership" {
  default = "BucketOwnerPreferred"
}

variable "access_definition_cnt" {
  type    = number
  default = 1
}

variable "block_public_acls" {
  type    = bool
  default = true
}

variable "block_public_policy" {
  type    = bool
  default = true
}

variable "ignore_public_acls" {
  type    = bool
  default = true
}

variable "restrict_public_buckets" {
  type    = bool
  default = true
}

variable "versioning_res_cnt" {
  type    = number
  default = 0
}

variable "versioning" {
  default = "Enabled"
}

variable "policy_cnt" {
  type    = number
  default = 1
}

variable "s3_policy" {}

