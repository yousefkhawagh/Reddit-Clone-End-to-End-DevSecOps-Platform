variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_name" {
  type = string
}

variable "igw_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "rt_name" {
  type = string
}

variable "sg_name" {
  type = string
}

variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "iam_role_name" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.large"
}

variable "key_name" {
  type = string
}
