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
  default     = "3"
}

variable "kube_root_volume_type" {
  description = "Type of the root volume"
  default     = "gp2"
}

variable "kube_root_volume_size" {
  description = "Volume size of the root partition"
  default     = "20"
}

variable "ixigo_kube_server_name" {
  default = "ixigo-kube"
}

variable "ixigo_kube_instance_type" {
  default = "t3a.medium"
}

variable "ixigo_kube_ami_id" {
  default = "ami-042b34111b1289ccd"
}

variable "route53_zone_name" {
  description = "Route53 record zone name"
  default     = "internal.prod.com"
}
