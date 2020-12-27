/*
  Module variables
*/
variable "env" {}
variable "project" {}

variable "default_tags" {
  type = "map"
  default = {}
}

variable "route_zone_name" {}

variable "aws_region" {}

variable "enable_dns_hostnames" {
  description = "Enable Amazon DNS for hostnames in VPC"
  default     = "true"
}

variable "enable_dns_support" {
  description = "Enable Amazon DNS for this subnet"
  default     = "true"
}

variable "vpc_cidr" {
  description = "Network for the entire VPC"
}

variable "pub_subnet_aza_cidr" {}

variable "pub_subnet_azb_cidr" {}

variable "pvt_subnet_aza_cidr" {}

variable "pvt_subnet_azb_cidr" {}

#variable "ami_id" {}

variable "instance_type" {
  default = "t2.nano"
}

variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.

Example: ~/.ssh/terraform.pub
DESCRIPTION
  default = "default.pub"
}

variable "key_name" {
  description = "Desired name of AWS key pair"
  default = "ixigo-nonprod"
}
