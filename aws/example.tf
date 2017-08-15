provider "aws" {
  region     = "${var.region}"
}

resource "aws_vpc" "cerwinktdemo" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true

  tags {
    Name = "kitchen-terraform demo - Erwin"
  }
}

resource "aws_internet_gateway" "cerwinktdemo" {
  vpc_id = "${aws_vpc.cerwinktdemo.id}"

  tags {
    Name = "kitchen-terraform demo - Erwin"
  }
}

resource "aws_route" "cerwinktdemo" {
  route_table_id         = "${aws_vpc.cerwinktdemo.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.cerwinktdemo.id}"
}

resource "aws_subnet" "cerwinktdemo" {
  vpc_id                  = "${aws_vpc.cerwinktdemo.id}"
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "kitchen-terraform demo - Erwin"
  }
}

resource "aws_security_group" "cerwinktdemo" {
  name        = "erwin_tf_sg"
  description = "kitchen-terraform demo - Erwin"
  vpc_id      = "${aws_vpc.cerwinktdemo.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "kitchen-terraform demo - Erwin"
  }
}

resource "aws_instance" "cerwinktdemo" {
  ami                    = "${lookup(var.amis, var.region)}"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.cerwinktdemo.id}"]
  subnet_id              = "${aws_subnet.cerwinktdemo.id}"
  key_name               = "${lookup(var.key_pairs, var.region)}"

  tags {
    Name        = "kitchen-terraform demo - Erwin"
    Environment = "staging"
  }
}
