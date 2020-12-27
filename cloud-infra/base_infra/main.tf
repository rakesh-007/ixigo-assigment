provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

module "vpc" {
  source              = "../modules/vpc"
  vpc_cidr            = "${var.vpc_cidr}"
  route_zone_name     = "${var.route53_zone_name}"
  pub_subnet_aza_cidr = "${var.pub_sub_a_cidr}"
  pub_subnet_azb_cidr = "${var.pub_sub_b_cidr}"
  pvt_subnet_aza_cidr = "${var.app_sub_a_cidr}"
  pvt_subnet_azb_cidr = "${var.app_sub_b_cidr}"
  public_key_path     = "~/.ssh/id_rsa.pub"
  project             = "microservices"
  env                 = "nonprod"
  aws_region          = "${var.region}"
}

module "db_sub_a" {
    source                  = "../modules/subnet"
    vpc_id                  = "${module.vpc.vpc_id}"
    cidr                    = "${var.db_sub_a_cidr}"
    az                      = "${var.region}a"
    name                    = "${var.db_sub_a_name}"
    map_public_ip_on_launch = "false"
    project                 = "microservices"
    env                     = "nonprod"
}

module "db_sub_b" {
    source                  = "../modules/subnet"
    vpc_id                  = "${module.vpc.vpc_id}"
    cidr                    = "${var.db_sub_b_cidr}"
    az                      = "${var.region}b"
    name                    = "${var.db_sub_b_name}"
    map_public_ip_on_launch = "false"
    project                 = "microservices"
    env                     = "nonprod"
}

module "db_sn_a_association" {
  source           = "../modules/subnet_association"
  subnet_id        = "${module.db_sub_a.id}"
  route_table_id   = "${module.vpc.private_route_table_id}"
}

module "db_sn_b_association" {
  source           = "../modules/subnet_association"
  subnet_id        = "${module.db_sub_b.id}"
  route_table_id   = "${module.vpc.private_route_table_id}"
}




