terraform {
  backend "s3" {
    bucket  = "ixigo-nonprod"
    key     = "cloud/jenkins"
    region  = "ap-south-1"
  }
}

data "terraform_remote_state" "core_prod_vpc" {
  backend = "s3"

  config {
    bucket  = "ixigo-nonprod"
    key     = "cloud/base-infra"
    region  = "ap-south-1"
  }
}
