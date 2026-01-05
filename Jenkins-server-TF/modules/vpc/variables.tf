variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type = string
}

variable "igw_name" {
  type = string
}

variable "subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "subnet_name" {
  type = string
}

variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "rt_name" {
  type = string
}

variable "sg_name" {
  type = string
}

variable "ingress_ports" {
  type    = list(number)
  default = [22, 8080, 9000]
}
