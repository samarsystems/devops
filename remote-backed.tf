terraform {
  backend "s3" {
    bucket  = "samar-terraform-remote-backend"
    key     = "terraform.tfstate"
    profile = "samar-system"
    region  = "us-east-1"
  }
}