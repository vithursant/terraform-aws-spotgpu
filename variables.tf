variable "my_region" {
  type    = "string"
  default = "us-east-1"
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
  default = "my-test"
}

variable "ssh-key-dir" {
  default     = "~/.ssh/"
  description = "Path to SSH keys - include ending '/'"
}

variable "instance_type" {
  type    = "string"
  default = "p2.xlarge"
}

variable "spot_price" {
  type    = "string"
  default = "0.30"
}

variable "ebs_volume_size" {
  type    = "string"
  default = "1"
}

variable "ami_id" {
  type    = "string"
  default = "ami-dff741a0"
}

variable "num_instances" {
  type    = "string"
  default = "2"
}
