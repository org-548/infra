variable "secret_name" {
  default = "some-eks-secret"
}

variable "secret_desc" {
  default = "api-addr-url"
}

variable "recovery_days" {
  type    = number
  default = 0
}

variable "secret_tag" {
  default = "some-secret-tag"
}

variable "secret" {
  type = map(string)
  default = {
    address = "somePassword"
  }
}

