provider "aws" {
    region = "${var.myRegion}"
}

resource "aws_vpc" "main_vpc" {
    cidr_block = "${var.myCidrBlock}"
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
    cidr_block = "${var.myCidrBlock}"
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
//        cidr_block = "${var.myIp}"
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

    ingress {
        protocol    = "-1"
//        cidr_blocks = ["${var.myIp}"]
        cidr_blocks = ["0.0.0.0/0"]
        from_port   = 0
        to_port     = 0
    }

    egress {
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
        from_port       = 0
        to_port         = 0
    }

    tags {
        Name = "main_vpc_security_group"
    }
}

// Terraform Test Ami //////////////////////////////////////////////
//resource "aws_instance" "test" {
//    ami           = "ami-43a15f3e"
//    instance_type = "t2.micro"
//    security_groups = ["${aws_default_security_group.main_vpc_security_group.id}"]
//    subnet_id = "${aws_subnet.main_vpc_subnet.id}"
//    associate_public_ip_address = true
//    key_name = "${var.myKeyPair}"
//}

resource "aws_spot_instance_request" "aws_deep_learning_custom_spot" {
    ami           = "ami-43a15f3e"
    spot_price    = "0.25"
    instance_type = "g2.2xlarge"
    security_groups = ["${aws_default_security_group.main_vpc_security_group.id}"]
    subnet_id = "${aws_subnet.main_vpc_subnet.id}"
    key_name = "${var.myKeyPair}"
    monitoring = true
    tags {
        Name = "aws_deep_learning_custom_spot"
    }
}
