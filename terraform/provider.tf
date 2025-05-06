#terraform {
#  backend "s3" {
#    bucket = "tf-backend-f"
#    key    = "terraform/backend/tfstate"
#    region = "eu-north-1"
#  }
#}

provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  #profile = "default"
}
