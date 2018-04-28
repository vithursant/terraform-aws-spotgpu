variable "myRegion" {
  type    = "string"
  default = "us-east-1"
}

variable "myIp" {
  type    = "string"
  default = "161.69.22.122/32"
}

variable "myCidrBlock" {
  type    = "string"
  default = "10.0.0.0/24"
}

variable "myKeyPair" {
  type    = "string"
  default = "my-test"
}

variable "instanceType" {
  type    = "string"
  default = "p2.xlarge"
}

variable "spotPrice" {
  type    = "string"
  default = "0.30"
}

variable "ebsVolume" {
  type    = "string"
  default = "1"
}

variable "amiID" {
  type    = "string"
  default = "ami-dff741a0"
}

variable "numInstances" {
  type    = "string"
  default = "1"
}
