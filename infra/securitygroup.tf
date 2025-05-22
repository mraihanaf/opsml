resource "aws_security_group" "lb" {
	name = "${var.prefix}-sg-lb"
	description = "EKS Load Balancer Security Group Allow HTTP and HTTPS Access"

	ingress {
		description = "Allow HTTP Port Access"
		from_port = 80
		to_port = 80
		cidr_blocks = ["0.0.0.0/0"]
		ipv6_cidr_blocks = ["::/0"]
		protocol = "tcp"
	}

	ingress {
		description = "Allow HTTPS Port Access"
		from_port = 443
		to_port = 443
		cidr_blocks = ["0.0.0.0/0"]
		ipv6_cidr_blocks = ["::/0"]
		protocol = "tcp"
	}

	egress {
		description = "Allow All Network Outbound"
		from_port = 0
		to_port = 0
		cidr_blocks = ["0.0.0.0/0"]
		ipv6_cidr_blocks = ["::/0"]
		protocol = "-1"
	}

	tags = merge({
		Name = "${var.prefix}-sg-lb"
	}, local.commonTags)
}

resource "aws_security_group" "apps" {
	name = "${var.prefix}-sg-apps"
	description = "Apps Security Group Allow Port 2000"

	ingress {
		description = "Allow Port 2000"
		from_port = 2000
		to_port = 2000
		cidr_blocks = ["0.0.0.0/0"]
		ipv6_cidr_blocks = ["::/0"]
		protocol = "tcp"
	}

	tags = merge({
		Name = "${var.prefix}-sg-apps"
	}, local.commonTags)
}

