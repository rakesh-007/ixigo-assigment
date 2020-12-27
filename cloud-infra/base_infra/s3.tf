terraform {
  backend "s3" {
    bucket  = "ixigo-nonprod"
    key     = "cloud/base-infra"
    region  = "ap-south-1"
  }
}
