#VPC
variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "Cidr_block value of Vpc"
}

variable "tenancy" {
  default     = "default"
  description = "Specify tenancy type"
}

variable "dns_support" {
  type        = bool
  default     = true
  description = "Enable dns support or not"
}

variable "dns_hostname" {
  type        = bool
  default     = false
  description = "Enable dns hostname or not"
}

variable "addr_usage_metrics" {
  type        = bool
  default     = false
  description = "Enable net-addr usage metrics or not"
}

variable "vpc_tag" {
  default = "Custom VPC"
}

variable "vpc_additional_tag" {
  default = "VPC from tf"
}

variable "vpc_cidr_list" {
  default     = []
  description = "Cidr_block list for Vpc"
}

#Internet Gateway
variable "igw_tag" {
  default = "Custom Internet Gateway"
}

#Subnet section
variable "pub_sub_cnt" {
  type        = number
  default     = 2
  description = "The number of needed Public Subnets"
}

variable "priv_sub_cnt" {
  type        = number
  default     = 0
  description = "The number of needed Private Subnets"
}

variable "av_zones" {
  type    = list(string)
  default = ["eu-north-1a", "eu-north-1b"]
}

variable "map_public_ip" {
  type        = bool
  default     = true
  description = "Map pub-ip for public subnet"
}

variable "only_ipv6" {
  type        = bool
  default     = false
  description = "Create ipv6-only subnet or not"
}

variable "pub_sub_tag" {
  default = "Custom Public Subnet"
}

variable "priv_sub_tag" {
  default = "Custom Private Subnet"
}

#Eip/NAT
variable "eip_cnt" {
  type    = number
  default = 0
}

variable "eip_domain" {
  default = "vpc"
}

variable "eip_tag" {
  default = "Elastic IP"
}

variable "nat_cnt" {
  type    = number
  default = 0
}

variable "nat_tag" {
  default = "NAT Gateway"
}

#Route Table
variable "default_gateway" {
  default = "0.0.0.0/0"
}

variable "rt_pub_tag" {
  default     = "Custom Route table for pub-sub"
  description = "Tag for second RT"
}

variable "rt_priv_tag" {
  default     = "Custom Route table for priv-sub"
  description = "Tag for second RT"
}

variable "priv_rt_cnt" {
  type    = number
  default = 0
}

