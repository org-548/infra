terraform {
  backend "s3" {
    bucket = "tf-backend-f"
    key    = "terraform/backend/tfstate"
    region = "eu-north-1"
  }
}
