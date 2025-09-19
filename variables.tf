variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  type    = string
  default = "172.20.0.0/16"
}


variable "vpc_name" {
  type    = string
  default = "insset-ccm"
}

variable "tags" {
  type    = map(string)
  description = "Tags to apply to the resources"
  default = {}
}

variable "azs" {
  type    = map(any)
  description = "Availability Zones to deploy in vpc"
  default = {
    a = 1
    b = 2
  }
}