provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

module "ixigo-jenkins" {
    source                      = "../../modules/ec2"
    name                        = "${var.ixigo_jenkins_server_name}_1"
    instance_type               = "${var.ixigo_jenkins_instance_type}"
    subnet_id                   = "${data.terraform_remote_state.core_prod_vpc.app_subnet_a_id}"
    number_of_instances         = "${var.number_of_instances}"
    key_name                    = "${var.prod_key_pair_name}"
    associate_public_ip_address = "false"
    user_data                   = ""
    ami_id                      = "${var.ixigo_jenkins_ami_id}"
    root_volume_type            = "${var.jenkins_root_volume_type}"
    root_volume_size            = "${var.jenkins_root_volume_size}"
    security_group_ids          = ["sg-02439fc3bbcada030"]
}
