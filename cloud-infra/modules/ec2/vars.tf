variable "name" {
  description = "Name of the ec2 instance"
}

variable "instance_type" {
  description = "Instance type such as flavors like:- t2.nano,t2.micro"
}

variable "subnet_id" {
  description = "Subnet ID on which you want to launch ec2"
}

variable "number_of_instances" {
  description = "Number of instances you want to launch of this configuration"
  default = "1"
}

variable "key_name" {
  description = "Name of the key that attached to instance to access it"
}

variable "iam_instance_profile" {
  description = "Any special permission via using Instance profile"
  default = ""
}

variable "ami_id" {
  description = "Id of the AMI from which instance should launch"
  default     = "ami-759bc50a"
}

variable "user_data" {
  description = "User data for ec2 instance"
  default = ""
}

variable "root_volume_type" {
  description = "Volume type of root for ec2"
}

variable "root_volume_size" {
  description = "Volume size of root for ec2"
}

variable "security_group_ids" {
  description = "List of security group that you want to associate with ec2"
  type = "list"
}

variable "associate_public_ip_address" {
  description = "Public is enabled or not"
  default = "false"
}

variable "disable_termination" {
  description = "Disable Api Termination"
  default = "false"
}

variable "zone_id" {
  default = ""
}

variable "ebs_optimized" {
  default = "false"
}
