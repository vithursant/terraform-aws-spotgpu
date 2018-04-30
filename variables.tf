# ----------------------------------------#
#
#       | Terraform Variables file |
#
# ----------------------------------------#
# File: variables.tf
# Author: Vithursan Thangarasa (vithursant)
# ----------------------------------------#

variable "my_region" {
  type    = "string"
  default = "us-east-2"
  description = "The AWS region to deploy into (i.e. us-east-1)"
}

variable "my_ip" {
  type    = "string"
  default = "161.69.22.122/32"
}

variable "my_cidr_block" {
  type    = "string"
  default = "10.0.0.0/24"
}

variable "my_key_pair_name" {
  type    = "string"
  default = "vi-test"
  description = "The name of the SSH key to install onto the instances."
}

variable "ssh-key-dir" {
  default     = "~/.ssh/"
  description = "The path to SSH keys - include ending '/'"
}

variable "instance_type" {
  type    = "string"
  default = "p2.xlarge"
  description = "The instance type to provision the instances from (i.e. p2.xlarge)."

}

variable "spot_price" {
  type    = "string"
  default = "0.30"
  description = "The maximum hourly price (bid) you are willing to pay for the specified instance, i.e. 0.10. This price should not be below AWS' minimum spot price for the instance based on the region."
}

variable "ebs_volume_size" {
  type    = "string"
  default = "1"
  description = "The Amazon EBS volume size (1 GB - 16 TB)."
}

variable "ami_id" {
  type    = "string"
  default = "ami-4c5c6e29" # Default AWS Deep Learning AMI (Ubuntu)
  description = "The AMI ID to use for each instance."
}

variable "num_instances" {
  type    = "string"
  default = "2"
  description = "The number of AWS EC2 instances to provision."
}
