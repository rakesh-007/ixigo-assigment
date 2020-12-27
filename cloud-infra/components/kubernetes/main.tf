provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

module "ixigo-kube" {
    source                      = "../../modules/ec2"
    name                        = "${var.ixigo_kube_server_name}"
    instance_type               = "${var.ixigo_kube_instance_type}"
    subnet_id                   = "${data.terraform_remote_state.core_prod_vpc.app_subnet_a_id}"
    number_of_instances         = "${var.number_of_instances}"
    key_name                    = "${var.prod_key_pair_name}"
    associate_public_ip_address = "false"
    user_data                   = ""
    ami_id                      = "${var.ixigo_kube_ami_id}"
    root_volume_type            = "${var.kube_root_volume_type}"
    root_volume_size            = "${var.kube_root_volume_size}"
    security_group_ids          = ["sg-05440ccc89a2554dd"]
}
