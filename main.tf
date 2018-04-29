# ----------------------------------------#
#
#       | Terraform Main file |
#
# ----------------------------------------#
# File: main.tf
# Author: Vithursan Thangarasa (vithursant)
# ----------------------------------------#

# AWS Provider
provider "aws" {
    region = "${var.my_region}"
}

resource "aws_vpc" "main_vpc" {
    cidr_block = "${var.my_cidr_block}"
    instance_tenancy = "default"
    enable_dns_hostnames = true

    tags {
        Name = "main_vpc"
    }
}

resource "aws_internet_gateway" "main_vpc_igw" {
    vpc_id = "${aws_vpc.main_vpc.id}"

    tags {
        Name = "main_vpc_igw"
    }
}

resource "aws_default_route_table" "main_vpc_default_route_table" {
    default_route_table_id = "${aws_vpc.main_vpc.default_route_table_id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main_vpc_igw.id}"
    }

    tags {
        Name = "main_vpc_default_route_table"
    }
}

resource "aws_subnet" "main_vpc_subnet" {
    vpc_id = "${aws_vpc.main_vpc.id}"
    cidr_block = "${var.my_cidr_block}"
    map_public_ip_on_launch = true

    tags {
        Name = "main_vpc_subnet"
    }
}

resource "aws_default_network_acl" "main_vpc_nacl" {
    default_network_acl_id = "${aws_vpc.main_vpc.default_network_acl_id}"
    subnet_ids = ["${aws_subnet.main_vpc_subnet.id}"]

    ingress {
        protocol   = -1
        rule_no    = 1
        action     = "allow"
//        cidr_block = "${var.my_ip}"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }

    egress {
        protocol   = -1
        rule_no    = 2
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }

    tags {
        Name = "main_vpc_nacl"
    }
}

resource "aws_default_security_group" "main_vpc_security_group" {
    vpc_id = "${aws_vpc.main_vpc.id}"

    # SSH access from anywhere
    ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = [
        "0.0.0.0/0"]
    }

    # for Jupyter notebook
    ingress {
      from_port = 8888
      to_port = 8888
      protocol = "tcp"
      cidr_blocks = [
        "0.0.0.0/0"]
    }

    # for git clone
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = [
        "0.0.0.0/0"]
    }

    tags {
        Name = "main_vpc_security_group"
    }
}

resource "aws_spot_instance_request" "aws_dl_custom_spot" {
    ami                         = "${var.ami_id}"
    spot_price                  = "${var.spot_price}"
    instance_type               = "${var.instance_type}"
    key_name                    = "${var.my_key_pair_name}"
    monitoring                  = true
    associate_public_ip_address = true
    count                       = "${var.num_instances}"
    security_groups             = ["${aws_default_security_group.main_vpc_security_group.id}"]
    subnet_id                   = "${aws_subnet.main_vpc_subnet.id}"
    ebs_block_device            = [ {
                                    device_name = "/dev/sdh"
                                    volume_size = "${var.ebs_volume_size}"
                                    volume_type = "gp2"
                                    } ]
    tags {
        Name = "aws_dl_custom_spot"
    }
}
