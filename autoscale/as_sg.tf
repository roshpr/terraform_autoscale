resource "aws_security_group" "as_sg" {
  name = "web-firewall"
  description = "proxy ports with ssh"
  vpc_id = "${var.vpc}"

  // allow traffic for TCP 22 (SSH)
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${split(",", var.vpcvar["vpc_cidr"])}"]
  }
  # elastic ports from anywhere.. we are using private ips so shouldn't
  # have people deleting our indexes just yet
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["${split(",", var.vpcvar["vpc_cidr"])}"]
  }
  // allows traffic from the SG itself for tcp
  ingress {
      from_port = 0
      to_port = 65535
      protocol = "tcp"
      self = true
  }


  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "bbl_web_security"
    deployment = "bbl"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "elb_sg" {
  name = "elb-firewall"
  description = "elb secured ports"
  vpc_id = "${var.vpc}"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${split(",", var.vpcvar["vpc_cidr"])}"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["${compact(split(",",var.vpcvar["home_networks"]))}"]
  }
  // allows traffic from the SG itself for tcp
  ingress {
      from_port = 0
      to_port = 65535
      protocol = "tcp"
      self = true
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "bbl_web_elb_security"
    deployment = "bbl"
  }

  lifecycle {
    create_before_destroy = true
  }
}

