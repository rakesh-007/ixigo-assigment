variable "region" {
  description = "Region for launching subnets"
  default     = "ap-south-1"
}

variable "profile" {
  description = "Aws Profiles for Infra"
  default     = "ixigo"
}

variable "prod_key_pair_name" {
  default = "ixigo-management"
}

variable "number_of_instances" {
  description = "Number of instance you want to launch"
  default     = "1"
}

variable "jenkins_root_volume_type" {
  description = "Type of the root volume"
  default     = "gp2"
}

variable "jenkins_root_volume_size" {
  description = "Volume size of the root partition"
  default     = "20"
}

variable "ixigo_jenkins_server_name" {
  default = "ixigo-jenkins"
}

variable "ixigo_jenkins_instance_type" {
  default = "t2.micro"
}

variable "ixigo_jenkins_ami_id" {
  default = "ami-042b34111b1289ccd"
}

variable "route53_zone_name" {
  description = "Route53 record zone name"
  default     = "internal.prod.com"
}
