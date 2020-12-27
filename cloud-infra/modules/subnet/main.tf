resource "aws_subnet" "subnet" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.cidr}"
  availability_zone = "${var.az}"
  tags = "${merge(var.default_tags, map(
        "Name", "${var.project}-${var.env}-${var.name}",
        "Description", "${var.project} Database subnet"
    ))}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
}
