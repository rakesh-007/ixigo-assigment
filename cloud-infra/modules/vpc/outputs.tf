/*
    Module Outputs
*/

output "vpc_id" {
  value = "${aws_vpc.default.id}"
}

output "internet_gateway_id" {
  value = "${aws_internet_gateway.default.id}"
}

output "public_route_table_id" {
  value = "${aws_route_table.public_rt.id}"
}

output "private_route_table_id" {
  value = "${aws_route_table.private_rt.id}"
}

output "public_subnet_aza_id" {
  value = "${aws_subnet.public-subnet-aza.id}"
}

output "public_subnet_azb_id" {
  value = "${aws_subnet.public-subnet-azb.id}"
}

output "private_subnet_aza_id" {
  value = "${aws_subnet.private-subnet-aza.id}"
}

output "private_subnet_azb_id" {
  value = "${aws_subnet.private-subnet-azb.id}"
}

output "nat_gateway_id" {
  value = "${aws_nat_gateway.default.id}"
}

output "web_security_group_id" {
  value = "${aws_security_group.web-sg.id}"
}

#output "openvpn_security_group_id" {
#  value = "${aws_security_group.openvpn-sg.id}"
#}

#output "openvpn_public_ip" {
#  value = "${aws_eip.openvpn-instance.public_ip}"
#}

#output "route53_zone_name" {
#  value = "${aws_route53_zone.default.id}"
#}

output "internal_loadbalancer_id" {
  value = "${aws_lb.private_alb.id}"
}

output "internal_loadbalancer_arn" {
  value = "${aws_lb.private_alb.arn}"
}

output "internal_loadbalancer_dns_name" {
  value = "${aws_lb.private_alb.dns_name}"
}

output "external_loadbalancer_id" {
  value = "${aws_lb.public_alb.id}"
}

output "external_loadbalancer_arn" {
  value = "${aws_lb.public_alb.arn}"
}

output "external_loadbalancer_dns_name" {
  value = "${aws_lb.public_alb.dns_name}"
}
