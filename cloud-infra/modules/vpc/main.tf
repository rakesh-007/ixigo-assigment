resource "aws_vpc" "default" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"

  tags = "${merge(var.default_tags, map(
        "Name", "${var.env}-vpc-${var.project}",
        "Description", "${var.project} VPC"
    ))}"
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"

  tags = "${merge(var.default_tags, map(
        "Name", "${var.project}-${var.env}-internet-gateway",
        "Description", "${var.project}-Internet Gateway"
    ))}"
}

# Route Tables
resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block      = "0.0.0.0/0"
    gateway_id  = "${aws_internet_gateway.default.id}"
  }

  tags = "${merge(var.default_tags, map(
        "Name", "${var.project}-${var.env}-public-route_table",
        "Description", "${var.project}-Public Route Table"
    ))}"
}

resource "aws_route_table" "private_rt" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.default.id}"
  }

  tags = "${merge(var.default_tags, map(
        "Name", "${var.project}-${var.env}-private-route_table",
        "Description", "${var.project}-${var.env}-Private Route Table"
    ))}"
}

# Route table association
resource "aws_main_route_table_association" "main_rta" {
  vpc_id         = "${aws_vpc.default.id}"
  route_table_id = "${aws_route_table.private_rt.id}"
}

resource "aws_route_table_association" "rta_public_aza" {
  subnet_id      = "${aws_subnet.public-subnet-aza.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}

resource "aws_route_table_association" "rta_public_azb" {
  subnet_id      = "${aws_subnet.public-subnet-azb.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}

resource "aws_route_table_association" "rta_private_aza" {
  subnet_id      = "${aws_subnet.private-subnet-aza.id}"
  route_table_id = "${aws_route_table.private_rt.id}"
}

resource "aws_route_table_association" "rta_private_azb" {
  subnet_id      = "${aws_subnet.private-subnet-azb.id}"
  route_table_id = "${aws_route_table.private_rt.id}"
}

# Public Subnets

resource "aws_subnet" "public-subnet-aza" {
  vpc_id            = "${aws_vpc.default.id}"
  availability_zone = "${var.aws_region}a"
  cidr_block        = "${var.pub_subnet_aza_cidr}"

  tags = "${merge(var.default_tags, map(
        "Name", "${var.project}-${var.env}-public-subnet-aza",
        "Description", "${var.project} Public subnet"
    ))}"
}

resource "aws_subnet" "public-subnet-azb" {
  vpc_id            = "${aws_vpc.default.id}"
  availability_zone = "${var.aws_region}b"
  cidr_block        = "${var.pub_subnet_azb_cidr}"

  tags = "${merge(var.default_tags, map(
        "Name", "${var.project}-${var.env}-public-subnet-azb",
        "Description", "${var.project} Public subnet"
    ))}"
}

# Private Subnets
resource "aws_subnet" "private-subnet-aza" {
  vpc_id            = "${aws_vpc.default.id}"
  availability_zone = "${var.aws_region}a"
  cidr_block        = "${var.pvt_subnet_aza_cidr}"

  tags = "${merge(var.default_tags, map(
        "Name", "${var.project}-${var.env}-private-subnet-aza",
        "Description", "${var.project} Private subnet"
    ))}"
}

resource "aws_subnet" "private-subnet-azb" {
  vpc_id            = "${aws_vpc.default.id}"
  availability_zone = "${var.aws_region}b"
  cidr_block        = "${var.pvt_subnet_azb_cidr}"

  tags = "${merge(var.default_tags, map(
        "Name", "${var.project}-${var.env}-private-subnet-azb",
        "Description", "${var.project} Private subnet"
    ))}"
}

resource "aws_eip" "default" {
	vpc	= true
}

resource "aws_nat_gateway" "default" {
  allocation_id = "${aws_eip.default.id}"
  subnet_id     = "${aws_subnet.public-subnet-azb.id}"
	depends_on 		= ["aws_internet_gateway.default"]

  tags = "${merge(var.default_tags, map(
        "Name", "${var.project}-${var.env}-nat-gateway",
        "Description", "${var.project} NAT Gateway"
    ))}"
  }

# Security Groups

resource "aws_security_group" "web-sg" {
  name        = "public web SG"
  description = "Public Web Security Group"
  vpc_id      = "${aws_vpc.default.id}"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(var.default_tags, map(
        "Name", "${var.project}-${var.env}-pub-security-group",
        "Description", "${var.project} Public Security Group"
    ))}"
}

#resource "aws_security_group" "openvpn-sg" {
#  name        = "public ssh SG"
#  description = "Public Web ssh Security Group"
#  vpc_id      = "${aws_vpc.default.id}"

#  ingress {
#    from_port   = 22
#    to_port     = 22
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }

#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }

#  tags = "${merge(var.default_tags, map(
#        "Name", "${var.project}-${var.project}-${var.env}-pub-security-group",
#        "Description", "${var.project} Public Security Group"
#    ))}"
#}

# Application LoadBalance

# OpenVpn Instance

#resource "aws_eip" "openvpn-instance" {
#  instance = "${aws_instance.vpn.id}"
#	vpc	= true
#}

#resource "aws_instance" "vpn" {
#  ami                         = "${var.ami_id}"
#  subnet_id                   = "${aws_subnet.public-subnet-aza.id}"
#  instance_type               = "${var.instance_type}"
#  key_name                    = "${aws_key_pair.default.id}"
#  vpc_security_group_ids      = ["${aws_security_group.openvpn-sg.id}"]
#  tags = "${merge(var.default_tags, map(
#      "Name", "${var.project}-${var.env}-openvpn",
#      "Description", "${var.project} OpenVPN"
#    ))}"
#}

#resource "aws_route53_zone" "default" {
#  name = "${var.route_zone_name}"
#  vpc_id  = "${aws_vpc.default.id}"

#  tags = "${merge(var.default_tags, map(
#      "Name", "${var.env}-route53-zone",
#      "Description", "${var.project} Route53 Zone"
#    ))}"
#}

#resource "aws_route53_record" "route53_record" {
#  zone_id = "${aws_route53_zone.default.id}"
#  name    = "openvpn"
#  type    = "A"
#  ttl     = "30"
#  records = ["${aws_instance.vpn.private_ip}"]
#}

resource "aws_key_pair" "cashbook-nonprod" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

# alb

resource "aws_lb" "public_alb" {
	name		=	"${var.project}-${var.env}-publicalb"
	internal	=	false
	security_groups	=	["${aws_security_group.web-sg.id}"]
	subnets		=	["${aws_subnet.public-subnet-aza.id}", "${aws_subnet.public-subnet-azb.id}"]
	enable_deletion_protection	=	false
}

resource "aws_lb" "private_alb" {
	name		=	"${var.project}-${var.env}-privatealb"
	internal	=	true
	security_groups	=	["${aws_security_group.web-sg.id}"]
	subnets		=	["${aws_subnet.private-subnet-aza.id}", "${aws_subnet.private-subnet-azb.id}"]
	enable_deletion_protection	=	false
}
